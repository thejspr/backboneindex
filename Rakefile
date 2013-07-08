desc "Commit the local site to the gh-pages branch and publish to GitHub Pages"
task :publish do
  sh "jekyll build"

  # Ensure the gh-pages dir exists so we can generate into it.
  puts "Checking for gh-pages dir..."
  unless File.exist?("./gh-pages")
    puts "No gh-pages directory found. Run the following commands first:"
    puts "  `git clone git@github.com:mojombo/jekyll gh-pages"
    puts "  `cd gh-pages"
    puts "  `git checkout gh-pages`"
    exit(1)
  end

  # Ensure gh-pages branch is up to date.
  Dir.chdir('gh-pages') do
    sh "git pull origin gh-pages"

    # Clear previous build
    puts "Cleaning up old build"
    sh "rm -rf *"
  end


  # Copy to gh-pages dir.
  puts "Copying site to gh-pages branch..."
  Dir.glob("_site/*") do |path|
    next if path == "_site"
    sh "cp -R #{path} gh-pages/"
  end

  # Commit and push.
  puts "Committing and pushing to GitHub Pages..."
  sha = `git log`.match(/[a-z0-9]{40}/)[0]
  Dir.chdir('gh-pages') do
    sh "git add -A"
    sh "git commit -m 'Updating to #{sha}.'"
    sh "git push origin gh-pages"
  end
  puts 'Done.'
end

task default: :publish
