Received:  by oss.sgi.com id <S553663AbQJSCY6>;
	Wed, 18 Oct 2000 19:24:58 -0700
Received: from wopr.scooter.cx ([216.254.73.145]:2825 "EHLO wopr.scooter.cx")
	by oss.sgi.com with ESMTP id <S553656AbQJSCYp>;
	Wed, 18 Oct 2000 19:24:45 -0700
Received: from localhost (scott@localhost)
	by wopr.scooter.cx (8.9.3/8.9.3) with ESMTP id WAA09326
	for <linux-mips@oss.sgi.com>; Wed, 18 Oct 2000 22:24:43 -0400
Date:   Wed, 18 Oct 2000 22:24:43 -0400 (EDT)
From:   Scott Venier <scott@scooter.cx>
To:     linux-mips@oss.sgi.com
Subject: Re: 16K page size?
In-Reply-To: <20001018033804.E7865@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.21.0010182223050.9148-100000@wopr.scooter.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

shouldn't most things be safe since alpha uses 8k pages?

Scott

On Wed, 18 Oct 2000, Ralf Baechle wrote:

> On Wed, Oct 18, 2000 at 03:30:02AM +0200, Ralf Baechle wrote:
> 
> > Most applications probably use the getpagesize() function, so they should
> > be fine.  libc itself should also be clean.
> > 
> > In the kernel we don't handle this properly yet.  There are also some
> > optimizations which are possible for larger page sizes.  IA64 already
> > has a larger pagesize than Intel, so I hope they have already solve
>                              ^^^^^
>                              i386
> > most of the problems for us.
> 
>   Ralf
> 
