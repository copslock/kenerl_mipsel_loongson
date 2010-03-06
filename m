Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Mar 2010 15:48:30 +0100 (CET)
Received: from www.linuxtv.org ([130.149.80.248]:34832 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492103Ab0CFOs0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 6 Mar 2010 15:48:26 +0100
Received: from mchehab by www.linuxtv.org with local (Exim 4.69)
        (envelope-from <mchehab@linuxtv.org>)
        id 1Nnuwe-0000Ld-Ch; Sat, 06 Mar 2010 15:25:32 +0100
Subject: [git:v4l-dvb/master] MIPS: BCM47xx: Fix 128MB RAM support
From:   Patch from Hauke Mehrtens <linuxtv-commits-bounces@linuxtv.org>
To:     linuxtv-commits@linuxtv.org
Data:   Sat, 20 Feb 2010 19:51:20 +0100
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1Nnuwe-0000Ld-Ch@www.linuxtv.org>
Date:   Sat, 06 Mar 2010 15:25:32 +0100
Return-Path: <mchehab@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linuxtv-commits-bounces@linuxtv.org
Precedence: bulk
X-list: linux-mips

From: Hauke Mehrtens <hauke@hauke-m.de>

Ignoring the last page when ddr size is 128M. Cached accesses to last page
is causing the processor to prefetch using address above 128M stepping out
of the DDR address space.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/981/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/bcm47xx/prom.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

---

http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=84a6fcb368a080620d12fc4d79e07902dbee7335

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index c51405e..29d3cbf 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -141,6 +141,14 @@ static __init void prom_init_mem(void)
 			break;
 	}
 
+	/* Ignoring the last page when ddr size is 128M. Cached
+	 * accesses to last page is causing the processor to prefetch
+	 * using address above 128M stepping out of the ddr address
+	 * space.
+	 */
+	if (mem == 0x8000000)
+		mem -= 0x1000;
+
 	add_memory_region(0, mem, BOOT_MEM_RAM);
 }
 
