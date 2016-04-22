Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 19:20:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56901 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027308AbcDVRTij1Y6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 19:19:38 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 3E84DFBD1CB63;
        Fri, 22 Apr 2016 18:19:29 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:32 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:32 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] MIPS: malta-time: Don't use PIT timer for cevt/csrc
Date:   Fri, 22 Apr 2016 18:19:16 +0100
Message-ID: <1461345557-2763-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
References: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The PIT timer is slow, especially under virtualisation, compared with
the r4k timer, and doesn't really provide any advantage on Malta since
it doesn't support clock scaling (which is where the PIT has an
advantage).

Drop the use of the PIT timer on Malta so that the r4k or GIC timer will
be used in preference.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig                | 1 -
 arch/mips/mti-malta/malta-time.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2018c2b0e078..c9a0c70334ce 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -442,7 +442,6 @@ config MIPS_MALTA
 	select IRQ_MIPS_CPU
 	select MIPS_GIC
 	select HW_HAS_PCI
-	select I8253
 	select I8259
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 7407da04f8d6..82dd1ea6d630 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -18,7 +18,6 @@
  * Setting up the clock on the MIPS boards.
  */
 #include <linux/types.h>
-#include <linux/i8253.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
 #include <linux/math64.h>
@@ -225,11 +224,6 @@ void __init plat_time_init(void)
 
 	mips_scroll_message();
 
-#ifdef CONFIG_I8253
-	/* Only Malta has a PIT. */
-	setup_pit_timer();
-#endif
-
 #ifdef CONFIG_MIPS_GIC
 	if (gic_present) {
 		freq = freqround(gic_frequency, 5000);
-- 
2.4.10
