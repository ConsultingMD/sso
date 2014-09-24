module GrndsSSO
  module ViewHelpers
    def current_user
      session['uid']
    end

    def current_customer
      session['customer_name']
    end

    def current_first_name
      session['first_name']
    end

    def current_last_name
      session['last_name']
    end

    def foobar
      "foobar"
    end
  end
end
