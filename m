Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Apr 2015 12:25:55 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:41257 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014482AbbDLKZ1sMkof (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Apr 2015 12:25:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 4119E28BC9D;
        Sun, 12 Apr 2015 12:24:36 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from localhost.localdomain (dslb-088-073-015-232.088.073.pools.vodafone-ip.de [88.73.15.232])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E39C928C10C;
        Sun, 12 Apr 2015 12:24:30 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hartley <James.Hartley@imgtec.com>
Subject: [PATCH RFC v3 3/4] MIPS: BMIPS: build all dtbs if no builtin dtb
Date:   Sun, 12 Apr 2015 12:25:00 +0200
Message-Id: <1428834301-12721-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
References: <1428834301-12721-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Build all available dtbs to allow them to be appended to the resulting
kernel in case there is no builtin dtb.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/boot/dts/brcm/Makefile |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 1c8353b..c641216 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -10,6 +10,19 @@ dtb-$(CONFIG_DT_BCM97362SVMB)		+= bcm97362svmb.dtb
 dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
 dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
 
+dtb-$(CONFIG_DT_NONE)			+= \
+						bcm93384wvg.dtb		\
+						bcm93384wvg_viper.dtb	\
+						bcm96368mvwg.dtb	\
+						bcm9ejtagprb.dtb	\
+						bcm97125cbmb.dtb	\
+						bcm97346dbsmb.dtb	\
+						bcm97358svmb.dtb	\
+						bcm97360svmb.dtb	\
+						bcm97362svmb.dtb	\
+						bcm97420c.dtb		\
+						bcm97425svmb.dtb
+
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 # Force kbuild to make empty built-in.o if necessary
-- 
1.7.10.4
