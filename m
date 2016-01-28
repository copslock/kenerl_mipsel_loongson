Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 08:38:23 +0100 (CET)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34695 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008613AbcA1HiUIrlkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 08:38:20 +0100
Received: by mail-wm0-f67.google.com with SMTP id p63so1917982wmp.1;
        Wed, 27 Jan 2016 23:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=27K2gNSbsz/51Zcgq8rT9pbtz7HBwUXw95k23fTIKfc=;
        b=OL/EJFNwzE1ToFJpHKOvPngD0zsnWimkYrj88THQRBAiT+Eq6op+B3YI+MU9q0X1pM
         vabjhqZOH6vhutr4TT8SjSJKJBtVFMpBRF4r+oGGHhIQXbiU+bd7a4RCpjQP1nlirkNw
         0a9n9MwGu6NFqCphuijuveoMmbYQyR+M+InB6tSRFNG92hlv4zz7bfzLOyIYhPzrIY1x
         xcIlRELADoBNWnqkTdjLMQyxiIR2EiktaBHUIS3eT1S+Za/sxpmsZiODcPkx6r2HeKM7
         aCxkp2N0OpiarfS+SRJUDuhXm9tY5ek1ultGDJdL//zCsr0wRlYcc+h+KX6Hty0tXOaf
         oR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=27K2gNSbsz/51Zcgq8rT9pbtz7HBwUXw95k23fTIKfc=;
        b=IT75keGyA+B83GLonn+/yw/1Sm61JRRnuublP5hmxKg0XOdiPx1t09tqpJ/PWkiWTH
         +Chddw16suUYd/CiH0QjfHAUhQ+w6k6+0hJfyvTCu8cMap+RNTfhblrF+ZEfU9Nj4Ap7
         IYgzgKSYbHwFet5kazEthKeEdhVlS5LnfUd4dzDWIuMbqVp0vSHtDQp7bXh6UbDXIbfO
         oFmx9qgaX9oTKX6Af5Ig/9MSwzg6VCF1GuDUdAx0ijcIPx0tuqERu8GYlsZyXP8K4yg0
         /9sMIpGHePi38MXE5MicOOj6plEyf3N2aMgVByNyKI6mgELlkjaI/PwHHoHE/YVMM9Tg
         vjgw==
X-Gm-Message-State: AG10YORBgGe6LYjjkFqAhmyGIqPy8J4r5Xhd4CIuAPOOuM/oBdKpucfC3QE1z6dFZIUHEDAuz1AQT1HKux8+iw==
MIME-Version: 1.0
X-Received: by 10.194.157.3 with SMTP id wi3mr1444829wjb.30.1453966694426;
 Wed, 27 Jan 2016 23:38:14 -0800 (PST)
Received: by 10.27.13.15 with HTTP; Wed, 27 Jan 2016 23:38:14 -0800 (PST)
In-Reply-To: <20160127111557.GA19682@jhogan-linux.le.imgtec.org>
References: <1453814784-14230-1-git-send-email-chenhc@lemote.com>
        <1453814784-14230-6-git-send-email-chenhc@lemote.com>
        <20160126134229.GA12365@jhogan-linux.le.imgtec.org>
        <CAAhV-H5zFb=rnESwHvgykNVe1FyAC1WX5zAHUXswYwu7a=VPKw@mail.gmail.com>
        <20160127111557.GA19682@jhogan-linux.le.imgtec.org>
Date:   Thu, 28 Jan 2016 15:38:14 +0800
X-Google-Sender-Auth: 56Smm-R1O20JuXkafcck85krJ1k
Message-ID: <CAAhV-H6bzZ1cP_YeWWqZa1W0+62rz0ZbCEdfZGTVgBBier6g9A@mail.gmail.com>
Subject: Re: [PATCH 5/6] MIPS: Loongson: Introduce and use cpu_has_coherent_cache
 feature
From:   Huacai Chen <chenhc@lemote.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51506
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

Hi, James,

First I want to update some information:
1) Loongson-3's dcaches don't alias (if PAGE_SIZE>=16K).
2) Loongson-3's icache is coherent with dcache.
3) Loongson-3 maintain cache coherency across cores.

Even if I set cpu_has_dc_aliases to 0 and set cpu_has_ic_fills_f_dc to
1 is not enough, because I also want to skip flush_cache_all(). So,
maybe cpu_has_coherent_cache is a good name?

Huacai

On Wed, Jan 27, 2016 at 7:15 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Huacai,
>
> On Wed, Jan 27, 2016 at 12:58:42PM +0800, Huacai Chen wrote:
>> "cache coherency" here means the coherency across cores, not ic/dc
>> coherency, could you please suggest a suitable name?
>
> Data cache coherency across cores is pretty much a requirement for SMP.
> It looks more like for various reasons you can skip the cache management
> functions, e.g.
>
>> >> @@ -503,6 +509,9 @@ static void r4k_flush_cache_range(struct vm_area_struct *vma,
>> >>  {
>> >>       int exec = vma->vm_flags & VM_EXEC;
>> >>
>> >> +     if (cpu_has_coherent_cache)
>> >> +             return;
>
> This seems to suggest:
> 1) Your dcaches don't alias.
> 2) Your icache is coherent with your dcache, otherwise you would need to
>    flush the icache here so that mprotect RW->RX makes code executable
>    without risk of stale lines existing in icache.
>
> So, is that the case?
>
> If so, it would seem better to ensure that cpu_has_dc_aliases evaluates
> to false, and add a similar one for icache coherency, hence my original
> suggestion.
>
>
>> >> +
>> >>       if (cpu_has_dc_aliases || (exec && !cpu_has_ic_fills_f_dc))
>> >>               r4k_on_each_cpu(local_r4k_flush_cache_range, vma);
>
> (Note, this cpu_has_ic_fills_f_dc check is wrong, it shouldn't prevent
> icache flush, see http://patchwork.linux-mips.org/patch/12179/)
>
> Cheers
> James
>
>> >>  }
>> >> @@ -627,6 +636,9 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>> >>  {
>> >>       struct flush_cache_page_args args;
>> >>
>> >> +     if (cpu_has_coherent_cache)
>> >> +             return;
>> >> +
>> >>       args.vma = vma;
>> >>       args.addr = addr;
>> >>       args.pfn = pfn;
>> >> @@ -636,11 +648,17 @@ static void r4k_flush_cache_page(struct vm_area_struct *vma,
>> >>
>> >>  static inline void local_r4k_flush_data_cache_page(void * addr)
>> >>  {
>> >> +     if (cpu_has_coherent_cache)
>> >> +             return;
>> >> +
>> >>       r4k_blast_dcache_page((unsigned long) addr);
>> >>  }
>> >>
>> >>  static void r4k_flush_data_cache_page(unsigned long addr)
>> >>  {
>> >> +     if (cpu_has_coherent_cache)
>> >> +             return;
>> >> +
>> >>       if (in_atomic())
>> >>               local_r4k_flush_data_cache_page((void *)addr);
>> >>       else
>> >> @@ -825,6 +843,9 @@ static void local_r4k_flush_cache_sigtramp(void * arg)
>> >>
>> >>  static void r4k_flush_cache_sigtramp(unsigned long addr)
>> >>  {
>> >> +     if (cpu_has_coherent_cache)
>> >> +             return;
>> >> +
>> >>       r4k_on_each_cpu(local_r4k_flush_cache_sigtramp, (void *) addr);
>> >>  }
>> >>
>> >> --
>> >> 2.4.6
>> >>
>> >>
>> >>
>> >>
>> >>
