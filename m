Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 May 2017 14:55:50 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:34257
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbdE2MzmXIVZD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 May 2017 14:55:42 +0200
Received: by mail-pg0-x244.google.com with SMTP id u187so6473144pgb.1;
        Mon, 29 May 2017 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h6IZRZo1LMD1ilMNUq4G+4lg/+tmByxuAy77UoRAhwE=;
        b=IFm4ImD8PNQgfPRKodHaS3j3LJPuxfb2mi4RhatxH7wYnH/2A/aeh7Fkfg/H+/WoPP
         MPZ776cDbzCsjD9bsyypNl6BqAWinl/gVQgi60ikbPAE77//SNK+hWmgq4FOBIGU7ABP
         JI3cxbb84Litc1P18nwWiSLiHMgMV5yZC5e0EnSbHG2YnGhGQ7LsmKXI6lEa+nIRIyKl
         kaC2jfw/xYN+P9DjjMs/noKDFpkoKFzfO4J2undMnU/0pRAOzFPhjec7o9ReeAMvl4Fa
         NY2nqmq9AfqFK4qVX6wTrQzsoiO88Fh0wZ6/GpLF+5e81BrPOCs48plftvUz9XkK44ah
         gsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h6IZRZo1LMD1ilMNUq4G+4lg/+tmByxuAy77UoRAhwE=;
        b=qjei1+J4qRl5e7AtQ5W3bTgPBDjgDQb+h/pqoEskhm6sMmBlZwTmPHBsfKcnsNjxfA
         BUvCdJJ5JQ20ottequmG6heP4K8RmbGF/KhncercVDVP5w0IwjQFRchLMbp+rOrrmCXi
         KeESqw1g6LVKmompUguSa8tPEpg/XSBX+CNyOpHKIZTc0AEUEV/6Sj/7cSD01ebgRlbZ
         Nd6/vs+F29+J3hJUFMYl1Pv4cxA87LxwLCyYpIxQDFXlx+UW8Pt7ey/ml/Up4yLSvcDw
         GrepW3CxODGrrGsPQQ8bPvLQltx3rrG7GM2zItWGJE/xBzUj3vnLk/rrKv5NmXlV6zDk
         y+TA==
X-Gm-Message-State: AODbwcAaWcS+jSI5Jt8Wjl3CFQyy/55UKWPa+8S10bKRrsgSS8TVGU+S
        7hHo/ObX3ydPsA==
X-Received: by 10.99.116.28 with SMTP id p28mr18776696pgc.8.1496062536485;
        Mon, 29 May 2017 05:55:36 -0700 (PDT)
Received: from localhost (g139.211-19-81.ppp.wakwak.ne.jp. [211.19.81.139])
        by smtp.gmail.com with ESMTPSA id x18sm18432312pfe.13.2017.05.29.05.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 May 2017 05:55:35 -0700 (PDT)
Date:   Mon, 29 May 2017 21:55:33 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, Oleg Nesterov <oleg@redhat.com>,
        Jamie Iles <jamie.iles@oracle.com>
Subject: Re: [PATCH] kthread: fix boot hang (regression) on MIPS/OpenRISC
Message-ID: <20170529125533.GB2940@lianli.shorne-pla.net>
References: <20170529072207.16130-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170529072207.16130-1-vegard.nossum@oracle.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <shorne@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shorne@gmail.com
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

On Mon, May 29, 2017 at 09:22:07AM +0200, Vegard Nossum wrote:
> This fixes a regression in commit 4d6501dce079 where I didn't notice
> that MIPS and OpenRISC were reinitialising p->{set,clear}_child_tid to
> NULL after our initialisation in copy_process().
> 
> We can simply get rid of the arch-specific initialisation here since it
> is now always done in copy_process() before hitting copy_thread{,_tls}().
> 
> Review notes:
> 
>  - As far as I can tell, copy_process() is the only user of
>    copy_thread_tls(), which is the only caller of copy_thread() for
>    architectures that don't implement copy_thread_tls().
> 
>  - After this patch, there is no arch-specific code touching
>    p->set_child_tid or p->clear_child_tid whatsoever.
> 
>  - It may look like MIPS/OpenRISC wanted to always have these fields be
>    NULL, but that's not true, as copy_process() would unconditionally
>    set them again _after_ calling copy_thread_tls() before commit
>    4d6501dce079.
> 
> Fixes: 4d6501dce079c1eb6bf0b1d8f528a5e81770109e ("kthread: Fix use-after-free if kthread fork fails")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net> # MIPS only
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Jamie Iles <jamie.iles@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
> Not sure who this should go through, the last patch went through tglx/the
> core-urgent-for-linus tree, but it does touch arch code + fix a mainline
> boot hang regression on at least MIPS (Guenter said OpenRISC didn't seem
> affected in his boot tests, but the code looks wrong in any case). Maybe
> we could get acks/reviews by MIPS and OpenRISC maintainers?

This looks ok with me, I am pretty sure a lot of the OpenRISC initial port
was based on mips so this could have been copied from the beginning.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/mips/kernel/process.c     | 1 -
>  arch/openrisc/kernel/process.c | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 918d4c73e951..5351e1f3950d 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -120,7 +120,6 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>  	struct thread_info *ti = task_thread_info(p);
>  	struct pt_regs *childregs, *regs = current_pt_regs();
>  	unsigned long childksp;
> -	p->set_child_tid = p->clear_child_tid = NULL;
>  
>  	childksp = (unsigned long)task_stack_page(p) + THREAD_SIZE - 32;
>  
> diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> index f8da545854f9..106859ae27ff 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -167,8 +167,6 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
>  
>  	top_of_kernel_stack = sp;
>  
> -	p->set_child_tid = p->clear_child_tid = NULL;
> -
>  	/* Locate userspace context on stack... */
>  	sp -= STACK_FRAME_OVERHEAD;	/* redzone */
>  	sp -= sizeof(struct pt_regs);
> -- 
> 2.12.0.rc0
> 
