Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 18:47:57 +0200 (CEST)
Received: from mail-qc0-f181.google.com ([209.85.216.181]:35788 "EHLO
        mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007457AbbE1QrzwEkCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 18:47:55 +0200
Received: by qchk10 with SMTP id k10so16775139qch.2;
        Thu, 28 May 2015 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1PIGX9/gPdVkvfZ1XHtIvgSxTiX4YgfbbiSX+BP+LoU=;
        b=XhNTWCqbWOyggH7lXrLVOlUWQLFU2MlRQ/F4/lYLWx+sbH8ATO9NInMvfJpnQctvzK
         AivKFXehmZmEi1bZIpFmGJQ4hAmSR0I6xhBjW+4b5L2/F5VUY4MxNTlHR5rZsbf1bqPu
         sLowS5F87J4F/4EB4TgcOoU2dg9JR1i/rE+53iHiZ3nVzXFm7A8L8zJXvUxSZty4eE/3
         PUQs0JMU3WccNoX7hKjSrrgGAd7CoLQYZTv9qHT2igfg/VPxc0lVI5DdK5c18/1wCDq9
         iwLEPXYLNVqZ0DCCQ6LtEal8JSImZn8Cj37eF82tYiAxbvTbT+eDDV6Tpf9GS2EiWwUp
         bepg==
X-Received: by 10.140.194.199 with SMTP id p190mr4645246qha.76.1432831671462;
 Thu, 28 May 2015 09:47:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.106.196 with HTTP; Thu, 28 May 2015 09:47:31 -0700 (PDT)
In-Reply-To: <20150528164037.GB7012@linux-mips.org>
References: <20150527062508.CD24722020B@puck.mtv.corp.google.com> <20150528164037.GB7012@linux-mips.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 28 May 2015 09:47:31 -0700
Message-ID: <CAJiQ=7Djh9_hponDG6bCMEhw7m0G=Sb8JeCLXCVATNNaGDWWZg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Petri Gynther <pgynther@google.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Thu, May 28, 2015 at 9:40 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, May 26, 2015 at 11:25:08PM -0700, Petri Gynther wrote:
>
>> bmips_wr_vec() copies exception vector code from start to dst.
>>
>> The call to dma_cache_wback() needs to flush (end-start) bytes,
>> starting at dst, from write-back cache to memory.
>>
>> Signed-off-by: Petri Gynther <pgynther@google.com>
>> ---
>>  arch/mips/kernel/smp-bmips.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
>> index fd528d7..336708a 100644
>> --- a/arch/mips/kernel/smp-bmips.c
>> +++ b/arch/mips/kernel/smp-bmips.c
>> @@ -444,7 +444,7 @@ struct plat_smp_ops bmips5000_smp_ops = {
>>  static void bmips_wr_vec(unsigned long dst, char *start, char *end)
>>  {
>>       memcpy((void *)dst, start, end - start);
>> -     dma_cache_wback((unsigned long)start, end - start);
>> +     dma_cache_wback(dst, end - start);
>
> dma_cache_wback is a guess what - DMA function.  It doesn't handle
> I-caches at all and on some platforms might actually do nothing at all.
> or use other optimizations that only work for DMA buffers and it's not
> SMP aware - nor will it.  So if it ever worked for your case then just
> because you're lucky.  This really should use flush_icache_range which
> also conveniently for your code takes an end pointer as argument.

This flush isn't intended to handle I$.  It is intended to flush the
newly written code all the way out to DRAM (not just to L2) so that it
can be executed through an uncached kseg1 alias.  On initial boot, a
BMIPS secondary CPU comes up with its I$ disabled (5000) or in an
uninitialized state (43xx).
