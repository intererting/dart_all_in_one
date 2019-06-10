main() {
  var regexp = RegExp("yuliyang(?=1|2)");
  regexp.allMatches("yuliyang1").forEach((match) {
    print(match.group(0));
  });
}
