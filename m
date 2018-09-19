Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2018 16:33:17 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:46025
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994642AbeISOdNQroV9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2018 16:33:13 +0200
Received: by mail-qt0-x243.google.com with SMTP id l2-v6so111444qtr.12;
        Wed, 19 Sep 2018 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Tps4s77D23i3fxKoeF6dPhKuUaEwXZQhu6RTBKsY3Q=;
        b=g9zX9L4TawPVaK0YzSox8YB+x+ct5iD9mIvHFYybGnpR33u0gqEd2UOQudYG85camN
         Cx7+EXRNbZ6eHeigZFjjGvLB0N4PZzuvoX1Mj7r1hmvMS7TGND3uMUJngMJ8gq4vRJae
         UHd49aMvIpAzAHUutSS1b+F4zimhEumQsd4Jm0Ok339EhweMKe8Y7qBy3b21IN6ykVbP
         EgIXdekqa4leU6khqF7T1l+8aJU9aKQfm5tjQqQt4n1xa43U9zGFUSaxaMfhAkJmPhgk
         x1pSKwu4I/LVTcdqMMgGPB5gYS00Qi7sF1uP3CIGatW8DDvxzRhYswE/Bc64K9gR4ecF
         ZK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Tps4s77D23i3fxKoeF6dPhKuUaEwXZQhu6RTBKsY3Q=;
        b=lcgbjQMy5mkFjRIJand2N03eeIGIVYuJ4XCGrjaKCGRBto61G0wq43UdZtukVrLb9V
         +8EC2M/GdOuSWmbSY5N6W9Ou9z/AxByvKdNmmSl6MbaUQj9rzVBPdbJxIRmzjmJP+MIB
         cKyVOMSQEh6xSKimXqYbEKmhzEQxPCjZs/comO1pG4yGE+/fWURDgnfwLagEOMo3u7mC
         6zP3xJ27pG7Y+g8H4dsSyaNsSB8KFCl2qNNpwFSWeL7I5bS5GMxYioPIukwTYivL0DYG
         UQplxwpsCIrYFi4AQe/BEmchrYw/CyscNNt6OC/3twBqmlwjJ4cyatOR0U5t9/d5iqBA
         mGPg==
X-Gm-Message-State: APzg51Bh1mzZ0rOezkEgfHl+6u9YHc9+7NO+roBWf7/LqGA5qkcrO4UJ
        5cKmE7OIgl7jr1gQGpAWKI4=
X-Google-Smtp-Source: ANB0VdZWEaFuArm9yR6P9tSrGkSsNGQWEsFlKiiurX0rfbtQn8V05GJJL5BNMXv88Hw35aRVffzFSA==
X-Received: by 2002:aed:2ec6:: with SMTP id k64-v6mr25044676qtd.177.1537367587181;
        Wed, 19 Sep 2018 07:33:07 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:06 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
Date:   Wed, 19 Sep 2018 10:32:01 -0400
Message-Id: <1537367527-20773-7-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66410
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

The design of the Broadcom PCIe RC controller requires us to remap its
DMA addresses for inbound traffic.  We do this by modifying the
definitions of __phys_to_dma() and __dma_to_phys().

In arch/mips/bmips/dma.c, these functions are already in use to remap
DMA addresses for the 338x SOC chips.  We leave this code alone -- and
give its mapping priority -- but if it is not in use, the PCIe DMA
mapping is in effect.

One might think that the two DMA remapping systems of dma.c could be
combined, but they cannot: one governs only DMA addresses for the PCIe
controller of BrcmSTB ARM/ARM64/MIPs chips, while the other governs
the PCIe controller *and* other peripherals for only MIPs 338x
chips.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/bmips/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 3d13c77..292994f 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/bmips.h>
+#include <soc/brcmstb/common.h>
 
 /*
  * BCM338x has configurable address translation windows which allow the
@@ -44,6 +45,10 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
 {
 	struct bmips_dma_range *r;
 
+#ifdef CONFIG_PCIE_BRCMSTB
+	if (!bmips_dma_ranges)
+		return brcm_phys_to_dma(dev, pa);
+#endif
 	for (r = bmips_dma_ranges; r && r->size; r++) {
 		if (pa >= r->child_addr &&
 		    pa < (r->child_addr + r->size))
@@ -56,6 +61,10 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	struct bmips_dma_range *r;
 
+#ifdef CONFIG_PCIE_BRCMSTB
+	if (!bmips_dma_ranges)
+		return (unsigned long)brcm_dma_to_phys(dev, dma_addr);
+#endif
 	for (r = bmips_dma_ranges; r && r->size; r++) {
 		if (dma_addr >= r->parent_addr &&
 		    dma_addr < (r->parent_addr + r->size))
-- 
1.9.0.138.g2de3478
