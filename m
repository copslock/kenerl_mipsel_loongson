Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:41:54 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37645 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011839AbbJ1WiAP56KO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:38:00 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id CB0DA10002F;
        Wed, 28 Oct 2015 23:37:59 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 14/15] MIPS: lantiq: add support for xRX220 SoC
Date:   Wed, 28 Oct 2015 23:37:43 +0100
Message-Id: <1446071865-21936-15-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

From: Hauke Mehrtens <hauke.mehrtens@lantiq.com>

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h | 2 ++
 arch/mips/lantiq/xway/prom.c                        | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 3ab4e98..dd6005b 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -35,6 +35,7 @@
 #define SOC_ID_VRX268_2		0x00C /* v1.2 */
 #define SOC_ID_GRX288_2		0x00D /* v1.2 */
 #define SOC_ID_GRX282_2		0x00E /* v1.2 */
+#define SOC_ID_VRX220		0x000
 
 #define SOC_ID_ARX362		0x004
 #define SOC_ID_ARX368		0x005
@@ -55,6 +56,7 @@
 #define SOC_TYPE_AMAZON_SE	0x06
 #define SOC_TYPE_AR10		0x07
 #define SOC_TYPE_GRX390		0x08
+#define SOC_TYPE_VRX220		0x09
 
 /* BOOT_SEL - find what boot media we have */
 #define BS_EXT_ROM		0x0
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
index 6f679f9..a23b77ae 100644
--- a/arch/mips/lantiq/xway/prom.c
+++ b/arch/mips/lantiq/xway/prom.c
@@ -21,6 +21,7 @@
 #define SOC_AR9		"AR9"
 #define SOC_GR9		"GRX200"
 #define SOC_VR9		"xRX200"
+#define SOC_VRX220	"xRX220"
 #define SOC_AR10	"xRX300"
 #define SOC_GRX390	"xRX330"
 
@@ -105,6 +106,12 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 		i->compatible = COMP_VR9;
 		break;
 
+	case SOC_ID_VRX220:
+		i->name = SOC_VRX220;
+		i->type = SOC_TYPE_VRX220;
+		i->compatible = COMP_VR9;
+		break;
+
 	case SOC_ID_GRX282_2:
 	case SOC_ID_GRX288_2:
 		i->name = SOC_GR9;
-- 
2.6.1
