From: Maarten Lankhorst <M.B.Lankhorst@gmail.com>
Date: Tue, 10 Oct 2006 13:21:42 +0200
Subject: [PATCH] bcm947xx-led-support
Message-ID: <20061010112142.K8BWy8MCZ2Z4DJm16vrdR4UJLUYcMxXy3cM7eLJ34oQ@z>

---
 drivers/net/Kconfig       |    5 +
 drivers/net/Makefile      |    1 
 drivers/net/diag/Makefile |    5 +
 drivers/net/diag/diag.c   |  283 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+), 0 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 414b949..b2e8775 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -60,6 +60,11 @@ config DUMMY
 	  Instead of 'dummy', the devices will then be called 'dummy0',
 	  'dummy1' etc.
 
+config DIAG_LED
+	tristate "Led driver for Broadcom BCM97xx"
+	---help---
+	  Say 'Y' or 'M' if you like the leds to signal status of operation.
+
 config BONDING
 	tristate "Bonding driver support"
 	depends on INET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 0c08ede..9ab7bc9 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for the Linux network (ethercard) device drivers.
 #
+obj-$(CONFIG_DIAG_LED) += diag/
 
 obj-$(CONFIG_E1000) += e1000/
 obj-$(CONFIG_IBM_EMAC) += ibm_emac/
