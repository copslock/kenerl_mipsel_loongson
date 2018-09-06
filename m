Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2018 22:45:41 +0200 (CEST)
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:55504 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994644AbeIFUojqXz-Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2018 22:44:39 +0200
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 7698630C050;
        Thu,  6 Sep 2018 13:44:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 7698630C050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1536266676;
        bh=144KIBZrtmLDsXDOrAg3hFTHOfFFmEI6kfwR97dUkpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoS4cxZiCyyYgRkX+mGo13OIunb8ziJgzQLXc1QTRUEqJwFK13AX4pE2SdF8Iz4Bs
         gfaepYsbVU3mFyEClQY9lAZtMJ8IlkepLSsqQHa/4guBGyc4/aBM2a71ePj7/pKsOZ
         4BY0XwDPvon3S+lrP9SQdRa5XGp9DYY73DrxxR2c=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 389A5AC071C;
        Thu,  6 Sep 2018 13:44:32 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Tony Lindgren <tony@atomide.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Justin Chen <justinpopo6@gmail.com>,
        Markus Mayer <markus.mayer@broadcom.com>,
        Gareth Powell <gpowell@broadcom.com>,
        Doug Berger <opendmb@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 10/12] ARM64: declare __phys_to_dma on ARCH_HAS_PHYS_TO_DMA
Date:   Thu,  6 Sep 2018 16:42:59 -0400
Message-Id: <1536266581-7308-11-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

This change allows one to define custom routines for __phys_to_dma()
and __dma_to_phys() for the ARM64 architecture by selecting
ARCH_HAS_PHYS_TO_DMA.  This is done for similar reasons that caused
arch/x86/include/asm/dma-direct.h to exist (see CONFIG_STA2X11).

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/arm64/include/asm/dma-direct.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

diff --git a/arch/arm64/include/asm/dma-direct.h b/arch/arm64/include/asm/dma-direct.h
new file mode 100644
index 0000000..d87da92
--- /dev/null
+++ b/arch/arm64/include/asm/dma-direct.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARM64_DMA_DIRECT_H
+#define _ARM64_DMA_DIRECT_H 1
+
+static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
+{
+	if (!dev->dma_mask)
+		return false;
+
+	return addr + size - 1 <= *dev->dma_mask;
+}
+
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
+
+#endif /* _ARM64_DMA_DIRECT_H */
-- 
1.9.0.138.g2de3478
