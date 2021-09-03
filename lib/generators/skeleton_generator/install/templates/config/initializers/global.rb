if defined?(Global)
  Global.backend(:filesystem, environment: Rails.env.to_s, path: Rails.root.join('config/global').to_s)
end
