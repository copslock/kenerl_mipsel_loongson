Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jul 2013 19:15:07 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:3054 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835046Ab3GXROjlcJ6J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jul 2013 19:14:39 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 24 Jul 2013 09:08:34 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 24 Jul 2013 09:12:22 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 24 Jul 2013 09:12:22 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsb-10.bri.broadcom.com [10.178.7.10]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 2C753F2D72; Wed, 24
 Jul 2013 09:12:20 -0700 (PDT)
From:   "Florian Fainelli" <f.fainelli@gmail.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        blogic@openwrt.org, "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 1/2] MIPS: BMIPS: do not change interrupt routing
 depending on boot CPU
Date:   Wed, 24 Jul 2013 17:12:10 +0100
Message-ID: <1374682331-14171-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1374682331-14171-1-git-send-email-f.fainelli@gmail.com>
References: <1374682331-14171-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
X-WSS-ID: 7DF1238831W55346902-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37368
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

Commit 4df715aa ("MIPS: BMIPS: support booting from physical CPU other
than 0") changed the interupt routing when we are booting from physical
CPU 0, but the settings are actually correct if we are booting from
physical CPU 0 or CPU 1. Revert that specific change.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/kernel/smp-bmips.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index c0bb4d5..89417c9 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -79,15 +79,9 @@ static void __init bmips_smp_setup(void)
 	 * MIPS interrupts 0,1 (SW INT 0,1) cross over to the other thread
 	 * MIPS interrupt 2 (HW INT 0) is the CPU0 L1 controller output
 	 * MIPS interrupt 3 (HW INT 1) is the CPU1 L1 controller output
-	 *
-	 * If booting from TP1, leave the existing CMT interrupt routing
-	 * such that TP0 responds to SW1 and TP1 responds to SW0.
 	 */
-	if (boot_cpu == 0)
-		change_c0_brcm_cmt_intr(0xf8018000,
+	change_c0_brcm_cmt_intr(0xf8018000,
 					(0x02 << 27) | (0x03 << 15));
-	else
-		change_c0_brcm_cmt_intr(0xf8018000, (0x1d << 27));
 
 	/* single core, 2 threads (2 pipelines) */
 	max_cpus = 2;
-- 
1.8.1.2
