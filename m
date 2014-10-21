Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:31:38 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:47345 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011993AbaJUE2yhea2w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:54 +0200
Received: by mail-pa0-f54.google.com with SMTP id ey11so502016pad.41
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HIzPcfjNLKjA8IV409QZDHlPWjZ/otITj8lSBXSigfQ=;
        b=N2wBwo1saTcSZw3hFMZxJ/kzz183oqeQKNs8yMP2gs6DRVvU7aXiafrZnfWc870hfK
         OnY3rzzrd0zdCyxpCP9B6RRXqjCY7vNT4NFNHVNmiTOhz+nHU53iOV0p7L9iPBAnsZxa
         qtfKhAJXs0zDaafQ+RmzA1mfjugTbum5pGAfSa54FhpJLBeLShslhQoKe/oBjGeD65pN
         q+mDHZBoCREKeaae5ppZ79Qn+lDZP2gzA/yaMO87l8TAiom/+CL4lAegtW3jarE3m6CT
         6AulobcyqBfTszPxPHmTrbaitMsBEpz9kGchvkiUxXplXlvUmtDGEi7R6LfHuqcOg25n
         xE8Q==
X-Received: by 10.66.237.98 with SMTP id vb2mr101251pac.144.1413865728549;
        Mon, 20 Oct 2014 21:28:48 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:47 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 10/17] MIPS: BMIPS: Add special cache handling in c-r4k.c
Date:   Mon, 20 Oct 2014 21:28:00 -0700
Message-Id: <1413865687-15255-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43408
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
