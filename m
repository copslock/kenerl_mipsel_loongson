Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2018 20:27:07 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:45762
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbeAWT1AGyL3k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2018 20:27:00 +0100
Received: by mail-lf0-x241.google.com with SMTP id x196so2022855lfd.12;
        Tue, 23 Jan 2018 11:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJoobnKXN+e9dCufi7fRrxkRGEJx1e4zTzd1fsJyUUE=;
        b=uzz8wlRLnsoUSWQ4KeooK1mcYM9PWmhnOq7J+6vEEHmGjauTdGfu/At3BUJQy2APde
         1ppWcIM09qH6ETp8aW95ahQ31P11pwEDxt+5tGDJmiAQ+w7UknOpOg0kjK3iOK+WXi8a
         BxdbuyOJeviEJvppdQsm8Q+uzZr9Z1h4CA+roPkotdhSzDfgGafrHOai+z6ZDzuNcGuY
         ZQGCfHKqpFGsOMoUCsw+SZcj/tYhrgcDBBC/h8PR+MAHWFTczzh5SnipZsL1oO+fPXan
         VaU09afaxCnuQcXeYe/Ghk5UFZOiLkQpP762lFEhBBAlthiIYTbXllWZhCIYluxu2H+d
         1KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJoobnKXN+e9dCufi7fRrxkRGEJx1e4zTzd1fsJyUUE=;
        b=CO4qHzPFSZDyHmwF+6tHLYbkcfwwBbF0JsjJTZlvsZggf31g18aIMneNcph15UD42Z
         jpYXNimr59Y6nnzbpY3elOU1fXAxgHd/eg6wjtV8gEU8yr/scw74mvw7J2E/HcK7lh+T
         jcGsojMmtbGKD9/7XuXkpOSG3mfoLpmMrndj1zPylKK9LHJeSwX/FwEaJfbE1XCfbk/z
         xA3G+YKxKqoO94Uw5ruZDlW0XBupqanEbhQa+arjXRpnmCTBOaAnigL7P79Y91RVZfWY
         EOlOkgYc2nfUs7SlqUl6rsMzsmmNxY0zBDE9/bKTW4HyH+6YO23f5MUfMDf9fd+VvGs2
         M/hQ==
X-Gm-Message-State: AKwxyteyelg9eqpiEB05MIFOYYPlxl/Y3zYxLBiceJ1qKGfwoX0b0jnN
        Z5ODrenztBq+VA7Gd7Qk9tg=
X-Google-Smtp-Source: AH8x226eKP3MjghvtmlUyt8dwbKWOGbeSsaQ2Vlqu47L//86u/tYDSZhQwWyvHfeVVDknQSDNWNkkA==
X-Received: by 10.46.91.211 with SMTP id m80mr1809326lje.107.1516735614484;
        Tue, 23 Jan 2018 11:26:54 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id x7sm3107412ljc.9.2018.01.23.11.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 11:26:53 -0800 (PST)
Date:   Tue, 23 Jan 2018 22:27:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com,
        alexander.sverdlin@nokia.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] MIPS: memblock: Surely map BSS kernel memory
 section
Message-ID: <20180123192707.GB28147@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-3-fancer.lancer@gmail.com>
 <3fbb8850-bf34-d698-299a-f1cd62d063ae@mips.com>
 <20180122214746.GC32024@mobilestation>
 <8a26c7cd-966f-90d4-96c9-2f974808c2f4@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a26c7cd-966f-90d4-96c9-2f974808c2f4@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62288
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

Hello Matt,