diff --git a/drivers/net/diag/Makefile b/drivers/net/diag/Makefile
new file mode 100644
index 0000000..f87a62d
--- /dev/null
+++ b/drivers/net/diag/Makefile
@@ -0,0 +1,5 @@
+#$Id$
+
+EXTRA_CFLAGS := -I$(TOPDIR)/arch/mips/bcm947xx/include -DBCMDRIVER
+
+obj-$(CONFIG_DIAG_LED) += diag.o
diff --git a/drivers/net/diag/diag.c b/drivers/net/diag/diag.c
new file mode 100644
index 0000000..09bb8a9
--- /dev/null
+++ b/drivers/net/diag/diag.c
@@ -0,0 +1,283 @@
+/*
+ * diag_led.c - replacement diag module
+ *
+ * Copyright (C) 2004 Mike Baker,
+ *                    Imre Kaloz <kaloz@dune.hu>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * $Id$
+ */
+
+/*
+ * ChangeLog:
+ * 2004/03/28 initial release 
+ * 2004/08/26 asus & buffalo support added
+ * 2005/03/14 asus wl-500g deluxe and buffalo v2 support added
+ * 2005/04/13 added licensing informations
+ * 2005/04/18 base reset polarity off initial readings
+ * 2006/02/07 motorola wa840g/we800g support added
+ * 2006/08/18 asus power led support added
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sysctl.h>
+#include <asm/io.h>
+#include <linux/types.h>
+#include <osl.h>
+#include <bcmdevs.h>
+#include <sbutils.h>
+
+extern char * nvram_get(const char *name);
+static void *sbh;
+
+// v2.x - - - - -
+#define DIAG_GPIO (1<<1)
+#define DMZ_GPIO  (1<<7)
+
+static void set_gpio(uint32_t mask, uint32_t value) {
+	sb_gpiocontrol(sbh,mask, 0, GPIO_DRV_PRIORITY);
+	sb_gpioouten(sbh,mask,mask,GPIO_DRV_PRIORITY);
+	sb_gpioout(sbh,mask,value,GPIO_DRV_PRIORITY);
+}
+
+static void v2_set_diag(u8 state) {
+	set_gpio(DIAG_GPIO,state);
+}
+static void v2_set_dmz(u8 state) {
+	set_gpio(DMZ_GPIO,state);
+}
+
+// asus wl-500g (+deluxe)
+#define ASUS_PWR_GPIO (1<<0)
+
+static void asus_set_pwr(u8 state) {
+	set_gpio(ASUS_PWR_GPIO,state);
+}
+
+// v1.x - - - - -
+#define LED_DIAG   0x13
+#define LED_DMZ    0x12
+
+static void v1_set_diag(u8 state) {
+	if (!state) {
+		*(volatile u8*)(KSEG1ADDR(BCM4710_EUART)+LED_DIAG)=0xFF;
+	} else {
+		*(volatile u8*)(KSEG1ADDR(BCM4710_EUART)+LED_DIAG);
+	}
+}
+static void v1_set_dmz(u8 state) {
+	if (!state) {
+		*(volatile u8*)(KSEG1ADDR(BCM4710_EUART)+LED_DMZ)=0xFF;
+	} else {
+		*(volatile u8*)(KSEG1ADDR(BCM4710_EUART)+LED_DMZ);
+	}
+}
+
+static void wap1_set_diag(u8 state) {
+       set_gpio(1<<3,state);
+}
+static void wap1_set_dmz(u8 state) {
+       set_gpio(1<<4,state);
+}
+
+// - - - - -
+static void ignore(u8 ignored) {};
+
+// - - - - -
+#define BIT_DMZ         0x01
+#define BIT_PWR		0x02
+#define BIT_DIAG        0x04
+
+void (*set_diag)(u8 state);
+void (*set_dmz)(u8 state);
+void (*set_pwr)(u8 state);
+
+static unsigned int diag = 0x02; // default: diag off, pwr on, dmz off
+
+static void diag_change(void)
+{
+	set_diag(0xFF); // off
+	set_dmz(0xFF); // off
+	set_pwr(0xFF); // off
+
+	if(diag & BIT_DIAG)
+		set_diag(0x00); // on
+	if(diag & BIT_DMZ)
+		set_dmz(0x00); // on
+	if (diag & BIT_PWR)
+		set_pwr(0x00);	//on
+}
+
+static int proc_diag(ctl_table *table, int write, struct file *filp,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int r;
+	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
+	if (write && !r) {
+		diag_change();
+	}
+	return r;
+}
+
+// - - - - -
+static unsigned char reset_gpio = 0;
+static unsigned char reset_polarity = 0;
+static unsigned int reset = 0;
+
+static int proc_reset(ctl_table *table, int write, struct file *filp,
+		void *buffer, size_t *lenp, loff_t *ppos)
+{
+
+	if (reset_gpio) {
+		sb_gpiocontrol(sbh,reset_gpio,reset_gpio,GPIO_DRV_PRIORITY);
+		sb_gpioouten(sbh,reset_gpio,0,GPIO_DRV_PRIORITY);
+		reset=!(sb_gpioin(sbh)&reset_gpio);
+
+		if (reset_polarity) reset=!reset;
+	} else {
+		reset=0;
+	}
+
+	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
+}
+
+// - - - - -
+static struct ctl_table_header *diag_sysctl_header;
+
+static ctl_table sys_diag[] = {
+         { 
+	   ctl_name: 2000,
+	   procname: "diag", 
+	   data: &diag,
+	   maxlen: sizeof(diag), 
+	   mode: 0644,
+	   proc_handler: proc_diag
+	 },
+	 {
+	   ctl_name: 2001,
+	   procname: "reset",
+	   data: &reset,
+	   maxlen: sizeof(reset),
+	   mode: 0444,
+	   proc_handler: proc_reset 
+	 },
+         { 0 }
+};
+
+static int __init diag_init(void)
+{
+	char *buf;
+	u32 board_type;
+	sbh = (void *)sb_kattach();
+	sb_gpiosetcore(sbh);
+
+	board_type = sb_boardtype(sbh);
+	printk(KERN_INFO "diag boardtype: %08x\n",board_type);
+
+	set_diag=ignore;
+	set_dmz=ignore;
+	set_pwr=ignore;
+	
+	buf=nvram_get("pmon_ver") ?: "";
+	if (((board_type & 0xf00) == 0x400) && (strncmp(buf, "CFE", 3) != 0)) {
+		buf=nvram_get("boardtype")?:"";
+		if (!strncmp(buf,"bcm94710dev",11)) {
+			buf=nvram_get("boardnum")?:"";
+			if (!strcmp(buf,"42")) {
+				// wrt54g v1.x
+				set_diag=v1_set_diag;
+				set_dmz=v1_set_dmz;
+				reset_gpio=(1<<6);
+			}
+			if (simple_strtoul(buf, NULL, 0) == 2) {
+				// wap54g v1.0
+				// do not use strcmp as PMON v5.3.22 has some built-in nvram 
+				// defaults with trailing \r
+				set_diag=wap1_set_diag;
+				// no dmz led on wap54g, used green led 
+				// labeled "WLAN Link" instead
+				set_dmz=wap1_set_dmz;
+				reset_gpio=(1<<0);
+			}
+			if (!strcmp(buf,"asusX")) {
+				//asus wl-500g
+				set_pwr=asus_set_pwr;
+				reset_gpio=(1<<6);
+			}
+			if (!strcmp(buf,"2")) {
+				//wa840g v1 / we800g v1
+				reset_gpio=(1<<0);
+			}
+		}
+		if (!strcmp(buf,"bcm94710ap")) {
+			buf=nvram_get("boardnum")?:"";
+			if (!strcmp(buf,"42")) {
+				// buffalo
+				set_dmz=v2_set_dmz;
+				reset_gpio=(1<<4);
+			}
+			if (!strcmp(buf,"44")) {
+				//dell truemobile
+				set_dmz=v2_set_dmz;
+				reset_gpio=(1<<0);
+			}
+		}
+	} else {
+		buf=nvram_get("boardnum")?:"";
+		if (!strcmp(buf,"42")) {
+			//linksys
+			set_diag=v2_set_diag;
+			set_dmz=v2_set_dmz;
+			reset_gpio=(1<<6);
+		}
+		if (!strcmp(buf,"44")) {
+			//motorola
+			reset_gpio=(1<<5);
+		}
+		if (!strcmp(buf,"00")) {
+			//buffalo
+			reset_gpio=(1<<7);
+		}
+		if (!strcmp(buf,"45")) {
+			//wl-500g deluxe
+			set_pwr=asus_set_pwr;
+			reset_gpio=(1<<6);
+		}
+	}
+
+	
+	sb_gpiocontrol(sbh,reset_gpio,reset_gpio,GPIO_DRV_PRIORITY);
+	sb_gpioouten(sbh,reset_gpio,0,GPIO_DRV_PRIORITY);
+	reset_polarity=!(sb_gpioin(sbh)&reset_gpio);
+
+	diag_sysctl_header = register_sysctl_table(sys_diag, 0);
+	diag_change();
+
+	return 0;
+}
+
+static void __exit diag_exit(void)
+{
+	unregister_sysctl_table(diag_sysctl_header);
+}
+
+MODULE_AUTHOR("openwrt.org");
+MODULE_LICENSE("GPL");
+
+module_init(diag_init);
+module_exit(diag_exit);
-- 
1.4.1
