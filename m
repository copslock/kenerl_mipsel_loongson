Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jun 2008 02:17:17 +0100 (BST)
Received: from jehova.dsm.dk ([80.199.102.117]:32687 "EHLO jehova.dsm.dk")
	by ftp.linux-mips.org with ESMTP id S28576718AbYFOBRN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Jun 2008 02:17:13 +0100
Received: (qmail 18150 invoked by uid 1000); 15 Jun 2008 01:17:11 -0000
Date:	Sun, 15 Jun 2008 02:17:11 +0100 (BST)
From:	Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To:	ralf@linux-mips.org
cc:	linux-mips@linux-mips.org
Subject: [PATCH] LASAT sysctl fixup
Message-ID: <Pine.LNX.4.40.0806150213050.17906-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <th@jehova.dsm.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

LASAT's sysctl interface was broken, it failed a check during boot
because a single entry had a sysctl number and the rest were
unnumbered. When I fixed it I noticed that the whole sysctl file
needed a spring clean, it was using mutexes where it wasn't needed
(it's only needed to protect during writes to the EEPROM), so I moved
that stuff out and generally cleaned the whole thing up.

So now, LASAT's sysctl/proc interface is working again.

Signed-off-by: Thomas Horsten <thomas@horsten.com>

diff -urN linux-2.6.25.6/arch/mips/lasat/lasat_board.c linux-2.6.25.6-th/arch/mips/lasat/lasat_board.c
--- linux-2.6.25.6/arch/mips/lasat/lasat_board.c	2008-06-11 10:39:29.000000000 +0100
+++ linux-2.6.25.6-th/arch/mips/lasat/lasat_board.c	2008-06-15 01:55:27.000000000 +0100
@@ -23,18 +23,19 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/mutex.h>
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
 #include "at93c.h"
 /* New model description table */
 #include "lasat_models.h"

+static DEFINE_MUTEX(lasat_eeprom_mutex);
+
 #define EEPROM_CRC(data, len) (~crc32(~0, data, len))

 struct lasat_info lasat_board_info;

-void update_bcastaddr(void);
-
 int EEPROMRead(unsigned int pos, unsigned char *data, int len)
 {
 	int i;
@@ -258,10 +259,6 @@
 			sprintf(lasat_board_info.li_typestr, "%d", 10 * c);
 	}

-#if defined(CONFIG_INET) && defined(CONFIG_SYSCTL)
-	update_bcastaddr();
-#endif
-
 	return 0;
 }

@@ -269,6 +266,8 @@
 {
 	unsigned long crc;

+	mutex_lock(&lasat_eeprom_mutex);
+
 	/* Generate the CRC */
 	crc = EEPROM_CRC((unsigned char *)(&lasat_board_info.li_eeprom_info),
 		    sizeof(struct lasat_eeprom_struct) - 4);
@@ -277,4 +276,6 @@
 	/* Write the EEPROM info */
 	EEPROMWrite(0, (unsigned char *)&lasat_board_info.li_eeprom_info,
 		    sizeof(struct lasat_eeprom_struct));
+
+	mutex_unlock(&lasat_eeprom_mutex);
 }
diff -urN linux-2.6.25.6/arch/mips/lasat/sysctl.c linux-2.6.25.6-th/arch/mips/lasat/sysctl.c
--- linux-2.6.25.6/arch/mips/lasat/sysctl.c	2008-06-11 10:39:29.000000000 +0100
+++ linux-2.6.25.6-th/arch/mips/lasat/sysctl.c	2008-06-15 01:43:16.000000000 +0100
@@ -29,15 +29,13 @@
 #include <linux/string.h>
 #include <linux/net.h>
 #include <linux/inet.h>
-#include <linux/mutex.h>
 #include <linux/uaccess.h>

 #include <asm/time.h>

-#include "sysctl.h"
+#ifdef CONFIG_DS1603
 #include "ds1603.h"
