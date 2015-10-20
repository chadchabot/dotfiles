#inpired by https://github.com/cowboy/dotfiles/blob/master/link/.irbrc

require 'ap'

IRB::Irb.class_eval do
  def output_value
    ap @context.last_value
  end
end
