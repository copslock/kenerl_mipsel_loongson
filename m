Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:40:44 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37632 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011762AbbJ1Wh6ptEjO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:58 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 48D5410002A;
        Wed, 28 Oct 2015 23:37:58 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 10/15] MIPS: lantiq: add SoC detection for ar10 and grx390
Date:   Wed, 28 Oct 2015 23:37:39 +0100
Message-Id: <1446071865-21936-11-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49752
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
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h | 12 ++++++++++
 arch/mips/lantiq/xway/prom.c                       | 27 ++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index 133336b..3ab4e98 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -36,6 +36,16 @@
 #define SOC_ID_GRX288_2		0x00D /* v1.2 */
 #define SOC_ID_GRX282_2		0x00E /* v1.2 */
 
+#define SOC_ID_ARX362		0x004
+#define SOC_ID_ARX368		0x005
+#define SOC_ID_ARX382		0x007
+#define SOC_ID_ARX388		0x008
+#define SOC_ID_URX388		0x009
+#define SOC_ID_GRX383		0x010
+#define SOC_ID_GRX369		0x011
+#define SOC_ID_GRX387		0x00F
+#define SOC_ID_GRX389		0x012
+
  /* SoC Types */
 #define SOC_TYPE_DANUBE		0x01
 #define SOC_TYPE_TWINPASS	0x02
@@ -43,6 +53,8 @@
 #define SOC_TYPE_VR9		0x04 /* v1.1 */
 #define SOC_TYPE_VR9_2		0x05 /* v1.2 */
 #define SOC_TYPE_AMAZON_SE	0x06
+#define SOC_TYPE_AR10		0x07
+#define SOC_TYPE_GRX390		0x08
 
 /* BOOT_SEL - find what boot media we have */
 #define BS_EXT_ROM		0x0
diff --git a/arch/mips/lantiq/xway/prom.c b/arch/mips/lantiq/xway/prom.c
index 248429a..6f679f9 100644
--- a/arch/mips/lantiq/xway/prom.c
+++ b/arch/mips/lantiq/xway/prom.c
@@ -19,8 +19,10 @@
 #define SOC_TWINPASS	"Twinpass"
 #define SOC_AMAZON_SE	"Amazon_SE"
 #define SOC_AR9		"AR9"
-#define SOC_GR9		"GR9"
-#define SOC_VR9		"VR9"
+#define SOC_GR9		"GRX200"
+#define SOC_VR9		"xRX200"
+#define SOC_AR10	"xRX300"
+#define SOC_GRX390	"xRX330"
 
 #define COMP_DANUBE	"lantiq,danube"
 #define COMP_TWINPASS	"lantiq,twinpass"
@@ -28,6 +30,8 @@
 #define COMP_AR9	"lantiq,ar9"
 #define COMP_GR9	"lantiq,gr9"
 #define COMP_VR9	"lantiq,vr9"
+#define COMP_AR10	"lantiq,ar10"
+#define COMP_GRX390	"lantiq,grx390"
 
 #define PART_SHIFT	12
 #define PART_MASK	0x0FFFFFFF
@@ -108,6 +112,25 @@ void __init ltq_soc_detect(struct ltq_soc_info *i)
 		i->compatible = COMP_GR9;
 		break;
 
+	case SOC_ID_ARX362:
+	case SOC_ID_ARX368:
+	case SOC_ID_ARX382:
+	case SOC_ID_ARX388:
+	case SOC_ID_URX388:
+		i->name = SOC_AR10;
+		i->type = SOC_TYPE_AR10;
+		i->compatible = COMP_AR10;
+		break;
+
+	case SOC_ID_GRX383:
+	case SOC_ID_GRX369:
+	case SOC_ID_GRX387:
+	case SOC_ID_GRX389:
+		i->name = SOC_GRX390;
+		i->type = SOC_TYPE_GRX390;
+		i->compatible = COMP_GRX390;
+		break;
+
 	default:
 		unreachable();
 		break;
-- 
2.6.1
