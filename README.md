# parent_paths

Handy methods for scanning parent paths.

## Installation

Include `parent_paths` in your Gemfile, or call `gem install parent_paths`.

## `ParentPaths` module

### find(start = nil, &criteria)

From the given starting path, scan upward through the file hierachy until a particular criteria is met. The criteria is determined by a block that receives the path of the next directory in the hierarchy.

If a starting path is not provided, it is assumed to be the path of the file that calls this method.

```
# Find the first ancestor directory of the current file to contain more than 5
# files
ParentPaths.find do |path|
  Dir.glob(path + '*').size > 5
end
```

### find_owner(filename, start = nil)

From the given starting path, scan upward through the file hierachy until a particular filename is discovered.

If a starting path is not provided, it is assumed to be the path of the file that calls this method.

```
# Find the first ancestor directory of the current file that contains a
# particular filename.
ParentPaths.find_owner('Gemfile')
```


