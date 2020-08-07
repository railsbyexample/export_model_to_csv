# Export model to CSV

Using `ActiveJob` and `ActiveStorage`

## Motivation

You might want to provide a way for your users to export their data. The simplest way to do this is to let them download a CSV file with the data. It is easy to serialize a model into this format in Ruby and it's easy to open and edit for the users. Also, it is fair to let users own the data they generate in your application.

## Overview

The application consists on two views: a list of all "users", and a history of CSV exports. There is an export button that exports the whole list of users (`User.all`) to a CSV. The export button POSTs to the `CsvExportsController` which creates a `CsvExport` (which simply holds the status of the process, and eventually the attachment) and enqueues a `CsvExportJob` for this new record, which does the actual effort.

## Extending

You could follow this same pattern to export whatever model you have in your application.

You could also extend this code by storing some filtering params provided by the user in the `CsvExport` model and filtering the model with it.

If you have an authenticated user in your application, you could link the `CsvExport` to the user, and then on `CsvExportJob`, export only the records belonging to the user.

You could combine this with S3's [upload_stream](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/S3/Object.html#upload_stream-instance_method) to write the content directly to S3 instead of holding it in memory.

## The gist

The job (`CsvExportJob`) writes all the records to a CSV file:

```ruby
# app/jobs/process_run_job.rb

class CsvExportJob < ApplicationJob
  def perform(csv_export)
    # ...

    csv_export.file.attach \
      io: StringIO.new(csv_content),
      filename: filename

    csv_export.finish!
  end
  # ...

  COLUMNS = %w[id name email].freeze

  def csv_content
    CSV.generate(headers: true) do |csv|
      csv << COLUMNS
      users.each { |user| csv << user.attributes.slice(*COLUMNS) }
    end
  end
end
```

## Testing

This example (like hopefully all in [railsbyexample](https://github.com/railsbyexample)) is reasonably tested, don't forget to check out the `spec` directory, and write some tests for your own code!

## Contributing

Feel free to open a PR, Issue, or [contact me](https://perezperret.com), to suggest improvements or discuss any problems, errors or opinions.
