locals {
  alumni_id = "${var.prefix}-${var.environment}"
  tags = {
    "course" = "${var.prefix}"
    "user"   = "${var.environment}"
  }
}
