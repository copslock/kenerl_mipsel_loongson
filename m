Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 23:11:03 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:51553 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeDYVK5MXR-v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Apr 2018 23:10:57 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 582C32071D; Wed, 25 Apr 2018 23:10:51 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 307BA200FB;
        Wed, 25 Apr 2018 23:10:41 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] mips: xilfpga: stop generating useless dtb.o
Date:   Wed, 25 Apr 2018 23:10:35 +0200
Message-Id: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

a dtb.o is generated from nexys4ddr.dts but this is never used since it has
been moved to mips/generic with commit b35565bb16a5 ("MIPS: generic: Add support
for MIPSfpga")

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/boot/dts/xilfpga/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 9987e0e378c5..69ca00590b8d 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
-
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-- 
2.17.0
