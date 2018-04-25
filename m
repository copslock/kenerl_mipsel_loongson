Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2018 23:11:17 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:51557 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993997AbeDYVK5Uldev (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Apr 2018 23:10:57 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A5EA3206A0; Wed, 25 Apr 2018 23:10:51 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 799E02038E;
        Wed, 25 Apr 2018 23:10:41 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] mips: xilfpga: actually include FDT in fitImage
Date:   Wed, 25 Apr 2018 23:10:36 +0200
Message-Id: <20180425211036.28509-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
References: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63784
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

Commit b35565bb16a5 ("MIPS: generic: Add support for MIPSfpga") added and
its.S file for xilfpga but forgot to add it to arch/mips/generic/Platform
so it is never used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/mips/generic/Platform | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index b51432dd10b6..0dd0d5d460a5 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -16,3 +16,4 @@ all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
 its-y					:= vmlinux.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= board-boston.its.S
 its-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= board-ni169445.its.S
+its-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= board-xilfpga.its.S
-- 
2.17.0
