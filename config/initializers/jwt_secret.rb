JWT_SECRET = YAML.load_file(Rails.root.join("config", "jwt_secret.yml"))[Rails.env]["secret_key"]
