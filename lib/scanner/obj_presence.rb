module Yawast
  module Scanner
    class ObjectPresence
      def self.check_source_control(uri)
        check_path(uri, '/.git/', true)
        check_path(uri, '/.hg/', true)
        check_path(uri, '/.svn/', true)
        check_path(uri, '/.bzr/', true)
      end

      def self.check_cross_domain(uri)
        check_path(uri, '/crossdomain.xml', false)
        check_path(uri, '/clientaccesspolicy.xml', false)
      end

      def self.check_wsftp_log(uri)
        #check both upper and lower, as they are both seen in the wild
        check_path(uri, '/WS_FTP.LOG', false)
        check_path(uri, '/ws_ftp.log', false)
      end

      def self.check_trace_axd(uri)
        check_path(uri, '/Trace.axd', false)
      end

      def self.check_elmah_axd(uri)
        check_path(uri, '/elmah.axd', false)
      end

      def self.check_path(uri, path, vuln)
        #note: this only checks directly at the root, I'm not sure if this is what we want
        # should probably be relative to what's passed in, instead of overriding the path.
        uri.path = "#{path}"
        code = Yawast::Shared::Http.get_status_code(uri)

        if code == "200"
          msg = "'#{path}' found: #{uri}"

          if vuln
            Yawast::Utilities.puts_vuln msg
          else
            Yawast::Utilities.puts_warn msg
          end

          puts ''
        end
      end
    end
  end
end
