Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 11:55:36 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:51922 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823002Ab3HHJzalWuLe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 11:55:30 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: [PATCH 1/2] pinctrl/lantiq: add missing pin definition to falocn pinctrl driver
Date:   Thu,  8 Aug 2013 11:48:19 +0200
Message-Id: <1375955300-31682-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37454
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

From: Thomas Langer <thomas.langer@lantiq.com>

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 drivers/pinctrl/pinctrl-falcon.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-falcon.c b/drivers/pinctrl/pinctrl-falcon.c
index f9b2a1d..4e731f2 100644
--- a/drivers/pinctrl/pinctrl-falcon.c
+++ b/drivers/pinctrl/pinctrl-falcon.c
@@ -75,6 +75,7 @@ enum falcon_mux {
 	FALCON_MUX_GPIO = 0,
 	FALCON_MUX_RST,
 	FALCON_MUX_NTR,
+	FALCON_MUX_PPS,
 	FALCON_MUX_MDIO,
 	FALCON_MUX_LED,
 	FALCON_MUX_SPI,
@@ -114,7 +115,7 @@ static struct ltq_mfp_pin falcon_mfp[] = {
 	MFP_FALCON(GPIO2,	GPIO,	GPIO,   NONE,   NONE),
 	MFP_FALCON(GPIO3,	GPIO,	GPIO,   NONE,   NONE),
 	MFP_FALCON(GPIO4,	NTR,	GPIO,   NONE,   NONE),
-	MFP_FALCON(GPIO5,	NTR,	GPIO,   NONE,   NONE),
+	MFP_FALCON(GPIO5,	NTR,	GPIO,   PPS,    NONE),
 	MFP_FALCON(GPIO6,	RST,	GPIO,   NONE,   NONE),
 	MFP_FALCON(GPIO7,	MDIO,	GPIO,   NONE,   NONE),
 	MFP_FALCON(GPIO8,	MDIO,	GPIO,   NONE,   NONE),
@@ -168,6 +169,7 @@ static struct ltq_mfp_pin falcon_mfp[] = {
 static const unsigned pins_por[] = {GPIO0};
 static const unsigned pins_ntr[] = {GPIO4};
 static const unsigned pins_ntr8k[] = {GPIO5};
+static const unsigned pins_pps[] = {GPIO5};
 static const unsigned pins_hrst[] = {GPIO6};
 static const unsigned pins_mdio[] = {GPIO7, GPIO8};
 static const unsigned pins_bled[] = {GPIO9, GPIO10, GPIO11,
@@ -186,6 +188,7 @@ static struct ltq_pin_group falcon_grps[] = {
 	GRP_MUX("por", RST, pins_por),
 	GRP_MUX("ntr", NTR, pins_ntr),
 	GRP_MUX("ntr8k", NTR, pins_ntr8k),
+	GRP_MUX("pps", PPS, pins_pps),
 	GRP_MUX("hrst", RST, pins_hrst),
 	GRP_MUX("mdio", MDIO, pins_mdio),
 	GRP_MUX("bootled", LED, pins_bled),
@@ -201,7 +204,7 @@ static struct ltq_pin_group falcon_grps[] = {
 };
 
 static const char * const ltq_rst_grps[] = {"por", "hrst"};
-static const char * const ltq_ntr_grps[] = {"ntr", "ntr8k"};
+static const char * const ltq_ntr_grps[] = {"ntr", "ntr8k", "pps"};
 static const char * const ltq_mdio_grps[] = {"mdio"};
 static const char * const ltq_bled_grps[] = {"bootled"};
 static const char * const ltq_asc_grps[] = {"asc0", "asc1"};
-- 
1.7.10.4
