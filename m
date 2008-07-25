Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 19:05:04 +0100 (BST)
Received: from harold.telenet-ops.be ([195.130.133.65]:52683 "EHLO
	harold.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28580254AbYGYSFC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Jul 2008 19:05:02 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by harold.telenet-ops.be (Postfix) with SMTP id 10BD530021;
	Fri, 25 Jul 2008 20:05:01 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by harold.telenet-ops.be (Postfix) with ESMTP id 03C843000E;
	Fri, 25 Jul 2008 20:05:00 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m6PI50Si011164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Jul 2008 20:05:00 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m6PI4vAX011161;
	Fri, 25 Jul 2008 20:05:00 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 25 Jul 2008 20:04:57 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Mike Crowe <mac@mcrowe.com>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add severity levels to printk statements during
 kernel setup.
In-Reply-To: <20080725134454.GA26225@mcrowe.com>
Message-ID: <Pine.LNX.4.64.0807252002490.11082@anakin>
References: <20080725134454.GA26225@mcrowe.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 25 Jul 2008, Mike Crowe wrote:
> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> ---
>  arch/mips/kernel/setup.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 8af8486..fcb12b9 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -78,7 +78,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
>  
>  	/* Sanity check */
>  	if (start + size < start) {
> -		printk("Trying to add an invalid memory region, skipped\n");
> +		printk(KERN_WARNING "Trying to add an invalid memory region, skipped\n");

Why not convert to pr_warning(), while you're at it?

> @@ -221,7 +221,7 @@ static void __init finalize_initrd(void)
>  		goto disable;
>  	}
>  	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> -		printk("Initrd extends beyond end of memory");
> +		printk(KERN_ERR "Initrd extends beyond end of memory");
                                                                    ^
There's no newline here, so...

>  		goto disable;
>  	}
>  
> @@ -232,7 +232,7 @@ static void __init finalize_initrd(void)
>  	       initrd_start, size);
>  	return;
>  disable:
> -	printk(" - disabling initrd\n");
> +	printk(KERN_ERR " - disabling initrd\n");
               ^^^^^^^^
... probably this should be KERN_CONT.
Note that I didn't check the other paths to get here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