-
-static DEFINE_MUTEX(lasat_info_mutex);
+#endif

 /* Strategy function to write EEPROM after changing string entry */
 int sysctl_lasatstring(ctl_table *table, int *name, int nlen,
@@ -46,18 +44,15 @@
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	r = sysctl_string(table, name,
 			  nlen, oldval, oldlenp, newval, newlen);
-	if (r < 0) {
-		mutex_unlock(&lasat_info_mutex);
+	if (r < 0)
 		return r;
-	}
+
 	if (newval && newlen)
 		lasat_write_eeprom_info();
-	mutex_unlock(&lasat_info_mutex);

-	return 1;
+	return 0;
 }


@@ -67,14 +62,11 @@
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	r = proc_dostring(table, write, filp, buffer, lenp, ppos);
-	if ((!write) || r) {
-		mutex_unlock(&lasat_info_mutex);
+	if ((!write) || r)
 		return r;
-	}
+
 	lasat_write_eeprom_info();
-	mutex_unlock(&lasat_info_mutex);

 	return 0;
 }
@@ -85,28 +77,24 @@
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
-	if ((!write) || r) {
-		mutex_unlock(&lasat_info_mutex);
+	if ((!write) || r)
 		return r;
-	}
+
 	lasat_write_eeprom_info();
-	mutex_unlock(&lasat_info_mutex);

 	return 0;
 }

+#ifdef CONFIG_DS1603
 static int rtctmp;

-#ifdef CONFIG_DS1603
 /* proc function to read/write RealTime Clock */
 int proc_dolasatrtc(ctl_table *table, int write, struct file *filp,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	if (!write) {
 		rtctmp = read_persistent_clock();
 		/* check for time < 0 and set to 0 */
@@ -114,12 +102,11 @@
 			rtctmp = 0;
 	}
 	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
-	if ((!write) || r) {
-		mutex_unlock(&lasat_info_mutex);
+	if (r)
 		return r;
-	}
-	rtc_mips_set_mmss(rtctmp);
-	mutex_unlock(&lasat_info_mutex);
+
+	if (write)
+		rtc_mips_set_mmss(rtctmp);

 	return 0;
 }
@@ -132,17 +119,14 @@
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
-	if (r < 0) {
-		mutex_unlock(&lasat_info_mutex);
+	if (r < 0)
 		return r;
-	}
+
 	if (newval && newlen)
 		lasat_write_eeprom_info();
-	mutex_unlock(&lasat_info_mutex);

-	return 1;
+	return 0;
 }

 #ifdef CONFIG_DS1603
@@ -153,50 +137,27 @@
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	rtctmp = read_persistent_clock();
 	if (rtctmp < 0)
 		rtctmp = 0;
 	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
-	if (r < 0) {
-		mutex_unlock(&lasat_info_mutex);
+	if (r < 0)
 		return r;
-	}
 	if (newval && newlen)
 		rtc_mips_set_mmss(rtctmp);
-	mutex_unlock(&lasat_info_mutex);

-	return 1;
+	return r;
 }
 #endif

 #ifdef CONFIG_INET
