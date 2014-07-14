Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 11:33:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8720 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860090AbaGNJcqtECwn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 11:32:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0A55399E84E33
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 10:32:38 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:32:39 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 14 Jul 2014 10:32:39 +0100
Received: from pburton-laptop.home (192.168.79.188) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 14 Jul
 2014 10:32:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/4] MIPS: initialise MAARs
Date:   Mon, 14 Jul 2014 10:32:15 +0100
Message-ID: <1405330336-18167-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405330336-18167-1-git-send-email-paul.burton@imgtec.com>
References: <1405330336-18167-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.188]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add initialisation for Memory Accessibility Attribute Registers. Generic
code cannot know the platform-specific requirements with regards to
speculative accesses, so it simply calls a platform_maar_init function
which platforms with MAARs are expected to implement by calling the
provided write_maar_pair function & returning the number of MAAR pairs
used. A weak default implementation will simply use no MAAR pairs. Any
present but unused MAAR pairs are then marked invalid, effectively
disabling them.

The end result of this patch is that MAARs are all marked invalid, until
platforms implement the platform_maar_init function.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/maar.h | 109 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/mm/init.c          |  33 +++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 arch/mips/include/asm/maar.h

diff --git a/arch/mips/include/asm/maar.h b/arch/mips/include/asm/maar.h
new file mode 100644
index 0000000..6c62b0f
--- /dev/null
+++ b/arch/mips/include/asm/maar.h
@@ -0,0 +1,109 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __MIPS_ASM_MIPS_MAAR_H__
+#define __MIPS_ASM_MIPS_MAAR_H__
+
+#include <asm/hazards.h>
+#include <asm/mipsregs.h>
+
+/**
+ * platform_maar_init() - perform platform-level MAAR configuration
+ * @num_pairs:	The number of MAAR pairs present in the system.
+ *
+ * Platforms should implement this function such that it configures as many
+ * MAAR pairs as required, from 0 up to the maximum of num_pairs-1, and returns
+ * the number that were used. Any further MAARs will be configured to be
+ * invalid. The default implementation of this function will simply indicate
+ * that it has configured 0 MAAR pairs.
+ *
+ * Return:	The number of MAAR pairs configured.
+ */
+unsigned __weak platform_maar_init(unsigned num_pairs);
+
+/**
+ * write_maar_pair() - write to a pair of MAARs
+ * @idx:	The index of the pair (ie. use MAARs idx*2 & (idx*2)+1).
+ * @lower:	The lowest address that the MAAR pair will affect. Must be
+ *		aligned to a 2^16 byte boundary.
+ * @upper:	The highest address that the MAAR pair will affect. Must be
+ *		aligned to one byte before a 2^16 byte boundary.
+ * @attrs:	The accessibility attributes to program, eg. MIPS_MAAR_S. The
+ *		MIPS_MAAR_V attribute will automatically be set.
+ *
+ * Program the pair of MAAR registers specified by idx to apply the attributes
+ * specified by attrs to the range of addresses from lower to higher.
+ */
+static inline void write_maar_pair(unsigned idx, phys_addr_t lower,
+				   phys_addr_t upper, unsigned attrs)
+{
+	/* Addresses begin at bit 16, but are shifted right 4 bits */
+	BUG_ON(lower & (0xffff | ~(MIPS_MAAR_ADDR << 4)));
+	BUG_ON(((upper & 0xffff) != 0xffff)
+		|| ((upper & ~0xffffull) & ~(MIPS_MAAR_ADDR << 4)));
+
+	/* Automatically set MIPS_MAAR_V */
+	attrs |= MIPS_MAAR_V;
+
+	/* Write the upper address & attributes (only MIPS_MAAR_V matters) */
+	write_c0_maari(idx << 1);
+	back_to_back_c0_hazard();
+	write_c0_maar(((upper >> 4) & MIPS_MAAR_ADDR) | attrs);
+	back_to_back_c0_hazard();
+
+	/* Write the lower address & attributes */
+	write_c0_maari((idx << 1) | 0x1);
+	back_to_back_c0_hazard();
+	write_c0_maar((lower >> 4) | attrs);
+	back_to_back_c0_hazard();
+}
+
+/**
+ * struct maar_config - MAAR configuration data
+ * @lower:	The lowest address that the MAAR pair will affect. Must be
+ *		aligned to a 2^16 byte boundary.
+ * @upper:	The highest address that the MAAR pair will affect. Must be
+ *		aligned to one byte before a 2^16 byte boundary.
+ * @attrs:	The accessibility attributes to program, eg. MIPS_MAAR_S. The
+ *		MIPS_MAAR_V attribute will automatically be set.
+ *
+ * Describes the configuration of a pair of Memory Accessibility Attribute
+ * Registers - applying attributes from attrs to the range of physical
+ * addresses from lower to upper inclusive.
+ */
+struct maar_config {
+	phys_addr_t lower;
+	phys_addr_t upper;
+	unsigned attrs;
+};
+
+/**
+ * maar_config() - configure MAARs according to provided data
+ * @cfg:	Pointer to an array of struct maar_config.
+ * @num_cfg:	The number of structs in the cfg array.
+ * @num_pairs:	The number of MAAR pairs present in the system.
+ *
+ * Configures as many MAARs as are present and specified in the cfg
+ * array with the values taken from the cfg array.
+ *
+ * Return:	The number of MAAR pairs configured.
+ */
+static inline unsigned maar_config(const struct maar_config *cfg,
+				   unsigned num_cfg, unsigned num_pairs)
+{
+	unsigned i;
+
+	for (i = 0; i < min(num_cfg, num_pairs); i++)
+		write_maar_pair(i, cfg[i].lower, cfg[i].upper, cfg[i].attrs);
+
+	return i;
+}
+
+#endif /* __MIPS_ASM_MIPS_MAAR_H__ */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6e44133..571aab0 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -325,6 +325,38 @@ static inline void mem_init_free_highmem(void)
 #endif
 }
 
+unsigned __weak platform_maar_init(unsigned num_maars)
+{
+	return 0;
+}
+
+static void maar_init(void)
+{
+	unsigned num_maars, used, i;
+
+	if (!cpu_has_maar)
+		return;
+
+	/* Detect the number of MAARs */
+	write_c0_maari(~0);
+	back_to_back_c0_hazard();
+	num_maars = read_c0_maari() + 1;
+
+	/* MAARs should be in pairs */
+	WARN_ON(num_maars % 2);
+
+	/* Configure the required MAARs */
+	used = platform_maar_init(num_maars / 2);
+
+	/* Disable any further MAARs */
+	for (i = (used * 2); i < num_maars; i++) {
+		write_c0_maari(i);
+		back_to_back_c0_hazard();
+		write_c0_maar(0);
+		back_to_back_c0_hazard();
+	}
+}
+
 void __init mem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -337,6 +369,7 @@ void __init mem_init(void)
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
+	maar_init();
 	free_all_bootmem();
 	setup_zero_pages();	/* Setup zeroed pages.  */
 	mem_init_free_highmem();
-- 
2.0.1
