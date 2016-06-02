Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:55:08 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49699 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041806AbcFBPmp5zfu2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:42:45 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8500M0FIB79W10@mailout1.w1.samsung.com>; Thu,
 02 Jun 2016 16:42:44 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-a5-575053f3a839
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 81.6C.04866.3F350575; Thu,
 2 Jun 2016 16:42:43 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:42:43 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Geoff Levand <geoff@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Muli Ben-Yehuda <muli@il.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@linux.ie>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        discuss@x86-64.org, linux-pci@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC v3 45/45] dma-mapping: Document the DMA attributes right in
 declaration
Date:   Thu, 02 Jun 2016 17:39:47 +0200
Message-id: <1464881987-13203-46-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxTGee97PwpZzc1Vx40uuDQxJm5zfueom9kWM95EDUSXNCHZtMoV
        DBRrLzVqjOlAdLrCKlgVSprKWr5WCgXNBIOVxtAh1NFB8IMPERUkMOhg3SY4WAvZf7/znOfJ
        OTk5CiwMMCsUR7OyJX2WJlPFxtHtc/6uj6b3J6vX/9m0Ci42znLgrzOykP+wjYLSWhcL/xa2
        cuC5XstAKCcPgyMnHYLX8miYLDchqKjcC8+mehFM5MzSMPf7OIbu8CQLl6uKMHzvHuLg/NXP
        oXQkgGD4aTMFjtGd0PL4Lw7azWUUXPXEwz/h3EjwgQeD3bsDJmyvMTxzVzMw4ivBUPpkI7wt
        DlFw0VrHwdjrDVD+4ysEr8x9LEz030dQ4u2nof5FDwOXvQEO7lvNFFT+5MZw47yDhl8KQgxM
        nrvNQui7CQa6mkpZqHhZg8FUdytS5gajW12gwWwp5MDq+IGGoQedFARsfhaGffk0TA3OYzDf
        yMVw/de7kXu8vYIhr6+GgqpADQc+SzOC2b/nmM9SyMsWG0Xyms0scdlciHT1BDGZnSlE5JE7
        mYwVmSNSQT5FWoZ8LCkbNdKksaSfI6E/viH2egOxWnoQMTV2INJQuTZ5a0rcJ6lS5tETkv7j
        nQfj0nutIVp3TTh5bmacMqI3Sy6hWIXIbxary/vZRX5X7ByojXCcQuCdSHS1d9OLxbeUWDjs
        oaIult8kNlQ4FlzLeI8oGl8EcbSB+TPiqH8GRXkprxaLO6oWAjS/WgzYvQu6kidi78wgXhyX
        ILa1FjFRjo3ojtoqOsoCnygGcxsYM1LaUUw1Wi4ZDuvkQ2najetkjVY2ZKWtO3xMW48Wvy58
        Gzlbt/sQr0Cqd5QxHyapBUZzQj6l9SFRgVXLlNn7ktWCMlVz6rSkP3ZAb8iUZB9aqaBV8cri
        psmvBD5Nky1lSJJO0v/fpRSxK4xoTcbq5bqCcYvTdiCnq8yQFTi+5NB8grqgU2i6t8V0RB7o
        aU61PXrvZNj3gSdct3ubzvmpNqZtrM//fNB/xd3NZOzlhDcpxbvcZdWNF+xfJmzJiJdcqUFy
        6X2rZTrxN33f9Kak+akvkpyZe46sTPDeHFHvma44q6Y7En/++o5JHlDRcrpmw1qslzX/Aa6F
        gFlxAwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

Copy documentation abstract about each DMA attribute from
Documentation/DMA-attributes.txt to the place with declaration.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/linux/dma-mapping.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6d013ba94213..f349df4cb009 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -14,14 +14,47 @@
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
  * of each attribute should be defined in Documentation/DMA-attributes.txt.
+ *
+ * DMA_ATTR_WRITE_BARRIER: DMA to a memory region with this attribute
+ * forces all pending DMA writes to complete.
  */
 #define DMA_ATTR_WRITE_BARRIER		(1UL << 1)
+/*
+ * DMA_ATTR_WEAK_ORDERING: Specifies that reads and writes to the mapping
+ * may be weakly ordered, that is that reads and writes may pass each other.
+ */
 #define DMA_ATTR_WEAK_ORDERING		(1UL << 2)
+/*
+ * DMA_ATTR_WRITE_COMBINE: Specifies that writes to the mapping may be
+ * buffered to improve performance.
+ */
 #define DMA_ATTR_WRITE_COMBINE		(1UL << 3)
+/*
+ * DMA_ATTR_NON_CONSISTENT: Lets the platform to choose to return either
+ * consistent or non-consistent memory as it sees fit.
+ */
 #define DMA_ATTR_NON_CONSISTENT		(1UL << 4)
+/*
+ * DMA_ATTR_NO_KERNEL_MAPPING: Lets the platform to avoid creating a kernel
+ * virtual mapping for the allocated buffer.
+ */
 #define DMA_ATTR_NO_KERNEL_MAPPING	(1UL << 5)
+/*
+ * DMA_ATTR_SKIP_CPU_SYNC: Allows platform code to skip synchronization of
+ * the CPU cache for the given buffer assuming that it has been already
+ * transferred to 'device' domain.
+ */
 #define DMA_ATTR_SKIP_CPU_SYNC		(1UL << 6)
+/*
+ * DMA_ATTR_FORCE_CONTIGUOUS: Forces contiguous allocation of the buffer
+ * in physical memory.
+ */
 #define DMA_ATTR_FORCE_CONTIGUOUS	(1UL << 7)
+/*
+ * DMA_ATTR_ALLOC_SINGLE_PAGES: This is a hint to the DMA-mapping subsystem
+ * that it's probably not worth the time to try to allocate memory to in a way
+ * that gives better TLB efficiency.
+ */
 #define DMA_ATTR_ALLOC_SINGLE_PAGES	(1UL << 8)
 
 /*
-- 
1.9.1
