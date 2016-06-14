module Dox
  module Printers
    class ActionPrinter < BasePrinter

      def print(action)
        @output.puts "### #{action.name}\n\n#{print_desc(action.desc)}\n\n"

        if action.uri_params.present?
          @output.puts("+ Parameters\n#{formatted_params(action.uri_params)}")
        end

        action.examples.each do |example|
          example_printer.print(example)
        end
      end

      private

      def example_printer
        @example_printer ||= ExamplePrinter.new(@output)
      end

      def formatted_params(uri_params)
        uri_params.map do |param, details|
          "    + #{CGI.escape(param.to_s)}: `#{CGI.escape(details[:value].to_s)}` (#{details[:type]}, #{details[:required]}) - #{details[:description]}"
        end.flatten.join("\n")
      end

    end
  end
end