On Tue, Jan 23, 2018 at 11:03:27AM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> Hi Serge,
> 
> On 22/01/18 21:47, Serge Semin wrote:
> >Hello Matt,
> >
> >On Mon, Jan 22, 2018 at 04:35:26PM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> >>Hi Serge,
> >>
> >>On 17/01/18 22:23, Serge Semin wrote:
> >>>The current MIPS code makes sure the kernel code/data/init
> >>>sections are in the maps, but BSS should also be there.
> >>
> >>Quite right - it should. But this was protected against by reserving all
> >>bootmem up to the _end symbol here:
> >>http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L388
> >>Which you remove in the next patch in this series. I'm not sure it is worth
> >
> >Right. Missed that part. The old code just doesn't set the kernel memory free
> >calling the free_bootmem() method for non-reserved parts below reserved_end.
> >
> >>disentangling the reserved_end stuff from the next patch to make this into a
> >>single logical change of reserving just .bss rather than everything below
> >>_end.
> >
> >Good point. I'll move this change into the "[PATCH 05/14] MIPS: memblock:
> >Add reserved memory regions to memblock". It logically belongs to that place.
> >Since basically by the arch_mem_addpart() calls we reserve all the kernel
> 
> 
> Actually I was wrong - it's not this sequence of arch_mem_addpart's that
> reserves the kernels memory. At least on DT based systems, it's pretty
> likely that these regions will overlap with the system memory already added.
> of_scan_flat_dt will look for the memory node and add it via
> early_init_dt_add_memory_arch.
> These calls to add the kernel text, init and bss detect that they overlap
> with the already present system memory, so don't get added, here:
> http://elixir.free-electrons.com/linux/v4.15-rc9/source/arch/mips/kernel/setup.c#L759
> 
> As such, when we print out the content of boot_mem_map, we only have a
> single entry:
> 
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 10000000 @ 00000000 (usable)
> 
> 
> >memory now I'd also merged them into a single call for the range [_text, _end].
> >What do you think?
> 
> 
> I think that this patch makes sense in case the .bss is for some reason not
> covered by an existing entry, but I would leave it as a separate patch.
> 
> Your [PATCH 05/14] MIPS: memblock: Add reserved memory regions to memblock
> is actually self-contained since it replaces reserving all memory up to _end
> with the single reservation of the kernel's whole size
> 
> +	size = __pa_symbol(&_end) - __pa_symbol(&_text);
> +	memblock_reserve(__pa_symbol(&_text), size);
> 
> 
> Which I think is definitely an improvement since it is much clearer.
> 

Alright lets sum it up. First of all, yeah, you are right, arch_mem_addpart()
is created to make sure the kernel memory is added to the memblock/bootmem pool.
The previous arch code was leaving such the memory range non-freed since it was
higher the reserved_end, so to make sure the early memory allocations wouldn't
be made from the pages, where kernel actually resides.

In my code I still wanted to make sure the kernel memory is in the memblock pool.
But I also noticed, that .bss memory range wouldn't be added to the pool if neither
dts nor platform-specific code added any memory to the boot_mem_map pool. So I
decided to fix it. The actual kernel memory reservation is performed after all
the memory regions are declared by the code you cited. It's essential to do
the [_text, _end] memory range reservation there, otherwise memblock may
allocate from the memory range occupied by the kernel code/data.

Since you agree with leaving it in the separate patch, I'd only suggest to
call the arch_mem_addpart() method for just one range [_text, _end] instead of
doing it three times for a separate _text, _data and bss sections. What do you
think?

Regards,
-Sergey

> Thanks,
> Matt
> 
> >
> >Regards,
> >-Sergey
> >
> >>
> >>Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
> >>
> >>Thanks,
> >>Matt
> >>
> >>>
> >>>Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >>>---
> >>>  arch/mips/kernel/setup.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>>diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >>>index 76e9e2075..0d21c9e04 100644
> >>>--- a/arch/mips/kernel/setup.c
> >>>+++ b/arch/mips/kernel/setup.c
> >>>@@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
> >>>  	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
> >>>  			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
> >>>  			 BOOT_MEM_INIT_RAM);
> >>>+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
> >>>+			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
> >>>+			 BOOT_MEM_RAM);
> >>>  	pr_info("Determined physical RAM map:\n");
> >>>  	print_memory_map();
> >>>
