Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:29:35 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55448 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011986AbaJUE2pWhnPU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:45 +0200
Received: by mail-pd0-f182.google.com with SMTP id y10so479964pdj.41
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h1VyjYP1W4lMOCprndwA4oqCS9FngUMb2ibBUXnQQE4=;
        b=lF73m4tUTGR5UYktxWb5+35ZCQbBQU+kEmHSyzleKAU7BZDhNRKlVqArprCkP5xd3j
         7RzhaXABtNm7kcPNVasarx3F9GXgs4/9KJILlxjmJ91+pb3OjmpWgbLgWzH9vIqR9b2A
         OvyVDf67k0zHZvXb0SBh5k5FqgVgWcnp6fkBuH2jd4gqwoKGXz2/hQ1Kw1brE6EMLLCS
         MVhJjFQTixsbHJzk9VDc3xwhpzHSGaC8bhWcMxhzRBr8KTMlM6UYasM6Cd3Iwn97hWI8
         LT+ezgohDHI/Wpm/e9L5pPydjqV/IxHXTAj5H2bdI2bzggeRgGs8YM9ZdkircXZ3MLHT
         3aow==
X-Received: by 10.68.224.103 with SMTP id rb7mr31585782pbc.41.1413865719233;
        Mon, 20 Oct 2014 21:28:39 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:38 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 03/17] MIPS: BMIPS: Introduce helper function to change the reset vector
Date:   Mon, 20 Oct 2014 21:27:53 -0700
Message-Id: <1413865687-15255-4-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This will need to be called from a few different places, and the logic
is starting to get a bit hairy (with the need for IPIs, CPU bug
workarounds, and hazards).

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/smp-bmips.c | 65 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 4e56911..8383fa4 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -35,6 +35,7 @@
 #include <asm/bmips.h>
 #include <asm/traps.h>
 #include <asm/barrier.h>
+#include <asm/cpu-features.h>
 
 static int __maybe_unused max_cpus = 1;
 
@@ -43,6 +44,9 @@ int bmips_smp_enabled = 1;
 int bmips_cpu_offset;
 cpumask_t bmips_booted_mask;
 
+#define RESET_FROM_KSEG0		0x80080800
+#define RESET_FROM_KSEG1		0xa0080800
+
 #ifdef CONFIG_SMP
 
 /* initial $sp, $gp - used by arch/mips/kernel/bmips_vec.S */
@@ -463,10 +467,61 @@ static inline void bmips_nmi_handler_setup(void)
 		&bmips_smp_int_vec_end);
 }
 
+struct reset_vec_info {
+	int cpu;
+	u32 val;
+};
+
+static void bmips_set_reset_vec_remote(void *vinfo)
+{
+	struct reset_vec_info *info = vinfo;
+	int shift = info->cpu & 0x01 ? 16 : 0;
+	u32 mask = ~(0xffff << shift), val = info->val >> 16;
+
+	preempt_disable();
+	if (smp_processor_id() > 0) {
+		smp_call_function_single(0, &bmips_set_reset_vec_remote,
+					 info, 1);
+	} else {
+		if (info->cpu & 0x02) {
+			/* BMIPS5200 "should" use mask/shift, but it's buggy */
+			bmips_write_zscm_reg(0xa0, (val << 16) | val);
+			bmips_read_zscm_reg(0xa0);
+		} else {
+			write_c0_brcm_bootvec((read_c0_brcm_bootvec() & mask) |
+					      (val << shift));
+		}
+	}
+	preempt_enable();
+}
+
+static void bmips_set_reset_vec(int cpu, u32 val)
+{
+	struct reset_vec_info info;
+
+	if (current_cpu_type() == CPU_BMIPS5000) {
+		/* this needs to run from CPU0 (which is always online) */
+		info.cpu = cpu;
+		info.val = val;
+		bmips_set_reset_vec_remote(&info);
+	} else {
+		void __iomem *cbr = BMIPS_GET_CBR();
+
+		if (cpu == 0)
+			__raw_writel(val, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
+		else {
+			if (current_cpu_type() != CPU_BMIPS4380)
+				return;
+			__raw_writel(val, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+		}
+	}
+	__sync();
+	back_to_back_c0_hazard();
+}
+
 void bmips_ebase_setup(void)
 {
 	unsigned long new_ebase = ebase;
-	void __iomem __maybe_unused *cbr;
 
 	BUG_ON(ebase != CKSEG0);
 
@@ -492,9 +547,7 @@ void bmips_ebase_setup(void)
 		 * 0x8000_0400: normal vectors
 		 */
 		new_ebase = 0x80000400;
-		cbr = BMIPS_GET_CBR();
-		__raw_writel(0x80080800, cbr + BMIPS_RELO_VECTOR_CONTROL_0);
-		__raw_writel(0xa0080800, cbr + BMIPS_RELO_VECTOR_CONTROL_1);
+		bmips_set_reset_vec(0, RESET_FROM_KSEG0);
 		break;
 	case CPU_BMIPS5000:
 		/*
@@ -502,10 +555,8 @@ void bmips_ebase_setup(void)
 		 * 0x8000_1000: normal vectors
 		 */
 		new_ebase = 0x80001000;
-		write_c0_brcm_bootvec(0xa0088008);
+		bmips_set_reset_vec(0, RESET_FROM_KSEG0);
 		write_c0_ebase(new_ebase);
-		if (max_cpus > 2)
-			bmips_write_zscm_reg(0xa0, 0xa008a008);
 		break;
 	default:
 		return;
-- 
2.1.1
