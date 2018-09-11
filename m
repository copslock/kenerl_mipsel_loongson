Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 08:54:19 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:59155 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990473AbeIKGyQVh6e0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 08:54:16 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BAE5367357; Tue, 11 Sep 2018 08:58:39 +0200 (CEST)
Date:   Tue, 11 Sep 2018 08:58:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Message-ID: <20180911065839.GA6479@lst.de>
References: <20180910060533.27172-1-hch@lst.de> <20180910060533.27172-3-hch@lst.de> <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ec3eef-54c1-f692-5a17-4302c4dd4b05@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Mon, Sep 10, 2018 at 04:19:30PM +0100, Robin Murphy wrote:
> If we're likely to refer to it more than once, is it worth wrapping that 
> condition up in something like ARCH_HAS_NONCOHERENT_DMA?

Below is what we'd need.  Which to me doesn't look wortwhile for just
those two conditionals:

diff --git a/include/linux/device.h b/include/linux/device.h
index 983506789402..d260536f6f46 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1018,9 +1018,7 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+#ifdef CONFIG_ARCH_HAS_NONCOHERENT_DMA
 	bool			dma_coherent:1;
 #endif
 };
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 9051b055beec..9e3adf924d1e 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -6,9 +6,7 @@
 
 #ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
 #include <asm/dma-coherence.h>
-#elif defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+#elif defined(CONFIG_ARCH_HAS_NONCOHERENT_DMA)
 static inline bool dev_is_dma_coherent(struct device *dev)
 {
 	return dev->dma_coherent;
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 645c7a2ecde8..06283d6e305b 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -29,6 +29,11 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	bool
 
+config ARCH_HAS_NONCOHERENT_DMA
+	def_bool ARCH_HAS_SYNC_DMA_FOR_DEVICE || \
+		ARCH_HAS_SYNC_DMA_FOR_CPU || \
+		ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
+
 config ARCH_HAS_DMA_COHERENT_TO_PFN
 	bool
 
