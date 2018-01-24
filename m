Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 02:48:34 +0100 (CET)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:34842
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeAXBrmVkW2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 02:47:42 +0100
Received: by mail-qt0-x242.google.com with SMTP id g14so6616961qti.2;
        Tue, 23 Jan 2018 17:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6rqXv9AXTcBwc+TsrwbZvOmQ4mk4O2j8RbNBCpW2Xc=;
        b=V8/l4EQkQyRWStDTtO0nQAmPzA+t31Zp1PU1ooNmTRUB/K/Eg2ul4UP990P4pTaggu
         dgbq84q+tv8mzgSKUQCSUuEtI9A6AUVFuc3ztEF0rJSbtGqzKZEkEKqCNwLu+NVhNk3c
         71ywy3O3ZzQt6vVQq5MtGDakf3/7KP79IOwNiNILoVnZc4fTBoZ7oaqbvRn8JmA6ElVX
         fyPAVLvhVx6q9fz4IB4fpoJ9qqqp6AwEZ4mDrPJ0XheO8vr4enSy2cYP0UZvYqC76pY1
         BJ28NO0rLXsZ/2WPeJiDKU3/u/aPwrbJcTlVInNnJgTEr70nDOt39Uszl2x8Q8uIMh8Z
         W0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6rqXv9AXTcBwc+TsrwbZvOmQ4mk4O2j8RbNBCpW2Xc=;
        b=U0GTVr2n7emJLRW/WTZc4+z1ilqmLmQZkEJqLy0ZEaqOdlFaYGt4HeT1RlNIFgsa5V
         MJUItXnClPqXEdHbGJ4Xh3x4tQFhV+cdQ4EMt1TJkTY/5q9GPAaNnSJ9jbPc2mogC6SY
         EvF3dLqzWAGPcCBbtQvHuY7WyDgGZd3IvqQfyKgqZczTgsd4UmDfnKk5UyUzQkeICLHw
         EwvAGDH6Am0wxpUNax5MYgx0SZyzmdFvP48PWuZaedBtIzUstuxVxjoBnOeH7ndGgN9N
         sGmULOPE7Sl6mF/RUKj3a/gXGgCLMhfa6PmCFvOWmpq/wQ50pJirUgAslBqQ/WJ+KUqZ
         6Rqg==
X-Gm-Message-State: AKwxyteEHxyWzyvFv0p/hMx2U3slyVH/vYv7cwYQQpSeG5gyF/S5uQSl
        FbagFhdyziqVJjp+WCZXIqYxU7IF
X-Google-Smtp-Source: AH8x2274TK/aTQNKDg18boJtiaKmSezB7DAKrA0uUCXZrVv3IPCU9CdJkNDmOOO94/FFfot897lgHw==
X-Received: by 10.237.62.137 with SMTP id n9mr6676086qtf.143.1516758455494;
        Tue, 23 Jan 2018 17:47:35 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x7sm1465605qtx.51.2018.01.23.17.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Jan 2018 17:47:34 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 2/6] MIPS: Allow platforms to override mapping/unmapping coherent
Date:   Tue, 23 Jan 2018 17:47:02 -0800
Message-Id: <1516758426-8127-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
References: <1516758426-8127-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62296
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

From: Florian Fainelli <florian.fainelli@broadcom.com>

In preparation for allowing support for Broadcom's eXtended Kseg0/1
feature, allow platforms to override how coherent DMA mappings are done
by providing plat_map_coherent() and plat_unmap_coherent() hooks, which
default to the current implementation with CAC/UNCAC unless changed.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-generic/dma-coherence.h | 16 ++++++++++++++++
 arch/mips/mm/dma-default.c                         | 10 +++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index e6e7dfa15801..42a1546e7d10 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -98,4 +98,20 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 #endif
 #endif /* CONFIG_SWIOTLB */
 
+#ifndef plat_map_coherent
+static inline int plat_map_coherent(dma_addr_t handle, void *cac_va, size_t size,
+				    void **uncac_va, gfp_t gfp)
+{
+	*uncac_va = UNCAC_ADDR(cac_va);
+	return 0;
+}
+#endif
+
+#ifndef plat_unmap_coherent
+static inline void *plat_unmap_coherent(void *addr)
+{
+	return CAC_ADDR(addr);
+}
+#endif
+
 #endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e3e94d05f0fd..f82f00dcc841 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -151,7 +151,11 @@ static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
 	if (!(attrs & DMA_ATTR_NON_CONSISTENT) &&
 	    !plat_device_is_coherent(dev)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
-		ret = UNCAC_ADDR(ret);
+		if (plat_map_coherent(*dma_handle, ret, PFN_ALIGN(size),
+				      &ret, gfp)) {
+			free_pages((unsigned long)ret, size);
+			ret = NULL;
+		}
 	}
 
 	return ret;
@@ -167,7 +171,7 @@ static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 	plat_unmap_dma_mem(dev, dma_handle, size, DMA_BIDIRECTIONAL);
 
 	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !plat_device_is_coherent(dev))
-		addr = CAC_ADDR(addr);
+		addr = (unsigned long)plat_unmap_coherent(vaddr);
 
 	page = virt_to_page((void *) addr);
 
@@ -187,7 +191,7 @@ static int mips_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	int ret = -ENXIO;
 
 	if (!plat_device_is_coherent(dev))
-		addr = CAC_ADDR(addr);
+		addr = (unsigned long)plat_unmap_coherent((void *)addr);
 
 	pfn = page_to_pfn(virt_to_page((void *)addr));
 
-- 
2.7.4
