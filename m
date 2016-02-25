Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 06:37:05 +0100 (CET)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34991 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007280AbcBYFhDf5v2b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 06:37:03 +0100
Received: by mail-wm0-f44.google.com with SMTP id c200so12214968wme.0;
        Wed, 24 Feb 2016 21:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=I/mqIBt/JNe6eddC3EmhBJx1WKHb/C0f98qTYdiHFgA=;
        b=x366cVI39uEZve8EwpToO2r6p3/yl2VObuZ79EjIoxWM+K1PrvL9fz221GGF62jAau
         Vm4X9L78iRC+PB0TDnmpjoCW4zjx6upIBETiAtX4yDYP/w2rhgUAX77x5rC81FjrvSKz
         8JLcMh+rHnfInUXTobMwPTSl8EJzPH2TLeNF0yL3rGaFpDEu+lnKMZ2qQ5/v7H3fxiEb
         5v/OUfP4Nbtv1hEiyW/rvhPrLFlaaeqtjC2ZDhDVkhSfzQF3KaU+R3ZzJ5gvPKN3Lvsz
         MDjt9Ay4CpkhNGVTkKqvCWvhGWenr1qUdbRCDaAScyuRA6wIA9gVvxjsSNp8YAq/KPd1
         4FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I/mqIBt/JNe6eddC3EmhBJx1WKHb/C0f98qTYdiHFgA=;
        b=UZUYMHhYy343GYf2R87SG0+L47w07A/AeaFMI21Ll8Ef0DEdSWDxQlKPj9+2MbXn35
         RIHfL/jfR/RIxgVlt6/KJbORBLn1Pu4OQsw8m5TX+SkqTBGZlkSahsnPw2mqZsDyjMn8
         Flt94Ozr2EntPKn9EHKmaKUycmJXnvkvqA+0XoxIEkqE5/9ThtFsd7Gb4UNRDb4IuFRv
         MCQROJ2Hv7vIVa7ccA+2xcogrZYEN5vQz0AwrcjAB8jFSVmlHB2PolIJsVWTlePEQD8N
         HX0bqqC54VF0L95yLeI/GhUkQvh/pptaXOPYg527kFHjcTAhWASO08zja8hvXRtX8Ltr
         /I+Q==
X-Gm-Message-State: AG10YOTqnytMgJXwE8+fRRIyb818Mr99p5qkwLLm+SXBCy+MLO1Tth1WZWZfQXAcwaT1sxukhNIZhXza3D/LDQ==
MIME-Version: 1.0
X-Received: by 10.194.220.230 with SMTP id pz6mr42566807wjc.39.1456378618395;
 Wed, 24 Feb 2016 21:36:58 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Wed, 24 Feb 2016 21:36:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1602250050170.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-3-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250050170.15885@tp.orcam.me.uk>
Date:   Thu, 25 Feb 2016 13:36:58 +0800
X-Google-Sender-Auth: _AlLBMfwWfjmLg4ZymGc8Sg-RwY
Message-ID: <CAAhV-H5NW7NG0C9OU-qjCzPO-CB+pWmsh0RC0ZmKKmUx0U75=Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Introduce cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Maciej

Joshua Kinard suggest me to split the patch, which you can see here:
https://patchwork.linux-mips.org/patch/12324/
If it is better to not split, please see my V2 patchset.

Huacai

On Thu, Feb 25, 2016 at 8:59 AM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Wed, 24 Feb 2016, Huacai Chen wrote:
>
>> If a platform maintains cache coherency by hardware fully:
>>  1) It's icache is coherent with dcache.
>>  2) It's dcaches don't alias (maybe depend on PAGE_SIZE).
>>  3) It maintains cache coherency across cores (and for DMA).
>>
>> So we introduce a MIPS_CPU_CACHE_COHERENT bit, and a cpu feature named
>> cpu_has_coherent_cache to modify MIPS's cache flushing functions.
> [...]
>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>> index caac3d7..04a38d8 100644
>> --- a/arch/mips/mm/c-r4k.c
>> +++ b/arch/mips/mm/c-r4k.c
>> @@ -428,6 +428,9 @@ static void r4k_blast_scache_setup(void)
>>
>>  static inline void local_r4k___flush_cache_all(void * args)
>>  {
>> +     if (cpu_has_coherent_cache)
>> +             return;
>> +
> [etc.]
>
>  Have you considered setting the relevant handlers to `cache_noop' in
> `r4k_cache_init' instead?  It seems more natural to me and avoids the
> performance hit where `cpu_has_coherent_cache' is variable, which at this
> time means everywhere.
>
>  Also you don't set the MIPS_CPU_CACHE_COHERENT bit anywhere within you
> patch set -- is there a follow-up change you're going to submit?
>
>   Maciej
>
