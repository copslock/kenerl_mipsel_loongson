Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OIJ8Rw004078
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 11:19:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OIJ8wh004077
	for linux-mips-outgoing; Wed, 24 Jul 2002 11:19:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OIIxRw004068
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 11:18:59 -0700
Received: from dsl254-114-118.nyc1.dsl.speakeasy.net
	([216.254.114.118] helo=nevyn.them.org ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17XQZ2-0004AG-00; Wed, 24 Jul 2002 13:08:44 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17XQZ8-0008C6-00; Wed, 24 Jul 2002 14:08:50 -0400
Date: Wed, 24 Jul 2002 14:08:50 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux: RFC: elf_check_arch() rework
Message-ID: <20020724180850.GA31437@nevyn.them.org>
Mail-Followup-To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
References: <Pine.GSO.3.96.1020724182704.27732L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020724182704.27732L-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 24, 2002 at 07:05:36PM +0200, Maciej W. Rozycki wrote:
> Hello,
> 
>  After noticing I cannot run a trivial ELF64 program because of the
> EF_MIPS_ARCH_3 flag (quite a reasonable setting for a 64-bit executable,
> isn't it?), I concluded a considerable rework of elf_check_arch() is
> needed as what we currently have is inadequate. 
> 
>  Here is my proposal.  I think binfmt_elf.c for mips and binfmt_elf32.c
> for mips64 should accept all ELF32 binaries either with no ABI mark (as
> produced by most versions of binutils) or with a 32 (aka o32) ABI one and
> binfmt_elf.c for mips64 should accept all ELF32 binaries with an n32 ABI
> mark and all ELF64 ones (which essentially means the 64 aka n64 ABI). 
> Everything else (i.e. o64 and EABIs) is rejected.  The patch adds
> necessary ELF file header flag definitions and synchronizes a few wrong
> ones to the binutils' definitions as well. 
> 
>  It removes the bogus check of architecture flags as they are really
> irrelevant -- the code is intended to handle executable formats and not
> execution of code.  If a user incorporates unsupported opcodes, he'll just
> get SIGILL at one moment.  We may actually check if an architecture is
> supported even no other Linux port seems to care, but then the comparison
> should be against mips_cpu.isa_level and not against hardcoded constants. 
> 
>  Note, this is an RFC at this stage -- I haven't tested the code
> adequately for an immediate inclusion, even if it looks obvious.  There
> should be no problems with code made with old binutils as unset flags are
> treated as (o)32. 

Well, that sounds like the right approach to me.  It sounds like
there's some real progress on the 64-bit tools now...

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
