Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jul 2017 09:05:13 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.135]:52185 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992289AbdGEHFDvpXE3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jul 2017 09:05:03 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.205])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2009B8EF;
        Wed,  5 Jul 2017 15:05:00 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 860283CB;
        Wed,  5 Jul 2017 15:04:58 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: james.hartley@imgtec.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <1acc75beb783f3a8eb298e17c09d97de>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 2500RYDU0E;
        Wed, 05 Jul 2017 15:04:59 +0800 (CST)
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     James Hartley <james.hartley@imgtec.com>,
        Ionela Voinescu <ionela.voinescu@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] MIPS: DTS: remove num-slots from Pistachio SoC
Date:   Wed,  5 Jul 2017 15:04:48 +0800
Message-Id: <1499238288-28914-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

dwmmc driver deprecated num-slots and plan to get rid
of it finally. Just move a step to cleanup it from DT.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/mips/boot/dts/img/pistachio.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/dts/img/pistachio.dtsi b/arch/mips/boot/dts/img/pistachio.dtsi
index 57809f6..f8d7e6f 100644
--- a/arch/mips/boot/dts/img/pistachio.dtsi
+++ b/arch/mips/boot/dts/img/pistachio.dtsi
@@ -805,7 +805,6 @@
 		pinctrl-0 = <&sdhost_pins>;
 		pinctrl-names = "default";
 		fifo-depth = <0x20>;
-		num-slots = <1>;
 		clock-frequency = <50000000>;
 		bus-width = <8>;
 		cap-mmc-highspeed;
-- 
1.9.1
