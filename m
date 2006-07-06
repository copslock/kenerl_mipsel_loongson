Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 15:54:24 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:3492 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S3466417AbWGFOyO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Jul 2006 15:54:14 +0100
Received: by nf-out-0910.google.com with SMTP id x30so154687nfb
        for <linux-mips@linux-mips.org>; Thu, 06 Jul 2006 07:54:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ayGo4llO081s8g9x84xS8lYYFx0M9A0eVHn32F30/5Gu0Drj5OBGyTIUg89cz4ylTuXNCBekcgrvUBBvzrnRhedy/LErROrR6o5oHUr6PmT9aNGZ70B3V1U2w4MxHl6WLiiYm03meduRol/ILvT0dteTYGPORXY/mX4OTeM+KqE=
Received: by 10.48.231.6 with SMTP id d6mr523703nfh;
        Thu, 06 Jul 2006 07:54:14 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id r33sm8288584nfc.2006.07.06.07.54.13;
        Thu, 06 Jul 2006 07:54:13 -0700 (PDT)
Message-ID: <44AD2537.1030509@innova-card.com>
Date:	Thu, 06 Jul 2006 16:59:03 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
References: <44ABC59C.6070607@innova-card.com>	<20060705.231737.59032119.anemo@mba.ocn.ne.jp>	<44AD0C2B.7060204@innova-card.com> <20060706.233634.59465089.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060706.233634.59465089.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 06 Jul 2006 15:12:11 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> Ok thinking more about it, some platforms may have physical memory
>> that doesn't start at 0. MIPS doesn't support such platform though it
>> should be fairly easy. In that case __pa should be defined as:
>>
>> 	#define __pa(x)	((unsigned long) (x) - PAGE_OFFSET + PFN_PHYS(ARCH_PFN_OFFSET))
>>
>> and use in your patch:
>>
>> 	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, zholes_size);
>>
>> So I would recommend to use ARCH_PFN_OFFSET.
> 
> Well, currently ARCH_PFN_OFFSET is defined in
> asm-generic/memory_model.h only for FLATMEM case.  I think other
> memory models do not need it because it is just a case that a first
> hole begins at pfn 0.
> 

That's true, I thought it was defined whatever the mem models...

what about this, on top of your patch ?

-- >8 --

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index c6e684d..eb1b3fc 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -166,8 +166,8 @@ void __init paging_init(void)
 {
 	unsigned long zones_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
 	unsigned long max_dma, high, low;
-	unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
 #ifndef CONFIG_FLATMEM
+	unsigned long zholes_size[] = { [0 ... MAX_NR_ZONES - 1] = 0 };
 	unsigned long i, j, pfn;
 #endif
 
@@ -207,8 +207,10 @@ #ifndef CONFIG_FLATMEM
 		for (j = 0; j < zones_size[i]; j++, pfn++)
 			if (!page_is_ram(pfn))
 				zholes_size[i]++;
-#endif
 	free_area_init_node(0, NODE_DATA(0), zones_size, 0, zholes_size);
+#else
+	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, NULL);
+#endif
 }
 
 static struct kcore_list kcore_mem, kcore_vmalloc;
