Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g110XZl16346
	for linux-mips-outgoing; Thu, 31 Jan 2002 16:33:35 -0800
Received: from ashi.FootPrints.net (mail@ashi.FootPrints.net [204.239.179.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g110XTd16342
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 16:33:31 -0800
Received: from kaz (helo=localhost)
	by ashi.FootPrints.net with local-esmtp (Exim 3.16 #1)
	id 16WQhn-0006sd-00; Thu, 31 Jan 2002 15:33:23 -0800
Date: Thu, 31 Jan 2002 15:33:23 -0800 (PST)
From: Kaz Kylheku <kaz@ashi.footprints.net>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "H . J . Lu" <hjl@lucon.org>,
   GNU C Library <libc-alpha@sources.redhat.com>, <linux-mips@oss.sgi.com>
Subject: Re: [libc-alpha] Re: PATCH: Fix ll/sc for mips
In-Reply-To: <Pine.GSO.3.96.1020131230104.9069A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0201311526010.21705-100000@ashi.FootPrints.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 Jan 2002, Maciej W. Rozycki wrote:

> Date: Thu, 31 Jan 2002 23:17:21 +0100 (MET)
> From: Maciej W. Rozycki <macro@ds2.pg.gda.pl>
> To: H . J . Lu <hjl@lucon.org>
> Cc: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
> Subject: [libc-alpha] Re: PATCH: Fix ll/sc for mips
> 
> On Thu, 31 Jan 2002, H . J . Lu wrote:
> 
> > 	(__compare_and_swap): Return 0 when failed to compare or swap.
> [...]
> > 	* sysdeps/mips/atomicity.h (compare_and_swap): Return 0 when
> > 	failed to compare or swap.
> 
>  Looking at the i486 implementation these are not expected to fail. 
> Unless I am missing something... 

That's what ``compare'' means in ``compare and swap''. You lock the
memory location at some hardware level and then compare the location
to the specified value. If there is a match, you change the memory
location to the new value. Otherwise you don't, and indicate that 
you didn't. That's what ``fail'' means. The comparison failed,
and the operation failed to install the new value. The caller must
detect this and handle that. Algorithms based on atomic
compare-and-swap take failure into account.
