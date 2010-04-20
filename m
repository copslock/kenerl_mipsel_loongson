Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 02:21:50 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19806 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492648Ab0DTAUa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 02:20:30 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bccf3580004>; Mon, 19 Apr 2010 17:20:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 17:20:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 17:20:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3K0K5Rw027946;
        Mon, 19 Apr 2010 17:20:05 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3K0K5Vj027945;
        Mon, 19 Apr 2010 17:20:05 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ltt-dev@lists.casi.polymtl.ca
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/3] lttng: MIPS: Use 64 bit counter for trace clock on Octeon CPUs.
Date:   Mon, 19 Apr 2010 17:19:51 -0700
Message-Id: <1271722791-27885-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 20 Apr 2010 00:20:07.0969 (UTC) FILETIME=[3B763110:01CAE01F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Cavium Octeon CPUs have a 64-bit cycle counter that is synchronized
when the CPUs are brought on-line.  So for this case we don't need any
fancy stuff.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig                   |    4 +-
 arch/mips/include/asm/trace-clock.h |   39 ++++++++++++++++++++++++++++++++++-
 arch/mips/kernel/smp.c              |    2 +
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a690e9b..9e91e8c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1782,8 +1782,8 @@ config HAVE_GET_CYCLES_32
 	def_bool y
 	depends on !CPU_R4400_WORKAROUNDS
 	select HAVE_TRACE_CLOCK
-	select HAVE_TRACE_CLOCK_32_TO_64
-	select HAVE_UNSYNCHRONIZED_TSC
+	select HAVE_TRACE_CLOCK_32_TO_64 if (!CPU_CAVIUM_OCTEON)
+	select HAVE_UNSYNCHRONIZED_TSC if (!CPU_CAVIUM_OCTEON)
 
 #
 # Use the generic interrupt handling code in kernel/irq/:
diff --git a/arch/mips/include/asm/trace-clock.h b/arch/mips/include/asm/trace-clock.h
index 3d8cb0f..a052f42 100644
--- a/arch/mips/include/asm/trace-clock.h
+++ b/arch/mips/include/asm/trace-clock.h
@@ -12,6 +12,43 @@
 
 #define TRACE_CLOCK_MIN_PROBE_DURATION 200
 
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+
+#include <asm/octeon/octeon.h>
+
+#define TC_HW_BITS			64
+
+static inline u32 trace_clock_read32(void)
+{
+	return (u32)read_c0_cvmcount(); /* only need the 32 LSB */
+}
+
+static inline u64 trace_clock_read64(void)
+{
+	return read_c0_cvmcount();
+}
+
+static inline u64 trace_clock_frequency(void)
+{
+	return octeon_get_clock_rate();
+}
+
+static inline u32 trace_clock_freq_scale(void)
+{
+	return 1;
+}
+
+static inline void get_trace_clock(void)
+{
+	return;
+}
+
+static inline void put_trace_clock(void)
+{
+	return;
+}
+
+#else /* !CONFIG_CPU_CAVIUM_OCTEON */
 /*
  * Number of hardware clock bits. The higher order bits are expected to be 0.
  * If the hardware clock source has more than 32 bits, the bits higher than the
@@ -65,7 +102,7 @@ static inline void put_trace_clock(void)
 {
 	put_synthetic_tsc();
 }
-
+#endif /* CONFIG_CPU_CAVIUM_OCTEON */
 static inline void set_trace_clock_is_sync(int state)
 {
 }
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index f8c50d1..42083eb 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -159,7 +159,9 @@ void __init smp_cpus_done(unsigned int max_cpus)
 {
 	mp_ops->cpus_done();
 	synchronise_count_master();
+#ifdef CONFIG_HAVE_UNSYNCHRONIZED_TSC
 	test_tsc_synchronization();
+#endif
 }
 
 /* called from main before smp_init() */
-- 
1.6.6.1
