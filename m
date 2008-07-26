Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 14:19:15 +0100 (BST)
Received: from edna.telenet-ops.be ([195.130.132.58]:45457 "EHLO
	edna.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28582873AbYGZNTJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Jul 2008 14:19:09 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edna.telenet-ops.be (Postfix) with SMTP id 11A8DE4032;
	Sat, 26 Jul 2008 15:19:08 +0200 (CEST)
Received: from anakin.of.borg (78-21-204-88.access.telenet.be [78.21.204.88])
	by edna.telenet-ops.be (Postfix) with ESMTP id EB691E401A;
	Sat, 26 Jul 2008 15:19:07 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-4) with ESMTP id m6QDJ7eu015757
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 26 Jul 2008 15:19:07 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m6QDJ7xs015754;
	Sat, 26 Jul 2008 15:19:07 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sat, 26 Jul 2008 15:19:07 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Mike Crowe <mac@mcrowe.com>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add severity levels to printk statements during
 kernel setup.
In-Reply-To: <20080726125925.GB32426@mcrowe.com>
Message-ID: <Pine.LNX.4.64.0807261517160.14397@anakin>
References: <20080725134454.GA26225@mcrowe.com> <Pine.LNX.4.64.0807252002490.11082@anakin>
 <20080726125925.GB32426@mcrowe.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sat, 26 Jul 2008, Mike Crowe wrote:
> On Fri, 25 Jul 2008, I wrote:
> >> --- a/arch/mips/kernel/setup.c
> >> +++ b/arch/mips/kernel/setup.c
> >> @@ -78,7 +78,7 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
> >>  
> >>  	/* Sanity check */
> >>  	if (start + size < start) {
> >> -		printk("Trying to add an invalid memory region, skipped\n");
> >> +		printk(KERN_WARNING "Trying to add an invalid memory region, skipped\n");
>  
> On Fri, Jul 25, 2008 at 08:04:57PM +0200, Geert Uytterhoeven wrote:
> > Why not convert to pr_warning(), while you're at it?
> 
> I can do. I'm just a bit behind the times. :-)
> 
> Should I use pr_{warning,err,info} everywhere rather than printk? Is

Yes, please.

> it worth fixing up the other calls to printk that I didn't need to
> "fix"?

If you have the time, you can do that. It also makes those (typically
too long) lines a bit shorter.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
