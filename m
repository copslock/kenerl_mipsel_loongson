Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:41:03 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:46538
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeAXBkdWlMxZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:40:33 +0100
Received: by mail-qt0-x244.google.com with SMTP id o35so6530258qtj.13;
        Tue, 23 Jan 2018 17:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iltQzQ8BCSfNRNmrnou22xF62QAmV+Ai+Ol+PhW+B1U=;
        b=CBaSR9CUF2PWVpWbid7ppx9xOXLz3Bk4/22fhbrKjtInW7pRBqijtWLLByUoiX2mdZ
         gUqexrFvyckdVD7iCU6155aeKfjrSzzZDKCfJ3vgifK5YMFCzdb5Jxzkt7/ePAoDziBX
         4dCmhkKF0ijh3JcGeyxJuc1CIV4m8cp0gFBUrUII9CeGVt+I1bOrjXzxCJaK6Jrnt+wk
         MAWmmmLxnlBgbtui9SfFXK0j1tcWN9hCYX4hpDub/QF65ih6n7h+FMpSWkXp2m3WyyqE
         /rJR0Yiruh560cKsPP5uxhRaGFUUeqdnltmYv0jd03ekdIerT7rDVaJv/NzTd+8ytoFr
         CfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iltQzQ8BCSfNRNmrnou22xF62QAmV+Ai+Ol+PhW+B1U=;
        b=g1cgTVucUSXo2FvPgiiM6+LZTDG8P6gOoR+ma/nzJ281AUPpGxk7Byx6LNmLe3IDHw
         z3KPtwfZtvapIk00dccm+DMs1XTGk+yLz+pJL+/tg00NoRRlHXxg2ydFPYld0zOkNvvw
         yDNXF+udsZcLigDr8X1hQipH5ckEQ8vpzc5qZNoJkDy0ROwk8K3OwePvYHJXGyZCLTRq
         v245rO/SetHqGbIdD8oG/qbKcvQK0ZkP7hbEqb9/1qwVM/F2SlIAJoN3pEtSzLFqAVGJ
         eCGEBbwZRpaizpzBwSQZ0Z5w+/HtTproc/xzDCmufHI4sd15NSWfpClH6Y7Sq3q9tseo
         urwQ==
X-Gm-Message-State: AKwxytfTLe4K4AJY0IdeWLA+m5BQKGmt/7rYk/VBaW57PuV41IIcIpRe
        CZQoLHzetgpqDIKAf1F3t8yeVK88
X-Google-Smtp-Source: AH8x226nIkPpGQ9IXQk7OMT7PyqA74oQwuk6mV3ZAQJL1rpt2hxrzXQuOfuA1ZcFeM1W9iJsPsphFw==
X-Received: by 10.55.64.21 with SMTP id n21mr6879349qka.293.1516758027252;
        Tue, 23 Jan 2018 17:40:27 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u123sm6071154qkd.21.2018.01.23.17.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:40:26 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     jhogan@kernel.org, david.daney@cavium.com, paul.burton@mips.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] MIPS: Allow including mach-generic/dma-coherence.h
Date:   Tue, 23 Jan 2018 17:40:09 -0800
Message-Id: <1516758010-7641-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
References: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Check whether a platform is already defining any of the functions we
provide in mach-generic/dma-coherence.h. This is a preliminary change to
allow cleaning up machine's dma-coherence.h files.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-generic/dma-coherence.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 61addb1677e9..e6e7dfa15801 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -11,29 +11,38 @@
 
 struct device;
 
+#ifndef plat_map_dma_mem
 static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	size_t size)
 {
 	return virt_to_phys(addr);
 }
+#endif
 
+#ifndef plat_map_dma_mem_page
 static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 	struct page *page)
 {
 	return page_to_phys(page);
 }
+#endif
 
+#ifndef plat_dma_addr_to_phys
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 	return dma_addr;
 }
+#endif
 
+#ifndef plat_unmap_dma_mem
 static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
 	size_t size, enum dma_data_direction direction)
 {
 }
+#endif
 
+#ifndef plat_dma_supported
 static inline int plat_dma_supported(struct device *dev, u64 mask)
 {
 	/*
@@ -46,7 +55,9 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
 	return 1;
 }
+#endif
 
+#ifndef plat_device_is_coherent
 static inline int plat_device_is_coherent(struct device *dev)
 {
 #ifdef CONFIG_DMA_PERDEV_COHERENT
@@ -63,6 +74,7 @@ static inline int plat_device_is_coherent(struct device *dev)
 	}
 #endif
 }
+#endif
 
 #ifndef plat_post_dma_flush
 static inline void plat_post_dma_flush(struct device *dev)
@@ -71,15 +83,19 @@ static inline void plat_post_dma_flush(struct device *dev)
 #endif
 
 #ifdef CONFIG_SWIOTLB
+#ifndef phys_to_dma
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return paddr;
 }
+#endif
 
+#ifndef dma_to_phys
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
 	return daddr;
 }
 #endif
+#endif /* CONFIG_SWIOTLB */
 
 #endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
-- 
2.7.4
