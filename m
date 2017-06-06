From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:16:30 +0200
Subject: mips: sgi-ip22: ecard: use dev_groups and not dev_attrs for bus_type
Message-ID: <20170606121630.em93OJTHpkk0wKxScx-0UGU77z5f9upRpCV69NU_Ti0@z>

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/sgi-ip22/ip22-gio.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index cdf187600010..b225033aade6 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -169,6 +169,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 
 	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
+static DEVICE_ATTR_RO(modalias);
 
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
@@ -178,6 +179,7 @@ static ssize_t name_show(struct device *dev,
 	giodev = to_gio_device(dev);
 	return sprintf(buf, "%s", giodev->name);
 }
+static DEVICE_ATTR_RO(name);
 
 static ssize_t id_show(struct device *dev,
 		       struct device_attribute *attr, char *buf)
@@ -187,13 +189,15 @@ static ssize_t id_show(struct device *dev,
 	giodev = to_gio_device(dev);
 	return sprintf(buf, "%x", giodev->id.id);
 }
+static DEVICE_ATTR_RO(id);
 
-static struct device_attribute gio_dev_attrs[] = {
-	__ATTR_RO(modalias),
-	__ATTR_RO(name),
-	__ATTR_RO(id),
-	__ATTR_NULL,
+static struct attribute *gio_dev_attrs[] = {
+	&dev_attr_modalias.attr,
+	&dev_attr_name.attr,
+	&dev_attr_id.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(gio_dev);
 
 static int gio_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
@@ -374,7 +378,7 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 
 static struct bus_type gio_bus_type = {
 	.name	   = "gio",
-	.dev_attrs = gio_dev_attrs,
+	.dev_groups = gio_dev_groups,
 	.match	   = gio_bus_match,
 	.probe	   = gio_device_probe,
 	.remove	   = gio_device_remove,
-- 
2.13.1
