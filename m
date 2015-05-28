Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 20:25:49 +0200 (CEST)
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36071 "EHLO
        mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007627AbbE1SZsL8SCT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 20:25:48 +0200
Received: by qgf2 with SMTP id 2so20202275qgf.3
        for <linux-mips@linux-mips.org>; Thu, 28 May 2015 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9WXAw8J+9zDwffSTYT+tNRHxPtT79PskZqbQFTAnsgs=;
        b=oScjb9VD0cQWjZfbcQVJNeGJRAlhDXC9MydbvUsFkorrW8GqH8EE9ko1rPBIeaFVew
         VyMsCYJudFlEy+p8Y20RSt9T9iZLhwlDKh5ASyxDcx8r1fhUSsIMmfKARUpUuJqIJsyE
         Xvbvf/ALxHQaq0FbLbMRWkYo9uN1eyiesmJAyq0yvIWzrn1WeD3DsA1URZcBqbJG21c1
         i1j59M10COgfm6YwD2uaLd88Z7xgPy9WS0O5jY64F6RjHNHaHNb4LyAoWtY0QcZfDd7x
         mst2TupQAxUuhogDJYlVaXvOBbyir3NMXtcWfYPYeo1JQvE11ePg7xsuedwCNstOZgcy
         Rgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9WXAw8J+9zDwffSTYT+tNRHxPtT79PskZqbQFTAnsgs=;
        b=SSnXKC4O9TQGqej7mcZQFcoCyu1FVIkLqefjS+Q5V5s4TKU5Hh/Nb5JwfuROz6T5HN
         DuhGWugCoCG6hixebHOokrv5dWBnmXvm33n5HNRNrGdRGePKqbPyDnU2zoUhzDfoSfoY
         50pho5NpjEl9SeRNAAtxsI25ww4TttahRO8CudgRjbn1njS8L6bF7YjrultOyz46V9E8
         sXbb8C7NhEZyDkADKglgZbKDwOY/LmIdsorociU+OAkbLMRp3b/IPT3iJWS028KSn5XK
         Lzu6Nqv5caI8rzwT1c/Xnc8rg6NdnmegRNnRhCdsFd5P+a2Y/B7Lq5yHZeY+KxGR/7XW
         UBww==
X-Gm-Message-State: ALoCoQnkF1IvNLxuyAaFqDdlhew/O94zNBNT0sqhg7SVwu3PsU7ye4mq7mdyIz4gBGljsI8wIz9c
MIME-Version: 1.0
X-Received: by 10.140.131.21 with SMTP id 21mr5259877qhd.51.1432837545147;
 Thu, 28 May 2015 11:25:45 -0700 (PDT)
Received: by 10.229.66.131 with HTTP; Thu, 28 May 2015 11:25:45 -0700 (PDT)
In-Reply-To: <CAJiQ=7Djh9_hponDG6bCMEhw7m0G=Sb8JeCLXCVATNNaGDWWZg@mail.gmail.com>
References: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
        <20150528164037.GB7012@linux-mips.org>
        <CAJiQ=7Djh9_hponDG6bCMEhw7m0G=Sb8JeCLXCVATNNaGDWWZg@mail.gmail.com>
Date:   Thu, 28 May 2015 11:25:45 -0700
Message-ID: <CAGXr9JG3R24nScXTCNuoViAdBac02-XWuYCbBzxQ=6xub3g4TA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
From:   Petri Gynther <pgynther@google.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

On Thu, May 28, 2015 at 9:47 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Thu, May 28, 2015 at 9:40 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Tue, May 26, 2015 at 11:25:08PM -0700, Petri Gynther wrote:
>>
>>> bmips_wr_vec() copies exception vector code from start to dst.
>>>
>>> The call to dma_cache_wback() needs to flush (end-start) bytes,
>>> starting at dst, from write-back cache to memory.
>>>
>>> Signed-off-by: Petri Gynther <pgynther@google.com>
>>> ---
>>>  arch/mips/kernel/smp-bmips.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
>>> index fd528d7..336708a 100644
>>> --- a/arch/mips/kernel/smp-bmips.c
>>> +++ b/arch/mips/kernel/smp-bmips.c
>>> @@ -444,7 +444,7 @@ struct plat_smp_ops bmips5000_smp_ops = {
>>>  static void bmips_wr_vec(unsigned long dst, char *start, char *end)
>>>  {
>>>       memcpy((void *)dst, start, end - start);
>>> -     dma_cache_wback((unsigned long)start, end - start);
>>> +     dma_cache_wback(dst, end - start);
>>
>> dma_cache_wback is a guess what - DMA function.  It doesn't handle
>> I-caches at all and on some platforms might actually do nothing at all.
>> or use other optimizations that only work for DMA buffers and it's not
>> SMP aware - nor will it.  So if it ever worked for your case then just
>> because you're lucky.  This really should use flush_icache_range which
>> also conveniently for your code takes an end pointer as argument.
>
> This flush isn't intended to handle I$.  It is intended to flush the
> newly written code all the way out to DRAM (not just to L2) so that it
> can be executed through an uncached kseg1 alias.  On initial boot, a
> BMIPS secondary CPU comes up with its I$ disabled (5000) or in an
> uninitialized state (43xx).

Just wondering if we should just use:
r4k_blast_dcache()
r4k_blast_scache()

here instead? r4k_blast_dcache() is currently exported, but
r4k_blast_scache() is not.
