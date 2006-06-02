Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 15:26:21 +0200 (CEST)
Received: from sigrand.ru ([80.66.88.167]:24268 "HELO mail.sigrand.com")
	by ftp.linux-mips.org with SMTP id S8133409AbWFBN0O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2006 15:26:14 +0200
Received: from develop (unknown [192.168.2.238])
	by mail.sigrand.com (Postfix) with ESMTP id A0B7512A0021
	for <linux-mips@linux-mips.org>; Fri,  2 Jun 2006 20:26:12 +0700 (NOVST)
Date:	Fri, 2 Jun 2006 20:26:16 +0700
From:	art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <6851.060602@sigrand.ru>
To:	linux-mips@linux-mips.org
Subject: Socket buffer allocation outside DMA-able memory
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <art@sigrand.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: art@sigrand.ru
Precedence: bulk
X-list: linux-mips

Hello all!
I work with ADM5120 chip. it has embedded switch.
Switch descriptor has 25-bit dma addres field - so addressible only
32Mb!
My system has 64Mb memory. But I have to set 32Mb to make it work!
I thought that setting DMA mask can help. So in
/arch/mips/adm5120/setup.c i make:

static struct platform_device adm5120hcd_device = {
        .name           = "adm5120-hcd",
        .id             = -1,
        .dev            = {
        .dma_mask               = &hcd_dmamask,
        .coherent_dma_mask      = 0x01ffffff,
        },
        .num_resources  = ARRAY_SIZE(adm5120_hcd_resources),
        .resource       = adm5120_hcd_resources,
};
But It is wrong, because dev_alloc_skb dont know to which device it
allocates buffer!

How to tell kernel allocate skbuffers in less then 32Mb addrspace whet
system has 64Mb?

-- 
Best regards,
 art                          mailto:art@sigrand.ru
