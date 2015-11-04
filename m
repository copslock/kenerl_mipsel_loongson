Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 13:14:58 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:40383 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011421AbbKDMO1j3evc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Nov 2015 13:14:27 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 20AB328098D;
        Wed,  4 Nov 2015 13:12:37 +0100 (CET)
Received: from localhost.localdomain (p548C90D8.dip0.t-ipconnect.de [84.140.144.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed,  4 Nov 2015 13:12:37 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 3/4] arch: mips: lantiq: force the crossbar to big endian
Date:   Wed,  4 Nov 2015 13:14:15 +0100
Message-Id: <1446639256-22526-3-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1446639256-22526-1-git-send-email-blogic@openwrt.org>
References: <1446639256-22526-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/xway/reset.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
index 7b3e48b..078fadf 100644
--- a/arch/mips/lantiq/xway/reset.c
+++ b/arch/mips/lantiq/xway/reset.c
@@ -33,6 +33,10 @@
 #define RCU_GFS_ADD0_XRX200	0x0020
 #define RCU_GFS_ADD1_XRX200	0x0068
 
+/* xbar BE flag */
+#define RCU_AHB_ENDIAN          0x004C
+#define RCU_VR9_BE_AHB1S        0x00000008
+
 /* reboot bit */
 #define RCU_RD_GPHY0_XRX200	BIT(31)
 #define RCU_RD_SRST		BIT(30)
@@ -297,6 +301,10 @@ static int __init mips_reboot_setup(void)
 	    of_machine_is_compatible("lantiq,vr9"))
 		ltq_usb_init();
 
+	if (of_machine_is_compatible("lantiq,vr9"))
+		ltq_rcu_w32(ltq_rcu_r32(RCU_AHB_ENDIAN) | RCU_VR9_BE_AHB1S,
+			    RCU_AHB_ENDIAN);
+
 	_machine_restart = ltq_machine_restart;
 	_machine_halt = ltq_machine_halt;
 	pm_power_off = ltq_machine_power_off;
-- 
1.7.10.4