-static char lasat_bcastaddr[16];
-
-void update_bcastaddr(void)
-{
-	unsigned int ip;
-
-	ip = (lasat_board_info.li_eeprom_info.ipaddr &
-		lasat_board_info.li_eeprom_info.netmask) |
-		~lasat_board_info.li_eeprom_info.netmask;
-
-	sprintf(lasat_bcastaddr, "%d.%d.%d.%d",
-			(ip)       & 0xff,
-			(ip >>  8) & 0xff,
-			(ip >> 16) & 0xff,
-			(ip >> 24) & 0xff);
-}
-
-static char proc_lasat_ipbuf[32];
-
-/* Parsing of IP address */
 int proc_lasat_ip(ctl_table *table, int write, struct file *filp,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	unsigned int ip;
 	char *p, c;
 	int len;
+	char ipbuf[32];

 	if (!table->data || !table->maxlen || !*lenp ||
 	    (*ppos && !write)) {
@@ -204,117 +165,88 @@
 		return 0;
 	}

-	mutex_lock(&lasat_info_mutex);
 	if (write) {
 		len = 0;
 		p = buffer;
 		while (len < *lenp) {
-			if (get_user(c, p++)) {
-				mutex_unlock(&lasat_info_mutex);
+			if (get_user(c, p++))
 				return -EFAULT;
-			}
 			if (c == 0 || c == '\n')
 				break;
 			len++;
 		}
-		if (len >= sizeof(proc_lasat_ipbuf)-1)
-			len = sizeof(proc_lasat_ipbuf) - 1;
-		if (copy_from_user(proc_lasat_ipbuf, buffer, len)) {
-			mutex_unlock(&lasat_info_mutex);
+		if (len >= sizeof(ipbuf)-1)
+			len = sizeof(ipbuf) - 1;
+		if (copy_from_user(ipbuf, buffer, len))
 			return -EFAULT;
-		}
-		proc_lasat_ipbuf[len] = 0;
+		ipbuf[len] = 0;
 		*ppos += *lenp;
 		/* Now see if we can convert it to a valid IP */
-		ip = in_aton(proc_lasat_ipbuf);
+		ip = in_aton(ipbuf);
 		*(unsigned int *)(table->data) = ip;
 		lasat_write_eeprom_info();
 	} else {
 		ip = *(unsigned int *)(table->data);
-		sprintf(proc_lasat_ipbuf, "%d.%d.%d.%d",
+		sprintf(ipbuf, "%d.%d.%d.%d",
 			(ip)       & 0xff,
 			(ip >>  8) & 0xff,
 			(ip >> 16) & 0xff,
 			(ip >> 24) & 0xff);
-		len = strlen(proc_lasat_ipbuf);
+		len = strlen(ipbuf);
 		if (len > *lenp)
 			len = *lenp;
 		if (len)
-			if (copy_to_user(buffer, proc_lasat_ipbuf, len)) {
-				mutex_unlock(&lasat_info_mutex);
+			if (copy_to_user(buffer, ipbuf, len))
 				return -EFAULT;
-			}
 		if (len < *lenp) {
-			if (put_user('\n', ((char *) buffer) + len)) {
-				mutex_unlock(&lasat_info_mutex);
+			if (put_user('\n', ((char *) buffer) + len))
 				return -EFAULT;
-			}
 			len++;
 		}
 		*lenp = len;
 		*ppos += len;
 	}
-	update_bcastaddr();
-	mutex_unlock(&lasat_info_mutex);

 	return 0;
 }
-#endif /* defined(CONFIG_INET) */
+#endif

-static int sysctl_lasat_eeprom_value(ctl_table *table, int *name, int nlen,
+static int sysctl_lasat_prid(ctl_table *table, int *name, int nlen,
 				     void *oldval, size_t *oldlenp,
 				     void *newval, size_t newlen)
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	r = sysctl_intvec(table, name, nlen, oldval, oldlenp, newval, newlen);
-	if (r < 0) {
-		mutex_unlock(&lasat_info_mutex);
+	if (r < 0)
 		return r;
-	}
-
 	if (newval && newlen) {
-		if (name && *name == LASAT_PRID)
-			lasat_board_info.li_eeprom_info.prid = *(int *)newval;
-
+		lasat_board_info.li_eeprom_info.prid = *(int *)newval;
 		lasat_write_eeprom_info();
 		lasat_init_board_info();
 	}
-	mutex_unlock(&lasat_info_mutex);
-
 	return 0;
 }

-int proc_lasat_eeprom_value(ctl_table *table, int write, struct file *filp,
+int proc_lasat_prid(ctl_table *table, int write, struct file *filp,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int r;

-	mutex_lock(&lasat_info_mutex);
 	r = proc_dointvec(table, write, filp, buffer, lenp, ppos);
-	if ((!write) || r) {
-		mutex_unlock(&lasat_info_mutex);
+	if (r < 0)
 		return r;
+	if (write) {
+		lasat_board_info.li_eeprom_info.prid =
+			lasat_board_info.li_prid;
+		lasat_write_eeprom_info();
+		lasat_init_board_info();
 	}
-	if (filp && filp->f_path.dentry) {
-		if (!strcmp(filp->f_path.dentry->d_name.name, "prid"))
-			lasat_board_info.li_eeprom_info.prid =
-				lasat_board_info.li_prid;
-		if (!strcmp(filp->f_path.dentry->d_name.name, "debugaccess"))
-			lasat_board_info.li_eeprom_info.debugaccess =
-				lasat_board_info.li_debugaccess;
-	}
-	lasat_write_eeprom_info();
-	mutex_unlock(&lasat_info_mutex);
-
 	return 0;
 }

 extern int lasat_boot_to_service;

-#ifdef CONFIG_SYSCTL
-
 static ctl_table lasat_table[] = {
 	{
 		.ctl_name	= CTL_UNNUMBERED,
@@ -349,8 +281,8 @@
 		.data		= &lasat_board_info.li_prid,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_lasat_eeprom_value,
-		.strategy	= &sysctl_lasat_eeprom_value
+		.proc_handler	= &proc_lasat_prid,
+		.strategy	= &sysctl_lasat_prid
 	},
 #ifdef CONFIG_INET
 	{
@@ -363,7 +295,7 @@
 		.strategy	= &sysctl_lasat_intvec
 	},
 	{
-		.ctl_name	= LASAT_NETMASK,
+		.ctl_name	= CTL_UNNUMBERED,
 		.procname	= "netmask",
 		.data		= &lasat_board_info.li_eeprom_info.netmask,
 		.maxlen		= sizeof(int),
@@ -371,15 +303,6 @@
 		.proc_handler	= &proc_lasat_ip,
 		.strategy	= &sysctl_lasat_intvec
 	},
-	{
-		.ctl_name	= CTL_UNNUMBERED,
-		.procname	= "bcastaddr",
-		.data		= &lasat_bcastaddr,
-		.maxlen		= sizeof(lasat_bcastaddr),
-		.mode		= 0600,
-		.proc_handler	= &proc_dostring,
-		.strategy	= &sysctl_string
-	},
 #endif
 	{
 		.ctl_name	= CTL_UNNUMBERED,
@@ -417,7 +340,7 @@
 		.data		= &lasat_board_info.li_namestr,
 		.maxlen		= sizeof(lasat_board_info.li_namestr),
 		.mode		= 0444,
-		.proc_handler	=  &proc_dostring,
+		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string
 	},
 	{
@@ -448,9 +371,12 @@

 	lasat_table_header =
 		register_sysctl_table(lasat_root_table);
+	if (!lasat_table_header) {
+		printk(KERN_ERR "Unable to register LASAT sysctl\n");
+		return -ENOMEM;
+	}

 	return 0;
 }

 __initcall(lasat_register_sysctl);
-#endif /* CONFIG_SYSCTL */
diff -urN linux-2.6.25.6/arch/mips/lasat/sysctl.h linux-2.6.25.6-th/arch/mips/lasat/sysctl.h
--- linux-2.6.25.6/arch/mips/lasat/sysctl.h	2008-06-11 10:39:29.000000000 +0100
+++ linux-2.6.25.6-th/arch/mips/lasat/sysctl.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,24 +0,0 @@
-/*
- * LASAT sysctl values
- */
-
-#ifndef _LASAT_SYSCTL_H
-#define _LASAT_SYSCTL_H
-
-/* /proc/sys/lasat */
-enum {
-	LASAT_CPU_HZ = 1,
-	LASAT_BUS_HZ,
-	LASAT_MODEL,
-	LASAT_PRID,
-	LASAT_IPADDR,
-	LASAT_NETMASK,
-	LASAT_BCAST,
-	LASAT_PASSWORD,
-	LASAT_SBOOT,
-	LASAT_RTC,
-	LASAT_NAMESTR,
-	LASAT_TYPESTR,
-};
-
-#endif /* _LASAT_SYSCTL_H */
