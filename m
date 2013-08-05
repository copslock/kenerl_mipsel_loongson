Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Aug 2013 12:51:06 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1839 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819547Ab3HEKu5CivTt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Aug 2013 12:50:57 +0200
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 05 Aug 2013 03:40:47 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 5 Aug 2013 03:50:41 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 5 Aug 2013 03:50:41 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 3F4F0F2D73; Mon, 5
 Aug 2013 03:50:40 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, blogic@openwrt.org, jogo@openwrt.org,
        cernekee@gmail.com, "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH] MIPS: BMIPS: fix hardware interrupt routing for boot
 CPU != 0
Date:   Mon, 5 Aug 2013 11:50:25 +0100
Message-ID: <1375699825-17576-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
X-WSS-ID: 7DE15EA52L870790655-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

From: Florian Fainelli <florian@openwrt.org>

The hardware interrupt routing for boot CPU != 0 is wrong because it
will route all the hardware interrupts to TP0 which is not the one we
booted from. Fix this by properly checking which boot CPU we are booting
from and updating the right interrupt mask for the boot CPU. This fixes
booting on BCM3368 with bmips_smp_emabled = 0.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Ralf,

This is the last fix the BMIPS SMP changes, targetted a 3.11-rc4.

 arch/mips/kernel/smp-bmips.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 159abc8..126da74 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -66,6 +66,8 @@ static void __init bmips_smp_setup(void)
 	int i, cpu = 1, boot_cpu = 0;
 
 #if defined(CONFIG_CPU_BMIPS4350) || defined(CONFIG_CPU_BMIPS4380)
+	int cpu_hw_intr;
+
 	/* arbitration priority */
 	clear_c0_brcm_cmt_ctrl(0x30);
 
@@ -80,8 +82,12 @@ static void __init bmips_smp_setup(void)
 	 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
 	 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
 	 */
-	change_c0_brcm_cmt_intr(0xf8018000,
-					(0x02 << 27) | (0x03 << 15));
+	if (boot_cpu == 0)
+		cpu_hw_intr = 0x02;
+	else
+		cpu_hw_intr = 0x1d;
+
+	change_c0_brcm_cmt_intr(0xf8018000, (cpu_hw_intr << 27) | (0x03 << 15));
 
 	/* single core, 2 threads (2 pipelines) */
 	max_cpus = 2;
-- 
1.8.1.2
