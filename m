Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 18:28:55 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:57800 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492052Ab0D1Q2w convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Apr 2010 18:28:52 +0200
Received: by fxm17 with SMTP id 17so583762fxm.36
        for <multiple recipients>; Wed, 28 Apr 2010 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ouys47hPXaT1rhuQPbyKaHeT4L/3PPgWchffNiYzp0M=;
        b=dzpNiov7b0pgdqmsCb6J2TOv3a7HyZikOkzTL8jSHPO0PhA0cVs7OqylCwN0n7vRWh
         zdzRRbvzCi8p/ZdYkkL4i/+sobhZpQLc/w0mvpfMvYyXreXPUqKGzDEgATRysXPcDCzu
         41vRIm7bRYPh1HXDh6SA2PcYpslLr9vc52yJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uXTCinJoNHK5nd/U9K6cnuWRRCsXL6r3sdQDZB1fDFrK5P3q/TMPyMaHgTT0UWhaKF
         d9okCHaggWUxhWoYXGOFpXyjurTVlTh0hWxuWdfv6Wx2RkqNpM2eIj7h7vZ//PhL3zWx
         TpgcMtE434yqiM6nqMCFVVzArOyNJEGK7fVAk=
MIME-Version: 1.0
Received: by 10.223.99.78 with SMTP id t14mr420292fan.85.1272472125755; Wed, 
        28 Apr 2010 09:28:45 -0700 (PDT)
Received: by 10.223.106.12 with HTTP; Wed, 28 Apr 2010 09:28:45 -0700 (PDT)
In-Reply-To: <20100428155439.GA19468@linux-mips.org>
References: <k2lf861ec6f1004270514k199cace5wafd6dd269ded8911@mail.gmail.com>
         <20100428155439.GA19468@linux-mips.org>
Date:   Wed, 28 Apr 2010 18:28:45 +0200
Message-ID: <k2tf861ec6f1004280928r92dba2c2u94b9a488a1e5f41c@mail.gmail.com>
Subject: Re: use bootmem in platform code on MIPS
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Apr 28, 2010 at 5:54 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Apr 27, 2010 at 02:14:32PM +0200, Manuel Lauss wrote:
>
>> I'd like to use bootmem to reserve large chunks of RAM (at a particular physical
>> address; for Au1200 MAE, CIM and framebuffer, and later Au1300 OpenGL block)
>> but it seems that it can't be done:  Doing __alloc_bootmem() in
>> plat_mem_setup() is
>> too early, while an arch_initcall() is too late because by then the
>> slab allocator is
>> already up and handing out random addresses and/or refusing allocations larger
>> than a few MBytes.
>
> The maximum is actually configurable.  CONFIG_FORCE_MAX_ZONEORDER defaults
> to 11 which means with 4kB pages you get 8MB maximum allocation - more for
> larger pages.

I already had to modify it for large display resolutions.


> CONFIG_FORCE_MAX_ZONEORDER is a tradeoff though.  A smaller value will give
> slightly better performance and safe a bit of memory but I can't really
> quantify these numbers - I assume it's a small difference.
>
> It may actually be preferable to never tell the bootmem allocator about the
> memory you need for these devices that is bypass the mm code entirely.

Do you mean by not adding the whole RAM area with add_memory_region()?
Can I give the memory back later (if it's not required)?  Right now I think with
bootmem that is actually possible.


>> Is there another callback I could use which would allow me to use bootmem (short
>> of abusing plat_smp_setup)?
>>
>> Would a separate callback like this be an acceptable solution?
>
> Certainly better than using plat_smp_setup which would require enabling
> SMP support for no good reason at all.
>
> I know we will eventually have to add another platform hooks to run after
> bootmem_init.  The name of plat_mem_setup() already shows what this hook
> originally was meant for but it ended up as the everything-and-the-kitchen-
> sink hook for platform-specific early initialization.  I just dislike

The comment above arch_mem_init() too mentions a separate function.


> conditional hooks.  Let's add a call to a new hook function and fix whatever
> breaks or think about what other hooks needs there should be.

Okay, I'll cook something up.

Thank you,
        Manuel Lauss
