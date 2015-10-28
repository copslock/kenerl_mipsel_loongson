Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2015 23:38:45 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37608 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011815AbbJ1WhztsmCO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Oct 2015 23:37:55 +0100
Received: from hauke-desktop.fritz.box (p5DE94D64.dip0.t-ipconnect.de [93.233.77.100])
        by hauke-m.de (Postfix) with ESMTPSA id 64A4B10002C;
        Wed, 28 Oct 2015 23:37:55 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        Hauke Mehrtens <hauke.mehrtens@lantiq.com>
Subject: [PATCH 03/15] MIPS: lantiq: rename CGU_SYS_VR9 register
Date:   Wed, 28 Oct 2015 23:37:32 +0100
Message-Id: <1446071865-21936-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
References: <1446071865-21936-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49745
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

This register is also used on other SoCs.

Signed-off-by: Hauke Mehrtens <hauke.mehrtens@lantiq.com>
---
 arch/mips/lantiq/xway/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lantiq/xway/clk.c b/arch/mips/lantiq/xway/clk.c
index 8750dc0..e9e0d1f 100644
--- a/arch/mips/lantiq/xway/clk.c
+++ b/arch/mips/lantiq/xway/clk.c
@@ -25,8 +25,8 @@ static unsigned int ram_clocks[] = {
 /* legacy xway clock */
 #define CGU_SYS			0x10
 
-/* vr9 clock */
-#define CGU_SYS_VR9		0x0c
+/* vr9, ar10/grx390 clock */
+#define CGU_SYS_XRX		0x0c
 #define CGU_IF_CLK_VR9		0x24
 
 unsigned long ltq_danube_fpi_hz(void)
@@ -104,7 +104,7 @@ unsigned long ltq_vr9_cpu_hz(void)
 	unsigned int cpu_sel;
 	unsigned long clk;
 
-	cpu_sel = (ltq_cgu_r32(CGU_SYS_VR9) >> 4) & 0xf;
+	cpu_sel = (ltq_cgu_r32(CGU_SYS_XRX) >> 4) & 0xf;
 
 	switch (cpu_sel) {
 	case 0:
@@ -145,7 +145,7 @@ unsigned long ltq_vr9_fpi_hz(void)
 	unsigned long clk;
 
 	cpu_clk = ltq_vr9_cpu_hz();
-	ocp_sel = ltq_cgu_r32(CGU_SYS_VR9) & 0x3;
+	ocp_sel = ltq_cgu_r32(CGU_SYS_XRX) & 0x3;
 
 	switch (ocp_sel) {
 	case 0:
-- 
2.6.1
