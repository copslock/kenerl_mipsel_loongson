Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:12:01 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:45329 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008609AbaLLWIlWbfcp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:41 +0100
Received: by mail-pd0-f171.google.com with SMTP id y13so7971450pdi.2
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rTW8INPeGt82J6bH0DhDmN2gNyMemWPGGMepVtSiZ4M=;
        b=XvwS3dsfhqogYvouBquq9Kstc94BHTtHLC6WpQz1hf/dWGz0hatetVI3tGQMGh7eRg
         qPECaGg/ZD1EGy7iUvICiOVzyDVzKyz62um7fVboOhGccsMqCiU4DGHXZxXfjKy34+ya
         elvYqfKL9vNN4+6WPHvpKzNCeVLDJXqrnr8qqtnQGYjPG+NW1HN3R3yhEQ6xB/fJlhNs
         aLESpEJx4BclNJVrYWfv7QdlwSp+YAjpQtEzcjc3mGdPf+yM1O8jlXDgtkEbyUkpQyJq
         6Lz9ON70Q3qBgl2uSiN7dP1IwDXhA3zAe+7HPU6Rkf/G0pTaWarats11KgJSnI48wOvZ
         XmVg==
X-Received: by 10.66.90.201 with SMTP id by9mr30243265pab.148.1418422115687;
        Fri, 12 Dec 2014 14:08:35 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:35 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 13/23] MIPS: BMIPS: Flush the readahead cache after DMA
Date:   Fri, 12 Dec 2014 14:07:04 -0800
Message-Id: <1418422034-17099-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
may cause parts of the DMA buffer to be prefetched into the RAC.  To
avoid possible coherency problems, flush the RAC upon DMA completion.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/mm/dma-default.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index af5f046..ee6d12c 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/dma-contiguous.h>
 
+#include <asm/bmips.h>
 #include <asm/cache.h>
 #include <asm/cpu-type.h>
 #include <asm/io.h>
@@ -69,6 +70,18 @@ static inline struct page *dma_addr_to_page(struct device *dev,
  */
 static inline int cpu_needs_post_dma_flush(struct device *dev)
 {
+	if (boot_cpu_type() == CPU_BMIPS3300 ||
+	    boot_cpu_type() == CPU_BMIPS4350 ||
+	    boot_cpu_type() == CPU_BMIPS4380) {
+		void __iomem *cbr = BMIPS_GET_CBR();
+
+		/* Flush stale data out of the readahead cache */
+		__raw_writel(0x100, cbr + BMIPS_RAC_CONFIG);
+		__raw_readl(cbr + BMIPS_RAC_CONFIG);
+
+		return 0;
+	}
+
 	return !plat_device_is_coherent(dev) &&
 	       (boot_cpu_type() == CPU_R10000 ||
 		boot_cpu_type() == CPU_R12000 ||
-- 
2.1.1
