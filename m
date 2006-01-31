Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 18:09:42 +0000 (GMT)
Received: from allen.werkleitz.de ([80.190.251.108]:4535 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S8133544AbWAaSJY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 18:09:24 +0000
Received: from p54be8dcc.dip0.t-ipconnect.de ([84.190.141.204] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.60)
	(envelope-from <js@linuxtv.org>)
	id 1F4018-0007b8-U5; Tue, 31 Jan 2006 19:14:20 +0100
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1F4018-0002An-00; Tue, 31 Jan 2006 19:14:14 +0100
Date:	Tue, 31 Jan 2006 19:14:14 +0100
From:	Johannes Stezenbach <js@linuxtv.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Message-ID: <20060131181414.GA8288@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.141.204
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 31, 2006, Maciej W. Rozycki wrote:
> On Tue, 31 Jan 2006, Johannes Stezenbach wrote:
> 
> > I think (maybe in error ;-), that all binaries compiled for
> > a 32bit ABI, but a 64bit ISA, have this flag set, as the kernel
> > will refuse to execute 64bt code (i.e. not o32 or n32 ABI). Therefore,
> > shouldn't gdb also evaluate this flag when deciding about the ISA
> > register size?
> 
>  O32 implies 32-bit registers no matter what ISA is specified (while 
> o32/MIPS-III is effectively o32/MIPS-II, o32/MIPS-IV makes a difference), 
> therefore it's a bug.  You should try sending your proposal to 
> <gdb-patches@sources.redhat.com> instead.  But I smell the problem is 
> elsewhere -- mips_isa_regsize() shouldn't be called for the "cooked" 
> registers and these are ones you should only see under Linux or, as a 
> matter of fact, any hosted environment.  See mips_register_type() for a 
> start.

Yes, that's why I said I'm confused about mips_isa_regsize() vs.
mips_abi_regsize().

mips_abi_regsize() correctly says the register size is 32bit for o32,
but mips_register_type() calls mips_isa_regsize(), not
mips_abi_regsize(). That's why I chose to "fix" mips_isa_regsize().

Or should mips_register_type() simply call mips_abi_regsize()?

Or is the correct fix to change gdbserver to transfer registers
in mips_isa_regsize() size, i.e. 64bit for 64bit ISA?
(But gdb would't use the upper 32bits of the registers anyway
with o32 ABI, and this would be more complicated to fix.)

I can't decide :-(


Johannes
