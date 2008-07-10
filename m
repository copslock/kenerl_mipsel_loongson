Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2008 18:38:45 +0100 (BST)
Received: from [66.209.47.173] ([66.209.47.173]:21128 "EHLO mythtv.ewol.com")
	by ftp.linux-mips.org with ESMTP id S20022923AbYGJRin (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Jul 2008 18:38:43 +0100
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by mythtv.ewol.com (8.14.2/8.14.2) with ESMTP id m6AHcP9p027626;
	Thu, 10 Jul 2008 13:38:26 -0400
Message-ID: <48764911.50409@cortland.com>
Date:	Thu, 10 Jul 2008 13:38:25 -0400
From:	Steve Brown <sbrown@cortland.com>
Reply-To: sbrown@cortland.com
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Michael Buesch <mb@bu3sch.de>
Subject: Re: Correct way to set coherent_dma_mask on a non-pci device?
References: <4873A676.8050906@cortland.com> <200807081955.47594.mb@bu3sch.de>
In-Reply-To: <200807081955.47594.mb@bu3sch.de>
Content-Type: multipart/mixed;
 boundary="------------040304090608000708050506"
Return-Path: <sbrown@cortland.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbrown@cortland.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040304090608000708050506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Buesch wrote:
> On Tuesday 08 July 2008 19:40:06 Steve Brown wrote:
>   
>> There appears to be no function like pci_set_consistent_dma_mask to set 
>> the coherent mask for a non-pci device.
>>
>> What is the "proper" way to set it?
>>
>> The context for the question is a recent change to ssb_dma_set_mask() in 
>> drivers/ssb/main.c that removed the somewhat fragile, direct 
>> manipulation of dma_mask and coherent_dma_mask in favor of a call to 
>> dma_set_mask().
>>     
>
> Note that SSB devices use the dma_*** API for doing DMA remappings.
> So it uses dma_set_mask() for setting the mask.
>
>   
I can't find any dma_*** routine that references coherent_dma_mask. It 
looks like dma_set_mask() doesn't handle the case where the device 
doesn't support coherent dma (CONFIG_DMA_NONCOHERENT=y).

Would this be the correct patch to handle that case?
 
Steve


--------------040304090608000708050506
Content-Type: text/plain;
 name="170-dma_set_mask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="170-dma_set_mask.patch"

diff --git a/include/asm-mips/dma-mapping.h b/include/asm-mips/dma-mapping.h
index 230b3f1..8da4107 100644
--- a/include/asm-mips/dma-mapping.h
+++ b/include/asm-mips/dma-mapping.h
@@ -1,8 +1,9 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
-#include <asm/scatterlist.h>
+#include <linux/scatterlist.h>
 #include <asm/cache.h>
+#include <dma-coherence.h>
 
 void *dma_alloc_noncoherent(struct device *dev, size_t size,
 			   dma_addr_t *dma_handle, gfp_t flag);
@@ -48,7 +49,11 @@ extern int dma_supported(struct device *dev, u64 mask);
 static inline int
 dma_set_mask(struct device *dev, u64 mask)
 {
-	if(!dev->dma_mask || !dma_supported(dev, mask))
+	if(!dma_supported(dev, mask))
+		return -EIO;
+	if(!plat_device_is_coherent(dev))
+		dev->dma_mask = &dev->coherent_dma_mask;
+	if(!dev->dma_mask)
 		return -EIO;
 
 	*dev->dma_mask = mask;

--------------040304090608000708050506--
