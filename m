Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:39:05 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37612 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011816AbbJ1Wh4JDN-O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:56 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id BA3DC10002F;
        Wed, 28 Oct 2015 23:37:55 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 04/15] MIPS: lantiq: fix pp32 clock on vr9
Date:   Wed, 28 Oct 2015 23:37:33 +0100
Message-Id: <1446071865-21936-5-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49746
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

The vendor code uses different clock values for this clock.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/clk.h      | 2 ++
 arch/mips/lantiq/xway/clk.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/clk.h b/arch/mips/lantiq/clk.h
index 77e4bdb..101afcb 100644
--- a/arch/mips/lantiq/clk.h
+++ b/arch/mips/lantiq/clk.h
@@ -31,10 +31,12 @@
 #define CLOCK_240M	240000000
 #define CLOCK_250M	250000000
 #define CLOCK_266M	266666666
+#define CLOCK_288M	288888888
 #define CLOCK_300M	300000000
 #define CLOCK_333M	333333333
 #define CLOCK_393M	393215332
 #define CLOCK_400M	400000000
+#define CLOCK_432M	432000000
 #define CLOCK_450M	450000000
 #define CLOCK_500M	500000000
 #define CLOCK_600M	600000000
diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index e9e0d1f..ba58ec8 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -174,15 +174,18 @@ unsigned long ltq_vr9_fpi_hz(void)
 
 unsigned long ltq_vr9_pp32_hz(void)
 {
-	unsigned int clksys = (ltq_cgu_r32(CGU_SYS) >> 16) & 3;
+	unsigned int clksys = (ltq_cgu_r32(CGU_SYS) >> 16) & 0x7;
 	unsigned long clk;
 
 	switch (clksys) {
+	case 0:
+		clk = CLOCK_500M;
+		break;
 	case 1:
-		clk = CLOCK_450M;
+		clk = CLOCK_432M;
 		break;
 	case 2:
-		clk = CLOCK_300M;
+		clk = CLOCK_288M;
 		break;
 	default:
 		clk = CLOCK_500M;
-- 
2.6.1
