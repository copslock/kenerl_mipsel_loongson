Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBA17JI30194
	for linux-mips-outgoing; Sun, 9 Dec 2001 17:07:19 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBA173o30190
	for <linux-mips@oss.sgi.com>; Sun, 9 Dec 2001 17:07:03 -0800
Received: from excalibur.cologne.de (pD95118BC.dip.t-dialin.net [217.81.24.188])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id BAA09520
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 01:02:38 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16DE1T-00058k-00
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 01:10:19 +0100
Date: Mon, 10 Dec 2001 01:10:19 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: [PATCH] /proc/systeminfo support
Message-ID: <20011210011019.A19737@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

appended is a patch for implementing /proc/systeminfo, which shall contain
system-specific (in contast to cpu-specific) information, in particular
those parts of /proc/cpuinfo that were dropped with the 2.4.15 merge, but
are needed by the Debian installer.

Ralf, could you please check the patch in?

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="proc_systeminfo.diff"

diff -Nur /filebase/cvs-trees/oss.sgi.com/linux-2.4/linux/Documentation/Configure.help linux/Documentation/Configure.help
--- /filebase/cvs-trees/oss.sgi.com/linux-2.4/linux/Documentation/Configure.help	Sun Dec  2 12:34:33 2001
+++ linux/Documentation/Configure.help	Mon Dec 10 00:51:13 2001
@@ -14087,6 +14087,15 @@
   This option will enlarge your kernel by about 67 KB. Several
   programs depend on this, so everyone should say Y here.
 
+/proc/systeminfo support (MIPS specific)
+CONFIG_PROC_SYSTEMINFO
+  This option enables /proc/systeminfo, which gives system-specific
+  (in contrast to cpu-specific) information about the machine
+  the kernel is running on. This includes the machine type
+  (such as "DECstation 5000/1xx" and the endianess used by the
+  kernel (MIPS CPUs are bi-endian and userspace-endianess can be
+  different from kernelspace-endianess on some systems).
+
 Support for PReP Residual Data
 CONFIG_PREP_RESIDUAL
   Some PReP systems have residual data passed to the kernel by the
diff -Nur /filebase/cvs-trees/oss.sgi.com/linux-2.4/linux/fs/Config.in linux/fs/Config.in
--- /filebase/cvs-trees/oss.sgi.com/linux-2.4/linux/fs/Config.in	Sun Dec  2 12:34:53 2001
+++ linux/fs/Config.in	Mon Dec 10 00:39:44 2001
@@ -60,6 +60,7 @@
 tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS
 
 bool '/proc file system support' CONFIG_PROC_FS
+dep_mbool '  /proc/systeminfo support on MIPS' CONFIG_PROC_SYSTEMINFO $CONFIG_MIPS $CONFIG_PROC_FS
 
 dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
 dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
diff -Nur /filebase/cvs-trees/oss.sgi.com/linux-2.4/linux/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- /filebase/cvs-trees/oss.sgi.com/linux-2.4/linux/fs/proc/proc_misc.c	Sun Dec  2 12:34:55 2001
+++ linux/fs/proc/proc_misc.c	Mon Dec 10 01:01:09 2001
@@ -13,6 +13,9 @@
  * Changes:
  * Fulton Green      :  Encapsulated position metric calculations.
  *			<kernel@FultonGreen.com>
+ * Karsten Merker    :  Addition of /proc/systeminfo, function
+ *			systeminfo_read_proc
+ *			<merker@linuxtag.org>, 2001/12/09 
  */
 
 #include <linux/types.h>
@@ -40,7 +43,9 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-
+#ifdef CONFIG_PROC_SYSTEMINFO
+#include <asm/bootinfo.h>
+#endif
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
@@ -202,6 +207,65 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+
+/*
+ * /proc/systeminfo added as replacement for the information
+ * that was dropped from /proc/cpuinfo with the 2.4.15 merge.
+ * This information is needed e.g. by the Debian installer. 
+ * Based on the original /proc/cpuinfo code by Ralf Baechle 
+ * <ralf@gnu.org>, which was in arch/mips/kernel/proc.c before.
+ * Karsten Merker <merker@linuxtag.org>, 2001/12/09
+ */
+
+#ifdef CONFIG_PROC_SYSTEMINFO
+static int systeminfo_read_proc(char *page, char **start, off_t off,
+				int count, int *eof, void *data)
+{
+	int len;
+
+	const char *mach_group_names[] = GROUP_NAMES;
+	const char *mach_unknown_names[] = GROUP_UNKNOWN_NAMES;
+	const char *mach_jazz_names[] = GROUP_JAZZ_NAMES;
+	const char *mach_dec_names[] = GROUP_DEC_NAMES;
+	const char *mach_arc_names[] = GROUP_ARC_NAMES;
+	const char *mach_sni_rm_names[] = GROUP_SNI_RM_NAMES;
+	const char *mach_acn_names[] = GROUP_ACN_NAMES;
+	const char *mach_sgi_names[] = GROUP_SGI_NAMES;
+	const char *mach_cobalt_names[] = GROUP_COBALT_NAMES;
+	const char *mach_nec_ddb_names[] = GROUP_NEC_DDB_NAMES;
+	const char *mach_baget_names[] = GROUP_BAGET_NAMES;
+	const char *mach_cosine_names[] = GROUP_COSINE_NAMES;
+	const char *mach_galileo_names[] = GROUP_GALILEO_NAMES;
+	const char *mach_momenco_names[] = GROUP_MOMENCO_NAMES;
+	const char *mach_ite_names[] = GROUP_ITE_NAMES;
+	const char *mach_philips_names[] = GROUP_PHILIPS_NAMES;
+	const char *mach_globespan_names[] = GROUP_GLOBESPAN_NAMES;
+	const char *mach_sibyte_names[] = GROUP_SIBYTE_NAMES;
+	const char *mach_toshiba_names[] = GROUP_TOSHIBA_NAMES;
+	const char *mach_alchemy_names[] = GROUP_ALCHEMY_NAMES;
+	const char *mach_nec_vr41xx_names[] = GROUP_NEC_VR41XX_NAMES;
+	const char **mach_group_to_name[] = { mach_unknown_names,
+	mach_jazz_names, mach_dec_names, mach_arc_names,
+	mach_sni_rm_names, mach_acn_names, mach_sgi_names,
+	mach_cobalt_names, mach_nec_ddb_names, mach_baget_names,
+	mach_cosine_names, mach_galileo_names, mach_momenco_names,
+	mach_ite_names, mach_philips_names, mach_globespan_names,
+	mach_sibyte_names, mach_toshiba_names, mach_alchemy_names,
+	mach_nec_vr41xx_names};
+
+	len = sprintf(page, "system type             : %s %s\n", 
+			mach_group_names[mips_machgroup], 
+			mach_group_to_name[mips_machgroup][mips_machtype]);
+#if defined (__MIPSEB__)
+	len += sprintf(page + len, "kernel byteorder        : big endian\n");
+#endif
+#if defined (__MIPSEL__)
+	len += sprintf(page + len, "kernel byteorder        : little endian\n");
+#endif
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+
 extern struct seq_operations cpuinfo_op;
 static int cpuinfo_open(struct inode *inode, struct file *file)
 {
@@ -526,6 +590,9 @@
 		{"swaps",	swaps_read_proc},
 		{"iomem",	memory_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_PROC_SYSTEMINFO
+		{"systeminfo",	systeminfo_read_proc},
+#endif
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)

--qMm9M+Fa2AknHoGS--
