Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAL8LxL07842
	for linux-mips-outgoing; Wed, 21 Nov 2001 00:21:59 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAL8Lno07836;
	Wed, 21 Nov 2001 00:21:49 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Nov 2001 07:21:48 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id C40C6B46B; Wed, 21 Nov 2001 15:59:02 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA05072; Wed, 21 Nov 2001 15:59:02 +0900 (JST)
Date: Wed, 21 Nov 2001 16:03:47 +0900 (JST)
Message-Id: <20011121.160347.48536367.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: FP exception statistics
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Sometimes I want to know what kind of (and how many times) FP
exceptions occurred in run time.  Here is a patch to provide us these
informations via /proc/cpuinfo.

Any comments are welcome.  (This patch is not tested on SMP)

diff -ur linux-sgi-cvs/arch/mips/config.in linux.new/arch/mips/config.in
--- linux-sgi-cvs/arch/mips/config.in	Wed Nov 21 10:31:56 2001
+++ linux.new/arch/mips/config.in	Wed Nov 21 15:45:44 2001
@@ -359,6 +359,7 @@
 else
    bool 'Generate little endian code' CONFIG_CPU_LITTLE_ENDIAN
 fi
+bool 'Support for FPU Exception statistics' CONFIG_MIPS_FPE_STATS
 
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    define_bool CONFIG_KCORE_ELF y
diff -ur linux-sgi-cvs/arch/mips/kernel/proc.c linux.new/arch/mips/kernel/proc.c
--- linux-sgi-cvs/arch/mips/kernel/proc.c	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/kernel/proc.c	Wed Nov 21 15:43:24 2001
@@ -19,6 +19,10 @@
 #ifndef CONFIG_CPU_HAS_LLSC
 unsigned long ll_ops, sc_ops;
 #endif
+#ifdef CONFIG_MIPS_FPE_STATS
+unsigned int fpu_exceptions[6];
+static char fpe_types[6] = {'I', 'U', 'O', 'Z', 'V', 'E'};
+#endif
 
 /*
  * BUFFER is PAGE_SIZE bytes long.
@@ -61,6 +65,9 @@
 		mach_nec_vr41xx_names};
 	unsigned int version = read_32bit_cp0_register(CP0_PRID);
 	int len;
+#ifdef CONFIG_MIPS_FPE_STATS
+	int i;
+#endif
 
 	len = sprintf(buffer, "cpu\t\t\t: MIPS\n");
 	len += sprintf(buffer + len, "cpu model\t\t: %s V%d.%d\n",
@@ -101,6 +108,14 @@
 		       ll_ops);
 	len += sprintf(buffer + len, "sc emulations\t\t: %lu\n",
 		       sc_ops);
+#endif
+#ifdef CONFIG_MIPS_FPE_STATS
+	len += sprintf(buffer + len, "fpu exceptions\t\t:");
+	for (i = 0; i < sizeof(fpu_exceptions) / sizeof(fpu_exceptions[0]); i++) {
+		len += sprintf(buffer + len, " %u(%c)",
+			       fpu_exceptions[i], fpe_types[i]);
+	}
+	len += sprintf(buffer + len, "\n");
 #endif
 	return len;
 }
diff -ur linux-sgi-cvs/arch/mips/kernel/traps.c linux.new/arch/mips/kernel/traps.c
--- linux-sgi-cvs/arch/mips/kernel/traps.c	Wed Nov 21 10:31:57 2001
+++ linux.new/arch/mips/kernel/traps.c	Wed Nov 21 15:46:15 2001
@@ -461,6 +461,18 @@
  */
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
+#ifdef CONFIG_MIPS_FPE_STATS
+	extern unsigned int fpu_exceptions[];
+	unsigned char fpe;
+	int i;
+	fpe = ((fcr31 & FPU_CSR_ALL_X) / FPU_CSR_INE_X) &
+		((fcr31 | ~FPU_CSR_ALL_E) / FPU_CSR_INE_E);
+	for (i = 0; i < 6; i++) {
+		if (fpe & (1 << i))
+			fpu_exceptions[i]++;
+	}
+#endif
+
 	if (fcr31 & FPU_CSR_UNI_X) {
 		extern void save_fp(struct task_struct *);
 		extern void restore_fp(struct task_struct *);
---
Atsushi Nemoto
