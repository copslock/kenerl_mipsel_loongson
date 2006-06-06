Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2006 15:04:27 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:7106 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S8133934AbWFFOET convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Jun 2006 15:04:19 +0100
Received: from ala-mail04.corp.ad.wrs.com (ala-mail04 [147.11.57.145])
	by mail.wrs.com (8.13.6/8.13.3) with ESMTP id k56E4C9R027006;
	Tue, 6 Jun 2006 07:04:13 -0700 (PDT)
Received: from ism-mail01.corp.ad.wrs.com ([147.11.96.20]) by ala-mail04.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Jun 2006 07:02:59 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Socket buffer allocation outside DMA-able memory
Date:	Tue, 6 Jun 2006 16:02:55 +0200
Message-ID: <6A3254532ACD7A42805B4E1BFD18080EEA211B@ism-mail01.corp.ad.wrs.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Socket buffer allocation outside DMA-able memory
Thread-Index: AcaJZjbxp1IvfUOrSwyzJ2H7FF15GwABt95QAAEMDCA=
From:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>
To:	"Zhan, Rongkai" <rongkai.zhan@windriver.com>,
	"ashley jones" <ashley_jones_2000@yahoo.com>,
	"art" <art@sigrand.ru>, <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 Jun 2006 14:02:59.0850 (UTC) FILETIME=[EB4ADEA0:01C68971]
Return-Path: <rongkai.zhan@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rongkai.zhan@windriver.com
Precedence: bulk
X-list: linux-mips

After having a look at the latest 2.6.17-rc6 codes, __dev_alloc_skb is defined like this:

#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
/**
 *	__dev_alloc_skb - allocate an skbuff for sending
 *	@length: length to allocate
 *	@gfp_mask: get_free_pages mask, passed to alloc_skb
 *
 *	Allocate a new &sk_buff and assign it a usage count of one. The
 *	buffer has unspecified headroom built in. Users should allocate
 *	the headroom they think they need without accounting for the
 *	built in space. The built in space is used for optimisations.
 *
 *	%NULL is returned in there is no free memory.
 */
static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
					      gfp_t gfp_mask)
{
	struct sk_buff *skb = alloc_skb(length + NET_SKB_PAD, gfp_mask);
	if (likely(skb))
		skb_reserve(skb, NET_SKB_PAD);
	return skb;
}
#else
extern struct sk_buff *__dev_alloc_skb(unsigned int length, int gfp_mask);
#endif


Therefore, you also can consider to implement your machine-specific __dev_alloc_skb() function, and force the skb is allocated from your low 32MB memory zone.

Best Regards,
Mark. Zhan
________________________________________
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Zhan, Rongkai
Sent: Tuesday, June 06, 2006 9:34 PM
To: ashley jones; art; linux-mips@linux-mips.org
Subject: RE: Socket buffer allocation outside DMA-able memory

Hi,

Maybe you can enable ISA bus. And then add your low 32MB memory into ZONE_DMA, while the high 32MB memory into ZONE_NORMAL.
In the case, you are required to redefine MAX_DMA_ADDRESS to (PAGE_OFFSET + 0x00200000) in asm-mips/dma.h


Just a noise.

Best Regards,
Mark. Zhan
________________________________________
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of ashley jones
Sent: Tuesday, June 06, 2006 8:38 PM
To: art; linux-mips@linux-mips.org
Subject: Re: Socket buffer allocation outside DMA-able memory

hi,
       I guess your 25 bit dma address field will be word alligned, so ur dma engine will be able to index up to 64 MB( 25+2 = 27 bits).
 
        If that is not the case then you can use one of the foll. work around,
 
  * dont give whole 64 MB to linux, give only Lower 32 MB.
  * Give only upper 32 MB to linux, and give memory to ur dma engine from lower 32 MB, and once you recv any data you copy to skb and submit to linux. ( ofcourse your performance will get hit in this case.)
 
 
Regards,
A'Jones.


art <art@sigrand.ru> wrote:
Hello all!
I work with ADM5120 chip. it has embedded switch.
Switch descriptor has 25-bit dma addres field - so addressible only
32Mb!
My system has 64Mb memory. But I have to set 32Mb to make it work!
I thought that setting DMA mask can help. So in
/arch/mips/adm5120/setup.c i make:

static struct platform_device adm5120hcd_device = {
.name = "adm5120-hcd",
.id = -1,
.dev = {
.dma_mask = &hcd_dmamask,
.coherent_dma_mask = 0x01ffffff,
},
.num_resources = ARRAY_SIZE(adm5120_hcd_resources),
.resource = adm5120_hcd_resources,
};
But It is wrong, because dev_alloc_skb dont know to which device it
allocates buffer!

How to tell kernel allocate skbuffers in less then 32Mb addrspace whet
system has 64Mb?

-- 
Best regards,
art mailto:art@sigrand.ru


__________________________________________________
Do You Yahoo!?
Tired of spam? Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
