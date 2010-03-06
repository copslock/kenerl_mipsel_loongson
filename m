Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Mar 2010 15:35:58 +0100 (CET)
Received: from www.linuxtv.org ([130.149.80.248]:34448 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492103Ab0CFOfz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Mar 2010 15:35:55 +0100
Received: from mchehab by www.linuxtv.org with local (Exim 4.69)
        (envelope-from <mchehab@linuxtv.org>)
        id 1Nnuwe-0000Ll-KD; Sat, 06 Mar 2010 15:25:32 +0100
Subject: [git:v4l-dvb/master] MIPS: Highmem: Fix build error
From:   Patch from Yoichi Yuasa <linuxtv-commits-bounces@linuxtv.org>
To:     linuxtv-commits@linuxtv.org
Data:   Sat, 20 Feb 2010 21:23:22 +0900
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1Nnuwe-0000Ll-KD@www.linuxtv.org>
Date:   Sat, 06 Mar 2010 15:25:32 +0100
Return-Path: <mchehab@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linuxtv-commits-bounces@linuxtv.org
Precedence: bulk
X-list: linux-mips

From: Yoichi Yuasa <yuasa@linux-mips.org>

arch/mips/mm/highmem.c: In function 'kmap_init':
arch/mips/mm/highmem.c:130: error: 'init_mm' undeclared (first use in this function)
arch/mips/mm/highmem.c:130: error: (Each undeclared identifier is reported only once
arch/mips/mm/highmem.c:130: error: for each function it appears in.)

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
Cc: linux-mips <linux-mips@linux-mips.org>
Patchwork: http://patchwork.linux-mips.org/patch/980/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/mm/highmem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

---

http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=52ab320ac560af3333191a473e56615fb48fff95

diff --git a/arch/mips/mm/highmem.c b/arch/mips/mm/highmem.c
index e274fda..127d732 100644
--- a/arch/mips/mm/highmem.c
+++ b/arch/mips/mm/highmem.c
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
+#include <linux/sched.h>
 #include <linux/smp.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
