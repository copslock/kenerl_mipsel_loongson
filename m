Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2007 14:43:00 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:47755 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20022698AbXE2Nm6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2007 14:42:58 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l4TDh9Gp002914
	for <linux-mips@linux-mips.org>; Tue, 29 May 2007 06:43:09 -0700 (PDT)
Received: from [192.168.236.12] (cthulhu [192.168.236.12])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id l4TDgmew004802
	for <linux-mips@linux-mips.org>; Tue, 29 May 2007 06:42:49 -0700 (PDT)
Message-ID: <465C2DD8.6090208@mips.com>
Date:	Tue, 29 May 2007 15:42:48 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: SMTC Patch
Content-Type: multipart/mixed;
 boundary="------------050307040309060702090900"
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050307040309060702090900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes some problems with the linux-mips.org
2.6.21 kernel for SMTC kernels for the Malta platform.

The fix to smtc.c just eliminates a warning that crept in.

The fixes to traps.c eliminate a hypothetical problem with
out-of-bounds arguments (which were being reported, but acted
upon anyway, which was somewhat insane) and a real one with
PageMask going uninitialized in VPE 1 on any MIPS MT processor
that doesn't reset PageMask to a sane value, which the archtecture
does not require.

The restoration of the #define in mips-boards/generic/time.c
is necessary to make the Malta SMTC kernel build.  If whoever
deleted it has a good reason for it not to be done the way it's
done, that's OK, but *some* definition must be provided.

			Regards,

			Kevin K.

--------------050307040309060702090900
Content-Type: text/plain;
 name="smtc_patch_29052007"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smtc_patch_29052007"

diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
index b361edb..21eb599 100644
--- a/arch/mips/kernel/smtc.c
+++ b/arch/mips/kernel/smtc.c
@@ -611,12 +611,12 @@ void smtc_cpus_done(void)
 int setup_irq_smtc(unsigned int irq, struct irqaction * new,
 			unsigned long hwmask)
 {
+#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
 	unsigned int vpe = current_cpu_data.vpe_id;
 
-	irq_hwmask[irq] = hwmask;
-#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
 	vpemask[vpe][irq - MIPSCPU_INT_BASE] = 1;
 #endif
+	irq_hwmask[irq] = hwmask;
 
 	return setup_irq(irq, new);
 }
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 48c8b25..b42db85 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1190,10 +1190,12 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 
 		memcpy (b, &except_vec_vi, handler_len);
 #ifdef CONFIG_MIPS_MT_SMTC
-		if (n > 7)
+		if (n < 8) {
+			w = (u32 *)(b + mori_offset);
+			*w = (*w & 0xffff0000) | (0x100 << n);
+		} else {
 			printk("Vector index %d exceeds SMTC maximum\n", n);
-		w = (u32 *)(b + mori_offset);
-		*w = (*w & 0xffff0000) | (0x100 << n);
+		}
 #endif /* CONFIG_MIPS_MT_SMTC */
 		w = (u32 *)(b + lui_offset);
 		*w = (*w & 0xffff0000) | (((u32)handler >> 16) & 0xffff);
@@ -1383,6 +1385,13 @@ void __init per_cpu_trap_init(void)
 		cpu_cache_init();
 		tlb_init();
 #ifdef CONFIG_MIPS_MT_SMTC
+	} else if(!secondaryTC) {
+	/*
+	 * First TC in non-boot VPE must do subset of tlb_init()
+	 * for MMU countrol registers.
+	 */
+		write_c0_pagemask(PM_DEFAULT_MASK);
+		write_c0_wired(0);
 	}
 #endif /* CONFIG_MIPS_MT_SMTC */
 }
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index f0366af..2f73c34 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -51,6 +51,8 @@
 #include <asm/mips-boards/seadint.h>
 #endif
 
+#define CPUCTR_IMASKBIT (0x100 << MIPSCPU_INT_CPUCTR)
+
 unsigned long cpu_khz;
 
 static int mips_cpu_timer_irq;

--------------050307040309060702090900--
