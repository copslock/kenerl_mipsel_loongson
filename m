Return-Path: <SRS0=nFqH=QH=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D2C169C4
	for <linux-mips@archiver.kernel.org>; Thu, 31 Jan 2019 07:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD5120870
	for <linux-mips@archiver.kernel.org>; Thu, 31 Jan 2019 07:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rCd82aqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfAaHHg (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:07:36 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:24488 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfAaHHf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 31 Jan 2019 02:07:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43qrsH3KnTz9v0Ql;
        Thu, 31 Jan 2019 08:07:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rCd82aqn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DAzsBnhWoB9O; Thu, 31 Jan 2019 08:07:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43qrsH1tsMz9v0Qj;
        Thu, 31 Jan 2019 08:07:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548918451; bh=MXHl21tpazUCycYGJIF5K2H108fXMrwBKp0kMfVZOHU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rCd82aqnCmgVKey8lh2qo7e2czYPgKR5K0SsqXWaaG+aPdVhNoJAHK8cvl05jNaLQ
         01Tbj78zc0z794OUHngjeqyEvlUQI7ONSfsFOcwtpy8Q//8zmi0Zwd5Q5S7O8IAO0Y
         J0iKKRNhFMGd08UKWW9aHyiQ2pzFvIMvvFhWRBCY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 176168B78D;
        Thu, 31 Jan 2019 08:07:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9D0PmJeNjYuQ; Thu, 31 Jan 2019 08:07:31 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 075218B74C;
        Thu, 31 Jan 2019 08:07:29 +0100 (CET)
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
        linux-ia64@vger.kernel.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Salter <msalter@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
        linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        openrisc@lists.librecores.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
 <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
 <20190131064139.GB28876@rapoport-lnx>
 <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d5e4ff5b-d33a-e641-8159-d4f83bc28d0b@c-s.fr>
Date:   Thu, 31 Jan 2019 08:07:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <8838f7ab-998b-6d78-02a8-a53f8a3619d9@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



Le 31/01/2019 à 07:44, Christophe Leroy a écrit :
> 
> 
> Le 31/01/2019 à 07:41, Mike Rapoport a écrit :
>> On Thu, Jan 31, 2019 at 07:07:46AM +0100, Christophe Leroy wrote:
>>>
>>>
>>> Le 21/01/2019 à 09:04, Mike Rapoport a écrit :
>>>> Add check for the return value of memblock_alloc*() functions and call
>>>> panic() in case of error.
>>>> The panic message repeats the one used by panicing memblock 
>>>> allocators with
>>>> adjustment of parameters to include only relevant ones.
>>>>
>>>> The replacement was mostly automated with semantic patches like the one
>>>> below with manual massaging of format strings.
>>>>
>>>> @@
>>>> expression ptr, size, align;
>>>> @@
>>>> ptr = memblock_alloc(size, align);
>>>> + if (!ptr)
>>>> +     panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
>>>> size, align);
>>>>
>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
>>>> Acked-by: Paul Burton <paul.burton@mips.com>         # MIPS
>>>> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
>>>> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
>>>> ---
>>>
>>> [...]
>>>
>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>> index 7ea5dc6..ad94242 100644
>>>> --- a/mm/sparse.c
>>>> +++ b/mm/sparse.c
>>>
>>> [...]
>>>
>>>> @@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned 
>>>> long size, int nid)
>>>>           memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>>>>                           __pa(MAX_DMA_ADDRESS),
>>>>                           MEMBLOCK_ALLOC_ACCESSIBLE, nid);
>>>> +    if (!sparsemap_buf)
>>>> +        panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d 
>>>> from=%lx\n",
>>>> +              __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
>>>> +
>>>
>>> memblock_alloc_try_nid_raw() does not panic (help explicitly says: 
>>> Does not
>>> zero allocated memory, does not panic if request cannot be satisfied.).
>>
>> "Does not panic" does not mean it always succeeds.
> 
> I agree, but at least here you are changing the behaviour by making it 
> panic explicitly. Are we sure there are not cases where the system could 
> just continue functionning ? Maybe a WARN_ON() would be enough there ?

Looking more in details, it looks like everything is done to live with 
sparsemap_buf NULL, all functions using it check it so having it NULL 
shouldn't imply a panic I believe, see code below.

static void *sparsemap_buf __meminitdata;
static void *sparsemap_buf_end __meminitdata;

static void __init sparse_buffer_init(unsigned long size, int nid)
{
	WARN_ON(sparsemap_buf);	/* forgot to call sparse_buffer_fini()? */
	sparsemap_buf =
		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
						__pa(MAX_DMA_ADDRESS),
						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
	sparsemap_buf_end = sparsemap_buf + size;
}

static void __init sparse_buffer_fini(void)
{
	unsigned long size = sparsemap_buf_end - sparsemap_buf;

	if (sparsemap_buf && size > 0)
		memblock_free_early(__pa(sparsemap_buf), size);
	sparsemap_buf = NULL;
}

void * __meminit sparse_buffer_alloc(unsigned long size)
{
	void *ptr = NULL;

	if (sparsemap_buf) {
		ptr = PTR_ALIGN(sparsemap_buf, size);
		if (ptr + size > sparsemap_buf_end)
			ptr = NULL;
		else
			sparsemap_buf = ptr + size;
	}
	return ptr;
}


Christophe
