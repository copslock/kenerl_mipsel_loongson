Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:23:57 +0100 (CET)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:38553 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013774AbaKPATvKY4Rp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:51 +0100
Received: by mail-pa0-f51.google.com with SMTP id ey11so3038295pad.38
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HIzPcfjNLKjA8IV409QZDHlPWjZ/otITj8lSBXSigfQ=;
        b=QiJ9yQ8VSl9IQNRvpnrZ3b3OaDRgHIp+W22JcdGa2M7ZSHupW6Os9RdDwOD7BRSwoo
         8WsKA9sp2bs9iFHQgukwwaixiTQTT3XV+Ap5mFUSEX0rwsemBuLa+Mdyv7ap/bVf5utv
         PEgRzm8+0czmkCequ9Er0HyYz+SzZzWiBGmQLYz4DSomsJRNvmUdaQMr8bnQa4g+69ei
         2971XXmD66lcH/s63hIp6AdGqqB/6bKNZSfZuBpZTqNuzIfh3w1jVPkdzSMO2r01GhSf
         GlYXZ6uyNrMuZfc7OuXUgcJqgV9TnU7XPD8S0Tw/4vnchWL+/qo4hB8cLZM1WVLGcYsA
         vP7Q==
X-Received: by 10.70.62.6 with SMTP id u6mr19299087pdr.113.1416097185043;
        Sat, 15 Nov 2014 16:19:45 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:44 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 16/22] MIPS: BMIPS: Add special cache handling in c-r4k.c
Date:   Sat, 15 Nov 2014 16:17:40 -0800
Message-Id: <1416097066-20452-17-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44207
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

BMIPS435x and BMIPS438x have a single shared L1 D$ and load/store unit,
so it isn't necessary to raise IPIs to keep both CPUs coherent.

BMIPS5000 has VIPT L1 caches that handle aliases in hardware, and its I$
fills from D$.  But a special sequence with 2 SYNCs and 32 NOPs is needed
to ensure coherency.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/c-r4k.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index fbcd867..dd261df 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -917,6 +917,18 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
 	}
 }
 
+static void b5k_instruction_hazard(void)
+{
+	__sync();
+	__sync();
+	__asm__ __volatile__(
+	"       nop; nop; nop; nop; nop; nop; nop; nop\n"
+	"       nop; nop; nop; nop; nop; nop; nop; nop\n"
+	"       nop; nop; nop; nop; nop; nop; nop; nop\n"
+	"       nop; nop; nop; nop; nop; nop; nop; nop\n"
+	: : : "memory");
+}
+
 static char *way_string[] = { NULL, "direct mapped", "2-way",
 	"3-way", "4-way", "5-way", "6-way", "7-way", "8-way"
 };
@@ -1683,6 +1695,37 @@ void r4k_cache_init(void)
 
 	coherency_setup();
 	board_cache_error_setup = r4k_cache_error_setup;
+
+	/*
+	 * Per-CPU overrides
+	 */
+	switch (current_cpu_type()) {
+	case CPU_BMIPS4350:
+	case CPU_BMIPS4380:
+		/* No IPI is needed because all CPUs share the same D$ */
+		flush_data_cache_page = r4k_blast_dcache_page;
+		break;
+	case CPU_BMIPS5000:
+		/* We lose our superpowers if L2 is disabled */
+		if (c->scache.flags & MIPS_CACHE_NOT_PRESENT)
+			break;
+
+		/* I$ fills from D$ just by emptying the write buffers */
+		flush_cache_page = (void *)b5k_instruction_hazard;
+		flush_cache_range = (void *)b5k_instruction_hazard;
+		flush_cache_sigtramp = (void *)b5k_instruction_hazard;
+		local_flush_data_cache_page = (void *)b5k_instruction_hazard;
+		flush_data_cache_page = (void *)b5k_instruction_hazard;
+		flush_icache_range = (void *)b5k_instruction_hazard;
+		local_flush_icache_range = (void *)b5k_instruction_hazard;
+
+		/* Cache aliases are handled in hardware; allow HIGHMEM */
+		current_cpu_data.dcache.flags &= ~MIPS_CACHE_ALIASES;
+
+		/* Optimization: an L2 flush implicitly flushes the L1 */
+		current_cpu_data.options |= MIPS_CPU_INCLUSIVE_CACHES;
+		break;
+	}
 }
 
 static int r4k_cache_pm_notifier(struct notifier_block *self, unsigned long cmd,
-- 
2.1.1
