Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 22:47:48 +0100 (CET)
Received: from mail-lf0-x241.google.com ([IPv6:2a00:1450:4010:c07::241]:46288
        "EHLO mail-lf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeAVVrkq1bMV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2018 22:47:40 +0100
Received: by mail-lf0-x241.google.com with SMTP id q194so12461113lfe.13;
        Mon, 22 Jan 2018 13:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M8dgX5evKOzhsRquGpZtLIHtN8syS8yLxYk1MVVXP/I=;
        b=B5u6pFi7OcqzAQ+7C4yqz3/RZJUl2IEGefH9/S5ksF0wTj3dEOFYKrKtXUpC4FVxqc
         f4Hn4OftL+Yr1pf+aWHThLhM9OMB/ySUdVCrWWrYvei84rp7Xbbmu7vKRoOdn6vltbYw
         Q5Gc+1kWgJ5FnzvBHy/BKEaIefcG8Yv/U7p+2Q4msOQ4KralOktUV41iAmautcKN4nY3
         X9DZmp8IE9YKICkodhO532t529EfH0x+CYUXq7B8eLu+c8U6TgOQ+8+l5ut+3xa67NEw
         sAR1W2D8GsSUMbnq5WY2FJGXiFgnvv9F01xoKRzv59orWx0gk1kNN7+6HmlwTYWY67Am
         5RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8dgX5evKOzhsRquGpZtLIHtN8syS8yLxYk1MVVXP/I=;
        b=e2754ohgAp0HrmA0mo3oYpGp9cdg1rb7oCuuWXgjb/P9SSe3CqKQgjyCFiniY+delD
         QSNnucCPHFsxwap1GySs1RBbUKzdMk1VVpLyMwzWDhs2h4UW78yj6W0ghXWdh4amJLix
         RwZJ8uFzt98XQMp9wLdyYpQM0b7NsDmAI9RrnAhnSfTunU9qWOGNvb78IDq2pJidqIt9
         cto+VTgWS2iseuDYT4qVFexy90fACtbPPM2G1BjMmiuuZvKxRxbgRLeOGhMKnHmHFNWe
         4S8CGDS0VtIjapUdACPFn8uOcbNhSkFQl0TOhEzNludFiVcbqGb4zsIvXH3vLUupeKk8
         zsnA==
X-Gm-Message-State: AKwxytcRlg9LIy/TAjYUoDEWxgXY0u/qmtIU5/pGx2pDraDEOk4+QkyR
        8skJuGTmeg3SNYuj2RrsXLXzkLYc
X-Google-Smtp-Source: AH8x2248mOc7Lbv2JAvk1dLLiFtjira9DET1L6lLqOEo3ArRQGpE2GCKbRLKXGvU+DmGNHgqoyA/eQ==
X-Received: by 10.46.87.86 with SMTP id r22mr163444ljd.106.1516657655191;
        Mon, 22 Jan 2018 13:47:35 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id m187sm608935lfe.39.2018.01.22.13.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 13:47:34 -0800 (PST)
Date:   Tue, 23 Jan 2018 00:47:46 +0300
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
Message-ID: <20180122214746.GC32024@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-3-fancer.lancer@gmail.com>
 <3fbb8850-bf34-d698-299a-f1cd62d063ae@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbb8850-bf34-d698-299a-f1cd62d063ae@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62274
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

On Mon, Jan 22, 2018 at 04:35:26PM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> Hi Serge,
> 
> On 17/01/18 22:23, Serge Semin wrote:
> >The current MIPS code makes sure the kernel code/data/init
> >sections are in the maps, but BSS should also be there.
> 
> Quite right - it should. But this was protected against by reserving all
> bootmem up to the _end symbol here:
> http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L388
> Which you remove in the next patch in this series. I'm not sure it is worth

Right. Missed that part. The old code just doesn't set the kernel memory free
calling the free_bootmem() method for non-reserved parts below reserved_end.

> disentangling the reserved_end stuff from the next patch to make this into a
> single logical change of reserving just .bss rather than everything below
> _end.

Good point. I'll move this change into the "[PATCH 05/14] MIPS: memblock:
Add reserved memory regions to memblock". It logically belongs to that place.
Since basically by the arch_mem_addpart() calls we reserve all the kernel
memory now I'd also merged them into a single call for the range [_text, _end].
What do you think?

Regards,
-Sergey

> 
> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
> 
> Thanks,
> Matt
> 
> >
> >Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >---
> >  arch/mips/kernel/setup.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> >diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >index 76e9e2075..0d21c9e04 100644
> >--- a/arch/mips/kernel/setup.c
> >+++ b/arch/mips/kernel/setup.c
> >@@ -845,6 +845,9 @@ static void __init arch_mem_init(char **cmdline_p)
> >  	arch_mem_addpart(PFN_UP(__pa_symbol(&__init_begin)) << PAGE_SHIFT,
> >  			 PFN_DOWN(__pa_symbol(&__init_end)) << PAGE_SHIFT,
> >  			 BOOT_MEM_INIT_RAM);
> >+	arch_mem_addpart(PFN_DOWN(__pa_symbol(&__bss_start)) << PAGE_SHIFT,
> >+			 PFN_UP(__pa_symbol(&__bss_stop)) << PAGE_SHIFT,
> >+			 BOOT_MEM_RAM);
> >  	pr_info("Determined physical RAM map:\n");
> >  	print_memory_map();
> >
