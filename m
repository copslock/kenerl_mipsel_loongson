Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2018 21:17:47 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:40854
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeAYURj5s1XQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Jan 2018 21:17:39 +0100
Received: by mail-lf0-x244.google.com with SMTP id h92so11408587lfi.7;
        Thu, 25 Jan 2018 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=exSu4RQnhYmBJMdRLPC6ZWODtn8fpoayRxA+TgGn92s=;
        b=ajiNDEr74qyzLYQvx3eQHP9IfUr+n/YZALoHu8zB1P4UD6t2LWLKIqUbMhl2j9MgCi
         KHCkTH8DtDYbS8LYh38bZ2g1C5qfZTCmCOkg2AyNMFPa51ax0QnOXRBvO527AY5qwXxg
         LxUCroXMD39n8ZwKGiZjx+CBB2w6Wb9Kuul3commXD5hC60l3TCpoMyeUliTzg0/ahL/
         MGcB2xXJERIHj8aJ1clsxLE6pNzR0yd1PXBtrg3/b4uHjNUw/4Gi3pJVV+fIuxjvo51d
         pzoq8kyyYBA2aqDSdE86x/yfuceJZ8Hsx0Rk1/taSGY+SLbHd1KJ0KIrxkPSCi4SBZnb
         EQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=exSu4RQnhYmBJMdRLPC6ZWODtn8fpoayRxA+TgGn92s=;
        b=ISRRASMPM8dPyTBKlufca1YFn/q0SFhkE5BMfEn3X3w1qbunSlWpsDlLUwuHlJkTvp
         oskvJTyUUllTlIlgwQ5yGLHL0aLa7dwqxrLL/KqXbpe2BjUaWx4bE5pJHkHwJZYBf/Ji
         6Yuxw3MEqid2NVdRnynwqhxPxJzMKnIIhIGYA6Z5y2OEj2kx28hiEClpOGSExKDvS2C8
         CgDmCR4USQFS8FB+aoMbrE4QG7h9flHPhLDGbULJibs2F06R4M9QG2/YPPr3ss3Fmgqb
         o/UXu3IYZZWf3CR1Zox+iCvvLR6y3mBC/ZVG8Y1ke9wFVL8WY0RXtqKDSFXxcNSSdo/5
         TYPg==
X-Gm-Message-State: AKwxytdlJAYEiv3z0+NXzCN1NsM1SWWQ2g93kBJAn0Rx78mjI541xY41
        0mprhdTezsOnCC7PNsXY+no=
X-Google-Smtp-Source: AH8x227yNnUfh1ayQ0oDEdunI65Yz2bRq+myVxmjHrecCMZBkhrHs7VuzSYklUUr5jut3Bx4RxxLzg==
X-Received: by 10.46.68.11 with SMTP id r11mr6403903lja.13.1516911453943;
        Thu, 25 Jan 2018 12:17:33 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id l66sm1118852lfe.15.2018.01.25.12.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 12:17:33 -0800 (PST)
Date:   Thu, 25 Jan 2018 23:17:49 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com,
        matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] MIPS: memblock: Switch arch code to NO_BOOTMEM
Message-ID: <20180125201749.GA7074@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <f8626b9b-56b7-f1b0-6771-9cf573050bb4@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8626b9b-56b7-f1b0-6771-9cf573050bb4@nokia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Hello Alexander,

On Thu, Jan 25, 2018 at 06:58:07PM +0100, Alexander Sverdlin <alexander.sverdlin@nokia.com> wrote:
> Hello Serge,
> 
> On 17/01/18 23:22, Serge Semin wrote:
> > The patchset is applied on top of kernel 4.15-rc8 and can be found
> > submitted at my repo:
> > https://github.com/fancer/Linux-kernel-MIPS-memblock-project
> 
> I've tested the Linux from your repo on Octeon2 and it looks good to me.
> I've only tested startup though. Therefore,
> 
> Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 

Great! Thank you very much for doing this. I'll include the info about all the
tested platforms to the cover letter of the next patchset.

> I've noticed one positive effect I cannot explain -- with almost the same
> physical memory map I observe almost 2 megabytes more available memory
> after startup:
> 
> without patches:
> 
> root@(none):~ >free
>               total        used        free      shared  buff/cache   available
> Mem:         955040       16264      839948       80068       98828      810068
> Swap:             0           0           0
> 
> memory map:
> 
> memory: 0000000001090dc0 @ 0000000009000000 (usable after init)
> memory: 0000000005400000 @ 0000000002b00000 (usable)
> memory: 0000000000c00000 @ 0000000008200000 (usable)
> memory: 0000000004800000 @ 000000000a100000 (usable)
> memory: 000000001fc00000 @ 0000000020000000 (usable)
> memory: 0000000010000000 @ 0000000040000000 (usable)
> memory: 000000000190a9d0 @ 0000000001100000 (usable)
> 
> ----------------------------------------
> 
> with patches:
> 
> root@(none):~ >free
>               total        used        free      shared  buff/cache   available
> Mem:         955028       14292      841884       80068       98852      811996
> Swap:             0           0           0
> 
> memory map:
> 
> memory: 0000000001090e00 @ 0000000009000000 (usable after init)
> memory: 0000000005400000 @ 0000000002b00000 (usable)
> memory: 0000000000c00000 @ 0000000008200000 (usable)
> memory: 0000000004800000 @ 000000000a100000 (usable)
> memory: 000000001fc00000 @ 0000000020000000 (usable)
> memory: 0000000010000000 @ 0000000040000000 (usable)
> memory: 000000000190c9d0 @ 0000000001100000 (usable)
> 

That's interesting. My suggestion is that the old code used to reserve all
the memory below kernel _end symbol. So if the kernel isn't loaded right at
the start of the lowest memory range, then there is going to be a wasted
memory between the range start and the _text kernel symbol:
[PATCH 04/14] MIPS: memblock: Discard bootmem initialization
My code reserves only the memory occupied by the kernel within [_text, _end]:
[PATCH 05/14] MIPS: memblock: Add reserved memory regions to memblock

There might be some other reason of the lesser memory consumption though.
Hopefully I didn't forget to reserve some necessary memory ranges.)

Regards,
-Sergey

> 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > Serge Semin (14):
> >   MIPS: memblock: Add RESERVED_NOMAP memory flag
> >   MIPS: memblock: Surely map BSS kernel memory section
> >   MIPS: memblock: Reserve initrd memory in memblock
> >   MIPS: memblock: Discard bootmem initialization
> >   MIPS: memblock: Add reserved memory regions to memblock
> >   MIPS: memblock: Reserve kdump/crash regions in memblock
> >   MIPS: memblock: Mark present sparsemem sections
> >   MIPS: memblock: Simplify DMA contiguous reservation
> >   MIPS: memblock: Allow memblock regions resize
> >   MIPS: memblock: Perform early low memory test
> >   MIPS: memblock: Print out kernel virtual mem layout
> >   MIPS: memblock: Discard bootmem from Loongson3 code
> >   MIPS: memblock: Discard bootmem from SGI IP27 code
> >   MIPS: memblock: Deactivate bootmem allocator
> 
> -- 
> Best regards,
> Alexander Sverdlin.
