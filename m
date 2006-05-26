Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 13:39:53 +0200 (CEST)
Received: from allen.werkleitz.de ([80.190.251.108]:60344 "EHLO
	allen.werkleitz.de") by ftp.linux-mips.org with ESMTP
	id S8133356AbWEZLjm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 13:39:42 +0200
Received: from p54bdeff4.dip.t-dialin.net ([84.189.239.244] helo=void.local)
	by allen.werkleitz.de with esmtpsa (TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA1:24)
	(Exim 4.62)
	(envelope-from <js@linuxtv.org>)
	id 1Fjaf5-0004sx-5c; Fri, 26 May 2006 13:39:29 +0200
Received: from js by void.local with local (Exim 3.35 #1 (Debian))
	id 1FjafP-0003hO-00; Fri, 26 May 2006 13:39:43 +0200
Date:	Fri, 26 May 2006 13:39:43 +0200
From:	Johannes Stezenbach <js@linuxtv.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Tony Lin <lin.tony@gmail.com>,
	ashley jones <ashley_jones_2000@yahoo.com>,
	linux-mips@linux-mips.org
Message-ID: <20060526113943.GB14036@linuxtv.org>
References: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com> <20060524081406.90333.qmail@web38407.mail.mud.yahoo.com> <404548f40605241844y41b897b6sb8a7512feb8655f6@mail.gmail.com> <20060525133529.GA31379@nevyn.them.org> <404548f40605251750s2708df73td50a4e9db755408f@mail.gmail.com> <20060526024540.GA16815@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526024540.GA16815@nevyn.them.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.189.239.244
Subject: Re: Can't debug core files with GDB
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Return-Path: <js@linuxtv.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Thu, May 25, 2006, Daniel Jacobowitz wrote:
> On Thu, May 25, 2006 at 05:50:56PM -0700, Tony Lin wrote:
> 
> [2.4]
> 
> >       /*
> >        * saved cp0 registers
> >        */
> >       unsigned long cp0_epc;
> >       unsigned long cp0_badvaddr;
> >       unsigned long cp0_status;
> >       unsigned long cp0_cause;
> 
> [2.6]
> 
> >       /* Saved special registers. */
> >       unsigned long cp0_status;
> >       unsigned long lo;
> >       unsigned long hi;
> >       unsigned long cp0_badvaddr;
> >       unsigned long cp0_cause;
> >       unsigned long cp0_epc;
> 
> > Notice how the offsets has changed, no idea why this was done. I
> > loaded the core file in the hex dump, and sure enough it is dumped
> > with this new ordering.
> > 
> > I guess gdb is still trying to decode using the old pt_regs format. Is
> > it correct to modify gdb to use this new format? Or modify linux to
> > output using the old format?

BTW, buildroot has a 400-mips-coredump.patch-2.4.23-29 patch.
http://buildroot.uclibc.org/cgi-bin/viewcvs.cgi/trunk/buildroot/toolchain/gdb/

However, I've built a toolchain using gcc-3.4.4, uClibc 0.9.27-cvs,
gdb 6.3, kernel 2.6.13, and I had to build without the
buildroot 400-mips-coredump.patch-2.4.23-29 patch. Without
it my gdb can read coredumps without problems.


Johannes
