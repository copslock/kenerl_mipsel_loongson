Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 13:39:16 +0100 (BST)
Received: from grex.cyberspace.org ([IPv6:::ffff:216.93.104.34]:52753 "HELO
	grex.cyberspace.org") by linux-mips.org with SMTP
	id <S8224861AbTGAMjM>; Tue, 1 Jul 2003 13:39:12 +0100
Received: from localhost (ik@localhost) by grex.cyberspace.org (8.6.13/8.6.12) with SMTP id IAA01150; Tue, 1 Jul 2003 08:39:03 -0400
Date: Tue, 1 Jul 2003 08:39:02 -0400 (EDT)
From: <ik@cyberspace.org>
To: <ralf@linux-mips.org>
cc: <linux-mips@linux-mips.org>
Subject: Re: is there any docs/manuals for linker scripts symbols
In-Reply-To: <20030625121801.GA11496@linux-mips.org>
Message-ID: <Pine.SUN.3.96.1030701083213.315A-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ik@grex.cyberspace.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ik@cyberspace.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Wed, 25 Jun 2003 ralf@linux-mips.org wrote:

> On Wed, Jun 25, 2003 at 08:01:24AM -0400, ik@cyberspace.org wrote:
> 
> > My board has a boot loader (rom) that enforce/restricts the sections in
> > the elf header, hence I cannot use the default linker script that comes
> > wit the kernel(arch/mips/). 
> 
> Are you sure the loader actually looks at the sections?  That seems plain
> wrong.  Normally a loader should only look at all the PT_LOAD entries in
> the ELF program header table for loading.

I use the device available in my company (which is proprietary), 
I know my point here would be abstract for u...sorry abt that !

Thanks for the reply !
Indu
> 
> > I think your reply could be put as a howto/faqs in
> > http://www.linux-mips.org (for the global symbols
> > used in linux kernel).
> 
> So many things that deserve some well written documentation - yet so little
> exists ...
> 
>   Ralf
> 
