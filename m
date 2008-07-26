Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 10:27:49 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.173]:52831 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20023175AbYGZJ1r (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Jul 2008 10:27:47 +0100
Received: by wf-out-1314.google.com with SMTP id 27so3579724wfd.21
        for <linux-mips@linux-mips.org>; Sat, 26 Jul 2008 02:27:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=bto7drM5+k6Zyk7hLwMdoerzgSrT5Prck1h6+7fXuoA=;
        b=rFfBWLjorPuA4Ceb/48xCuv6OpT9rTYrXwKh6SZ8lyEqLfIglQcPi/iWPb4YSLMXNW
         fgZk1wlONIWMdU+hCmnADIjFV5zbFYDA/belqbkOrMbDqyrJfJmu5sIeqkmZLzv1speh
         x/J5+0Nya9ga4ynNj0ZtvjGczDZgAxugzm03g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=GnpfI0yaEw0otOq5nz8Lk+iDF1AHxCr0yXdG2cldgnlfQT+ORt5wRjLk4CCjjxT/0q
         +3Edj3OfIgw6PSMCukQpIc0/UK0C5MqJC4xuJl+q5wwaqGig+1R1I2y6C5mdqTr12cIu
         Am+CYA4SjEF8S49j9gLXT/G8T7to9/Sz8O3SU=
Received: by 10.142.213.10 with SMTP id l10mr860392wfg.163.1217064465116;
        Sat, 26 Jul 2008 02:27:45 -0700 (PDT)
Received: by 10.142.49.17 with HTTP; Sat, 26 Jul 2008 02:27:45 -0700 (PDT)
Message-ID: <64660ef00807260227w1326e184w8fee30836f9bc915@mail.gmail.com>
Date:	Sat, 26 Jul 2008 10:27:45 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	wim@iguana.be
Subject: [PATCH] Add NXP PNX833x HW WDT support
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 9fab84fc8058dd61
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

This add support for the PNX833x HW WDT:

 Kconfig       |    9 +
 Makefile      |    1
 pnx833x_wdt.c |  266 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>

diff -urN upstream-akpm.orig/drivers/watchdog/Kconfig
upstream-akpm.watchdog/drivers/watchdog/Kconfig
--- upstream-akpm.orig/drivers/watchdog/Kconfig	2008-07-23
16:14:21.000000000 +0100
+++ upstream-akpm.watchdog/drivers/watchdog/Kconfig	2008-07-26
10:16:14.000000000 +0100
@@ -683,6 +683,15 @@
 	help
 	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.

+config PNX833X_WDT
+	tristate "PNX833x Hardware Watchdog"
+	depends on SOC_PNX8335
+	help
+	  Hardware driver for the PNX833x's watchdog. This is a
+	  watchdog timer that will reboot the machine after a programable
+	  timer has expired and no process has written to /dev/watchdog during
+	  that time.
+
 # PARISC Architecture

 # POWERPC Architecture
diff -urN upstream-akpm.orig/drivers/watchdog/Makefile
upstream-akpm.watchdog/drivers/watchdog/Makefile
--- upstream-akpm.orig/drivers/watchdog/Makefile	2008-07-23
16:14:21.000000000 +0100
+++ upstream-akpm.watchdog/drivers/watchdog/Makefile	2008-07-26
10:15:39.000000000 +0100
@@ -97,6 +97,7 @@
 obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
 obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
+obj-$(CONFIG_PNX833X_WDT) += pnx833x_wdt.o

 # PARISC Architecture

diff -urN upstream-akpm.orig/drivers/watchdog/pnx833x_wdt.c
upstream-akpm.watchdog/drivers/watchdog/pnx833x_wdt.c
--- upstream-akpm.orig/drivers/watchdog/pnx833x_wdt.c	1970-01-01
01:00:00.000000000 +0100
+++ upstream-akpm.watchdog/drivers/watchdog/pnx833x_wdt.c	2008-07-26
10:25:49.000000000 +0100
@@ -0,0 +1,266 @@
+/*
+ *  pnx833x_wdt.c: Setup PNX833X WDT.
+ *
+ *  Copyright 2008 NXP Semiconductors
+ *    Andre McCurdy <andre.mccurdy@nxp.com>
+ *    Daniel Laird <daniel.j.laird@nxp.com>
+ *
+ *  Heavily based upon - IndyDog	0.3
+ *          A Hardware Watchdog Device for SGI IP22
+ *	(c) Copyright 2002 Guido Guenther <agx@sigxcpu.org>, All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <pnx833x.h>
+
+#define PFX "pnx833x: "
+#define WATCHDOG_TIMEOUT 30		/* 30 sec Maximum timeout */
+#define WATCHDOG_COUNT_FREQUENCY 68000000U /* Watchdog counts at 68MHZ. */
+
+/** CONFIG block */
+#define PNX833X_CONFIG                      (0x07000U)
+#define PNX833X_CONFIG_CPU_WATCHDOG         (0x54)
+#define PNX833X_CONFIG_CPU_WATCHDOG_COMPARE (0x58)
+#define PNX833X_CONFIG_CPU_COUNTERS_CONTROL (0x1c)
+
+/** RESET block */
+#define PNX833X_RESET                       (0x08000U)
+#define PNX833X_RESET_CONFIG                (0x08)
+
+static int pnx833x_wdt_alive;
+
+static int pnx833x_wdt_timeout = (WATCHDOG_TIMEOUT *
WATCHDOG_COUNT_FREQUENCY);	/* in mhz */
+module_param(pnx833x_wdt_timeout, int, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in Mhz. (68Mhz clock),
default=" __MODULE_STRING(pnx833x_wdt_timeout) "(30 seconds).");
+
+static int nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static int start_enabled = 1;
+module_param(start_enabled, int, 0);
+MODULE_PARM_DESC(start_enabled, "Watchdog is started on module
insertion (default=" __MODULE_STRING(start_enabled) ")");
+
+static void pnx833x_wdt_start(void)
+{
+	/* Enable watchdog causing reset. */
+	PNX833X_REG(PNX833X_RESET + PNX833X_RESET_CONFIG) |= 0x1;
+	/* Set timeout.*/
+	PNX833X_REG(PNX833X_CONFIG + PNX833X_CONFIG_CPU_WATCHDOG_COMPARE) =
pnx833x_wdt_timeout;
+	/* Enable watchdog. */
+	PNX833X_REG(PNX833X_CONFIG + PNX833X_CONFIG_CPU_COUNTERS_CONTROL) |= 0x1;
+}
+
+static void pnx833x_wdt_stop(void)
+{
+	/* Disable watchdog causing reset. */
+	PNX833X_REG(PNX833X_RESET + PNX833X_CONFIG) &= 0xFFFFFFFE;
+	/* Disable watchdog.*/
+	PNX833X_REG(PNX833X_CONFIG + PNX833X_CONFIG_CPU_COUNTERS_CONTROL) &=
0xFFFFFFFE;
+}
+
+static void pnx833x_wdt_ping(void)
+{
+	PNX833X_REG(PNX833X_CONFIG + PNX833X_CONFIG_CPU_WATCHDOG_COMPARE) =
pnx833x_wdt_timeout;
+}
+
+/*
+ *	Allow only one person to hold it open
+ */
+static int pnx833x_wdt_open(struct inode *inode, struct file *file)
+{
+	if (pnx833x_wdt_alive)
+		return -EBUSY;
+
+	if (nowayout)
+		__module_get(THIS_MODULE);
+
+	/* Activate timer */
+	if (!start_enabled)
+		pnx833x_wdt_start();
+
