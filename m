Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2008 07:54:20 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.153]:37775 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S23965619AbYK1HyL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Nov 2008 07:54:11 +0000
Received: by fg-out-1718.google.com with SMTP id d23so887094fga.32
        for <linux-mips@linux-mips.org>; Thu, 27 Nov 2008 23:54:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=/9FTYiVkkzF9Rxqtd8okiSajwMtqEcMhbrx2A0EIpGU=;
        b=eLGcP5Vov2GbClVnBVaLphVCofm9B83yp2ZOVztxcCX8FKY/07PQjB7Bdj/LtZR2Jo
         KTRvMB6fHkWZnAg2AdgV1qktNrGimfU6Vfc+w2w92kI8lYwjbfzb/ze7x8EKyPO95Q48
         fYb1IVPtOC1u3zDkmeisfGXC1zHbhDkEU6NRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=jkOZA1n/6xKhKCvTxItKGwUg3JGCJUwiVOtAdvlx9wbzYSOauQeapU3/lHJ7WZs+bn
         ZvpsmwX26jP4WvIawpVBYIdKQAIenpYyuvVfeSU4hdhuzM3Y42pA3tuvDIZRSAkJhwpV
         2912ktWxbs9KUN+/olFZb8DEpvK5h/TYtbi3Q=
Received: by 10.86.62.3 with SMTP id k3mr296290fga.46.1227858850631;
        Thu, 27 Nov 2008 23:54:10 -0800 (PST)
Received: from localhost (122.229.broadband3.iol.cz [85.70.229.122])
        by mx.google.com with ESMTPS id 4sm540914fgg.4.2008.11.27.23.54.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Nov 2008 23:54:10 -0800 (PST)
Date:	Fri, 28 Nov 2008 08:52:58 +0100
From:	Jan Nikitenko <jan.nikitenko@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: fix oops in dma_unmap_page on not coherent mips platforms
Message-ID: <20081128075258.GA10200@nikitenko.systek.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <jan.nikitenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.nikitenko@gmail.com
Precedence: bulk
X-list: linux-mips

dma_cache_wback_inv() expects virtual address, but physical was provided
due to translation via plat_dma_addr_to_phys().
If replaced with dma_addr_to_virt(), page fault oops from dma_unmap_page()
is gone on au1550 platform.

Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
---
 arch/mips/mm/dma-default.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 5b98d0e..5f336c1 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -222,7 +222,7 @@ void dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 	if (!plat_device_is_coherent(dev) && direction != DMA_TO_DEVICE) {
 		unsigned long addr;
 
-		addr = plat_dma_addr_to_phys(dma_address);
+		addr = dma_addr_to_virt(dma_address);
 		dma_cache_wback_inv(addr, size);
 	}
 
