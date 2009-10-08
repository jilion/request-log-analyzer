module RequestLogAnalyzer

  # Mail report to a specified emailaddress
  class Mailer

    attr_accessor :data, :to, :host

    # Initialize a mailer
    # <tt>to</tt> to email address to mail to
    # <tt>host</tt> the mailer host (defaults to localhost)
    # <tt>options</tt> Specific style options
    #
    # Options
    # * <tt>:debug</tt> Do not actually mail
    # * <tt>:from_alias</tt> The from alias
    # * <tt>:to_alias</tt> The to alias
    # * <tt>:subject</tt> The message subject
    def initialize(to, host = 'localhost', options = {})
      require 'net/smtp'
      @to      = to
      @host    = host
      @options = options
      @data    = []
    end

    # Send all data in @data to the email address used during initialization.
    # Returns array containg [message_data, from_email_address, to_email_address] of sent email.
    def mail
      from        = @options[:from]        || 'contact@railsdoctors.com'
      from_alias  = @options[:from_alias]  || 'Request-log-analyzer reporter'
      to_alias    = @options[:to_alias]    || to
      subject     = @options[:subject]     || "Request log analyzer report - generated on #{Time.now.to_s}"
    msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to_alias} <#{@to}>
Subject: #{subject}

#{@data.to_s}
END_OF_MESSAGE
    
      unless @options[:debug]
        Net::SMTP.start(@host) do |smtp|
          smtp.send_message msg, from, to
        end
      end

      return [msg, from, to] 
    end

    def << string
      data << string
    end

    def puts string
      data << string
    end

  end
end