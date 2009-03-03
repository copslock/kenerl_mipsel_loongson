Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2009 09:05:19 +0000 (GMT)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:30336 "EHLO
	tyo202.gate.nec.co.jp") by ftp.linux-mips.org with ESMTP
	id S19202101AbZCCJFQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Mar 2009 09:05:16 +0000
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2395BWZ004166
	for <linux-mips@linux-mips.org>; Tue, 3 Mar 2009 18:05:11 +0900 (JST)
Received: from realmbox21.aps.necel.com ([10.29.19.32] [10.29.19.32]) by relay31.aps.necel.com with ESMTP; Tue, 3 Mar 2009 18:05:11 +0900
Received: from [10.114.181.78] ([10.114.181.78] [10.114.181.78]) by mbox02.aps.necel.com with ESMTP; Tue, 3 Mar 2009 18:05:11 +0900
Message-Id: <49ACF2EF.3080903@necel.com>
Date:	Tue, 03 Mar 2009 18:05:51 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: NEC VR5500 processor support fixup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Current VR5500 processor support lacks of some functions which are
expected to be configured/syhthesized on arch initialization.

Here're some VR5500A spec notes:

* all execution hazards are handled in hardware.

* Once VR5500A stops the operation of the pipeline by WAIT instruction,
  it could return from the standby mode only when either a reset, NMI
  request, or all enabled interrupts is/are detected.  In other words,
  if interrupts are disabled by Status.IE=0, it keeps in standby mode
  even when interrupts are internally asserted.

  Notes on WAIT: The operation of the processor is undefined if WAIT
  insn is in the branch delay slot.  The operation is also undefined
  if WAIT insn is executed when Status.EXL and Status.ERL are set to 1.

* VR5500A core only implements the Load prefetch.

With these changes, it boots fine.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---

Hi,

I have several EMMA2RH markeins patches in my local branch, but before
anything else, here's a VR5500 support patch.  Please review.

I'm afraid that I might put CPU_R5500 enum in incorrect position.  If
it doesn't suit for you, please let me know.

  Shinya

 arch/mips/include/asm/hazards.h  |    3 ++-
 arch/mips/include/asm/prefetch.h |    2 +-
 arch/mips/kernel/cpu-probe.c     |    1 +
 arch/mips/mm/page.c              |    3 ++-
 arch/mips/mm/tlbex.c             |    1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index 43baed1..134e1fc 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -138,7 +138,8 @@ do {									\
 		__instruction_hazard();					\
 } while (0)
 
-#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON)
+#elif defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_CAVIUM_OCTEON) || \
+      defined(CONFIG_CPU_R5500)
 
 /*
  * R10000 rocks - all hazards handled in hardware, so this becomes a nobrainer.
diff --git a/arch/mips/include/asm/prefetch.h b/arch/mips/include/asm/prefetch.h
index 1785083..b5b2103 100644
--- a/arch/mips/include/asm/prefetch.h
+++ b/arch/mips/include/asm/prefetch.h
@@ -26,7 +26,7 @@
  * Pref_WriteBackInvalidate is a nop and Pref_PrepareForStore is broken in
  * current versions due to erratum G105.
  *
- * VR7701 only implements the Load prefetch.
+ * VR5500 (including VR5701 and VR7701) only implements the Load prefetch.
  *
  * Finally MIPS32 and MIPS64 implement all of the following hints.
  */
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a7162a4..1bdbcad 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -149,6 +149,7 @@ void __init check_wait(void)
 	case CPU_R4650:
 	case CPU_R4700:
 	case CPU_R5000:
+	case CPU_R5500:
 	case CPU_NEVADA:
 	case CPU_4KC:
 	case CPU_4KEC:
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 1417c64..48060c6 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -172,8 +172,9 @@ static void __cpuinit set_prefetch_parameters(void)
 		 */
 		cache_line_size = cpu_dcache_line_size();
 		switch (current_cpu_type()) {
+		case CPU_R5500:
 		case CPU_TX49XX:
-			/* TX49 supports only Pref_Load */
+			/* These processors only support the Pref_Load. */
 			pref_bias_copy_load = 256;
 			break;
 
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 4294203..f335cf6 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -318,6 +318,7 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
 	case CPU_BCM4710:
 	case CPU_LOONGSON2:
 	case CPU_CAVIUM_OCTEON:
+	case CPU_R5500:
 		if (m4kc_tlbp_war())
 			uasm_i_nop(p);
 		tlbw(p);
