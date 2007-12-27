Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 15:10:56 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:49611 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20035529AbXL0PKs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2007 15:10:48 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1J7uNe-0008Oj-00; Thu, 27 Dec 2007 16:10:42 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 02A25C2EE8; Thu, 27 Dec 2007 16:10:31 +0100 (CET)
Date:	Thu, 27 Dec 2007 16:10:31 +0100
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: MC Bus Error / tcp_ack_saw_tstamp Was: IP28 Installation Success report
Message-ID: <20071227151031.GA7516@alpha.franken.de>
References: <20071227090401.GA3393@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071227090401.GA3393@paradigm.rfc822.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Dec 27, 2007 at 10:04:01AM +0100, Florian Lohoff wrote:
> On Sun, Dec 23, 2007 at 08:54:42PM +0100, Florian Lohoff wrote:
> > I thought an installation success report is sometimes nice to have:
> 
> Linux ip28 2.6.24-rc5-g8b3ba06b-dirty #21 Tue Dec 18 12:48:29 CET 2007 mips64 GNU/Linux
> 
> After ~10 days uptime and multiple gcc builds. Logging in via ssh 
> and issueing an "ls" in the build directory:
> 
> MC Bus Error

looks like

        /* GIO errors are fatal */
        if (gio_err_stat & GIO_ERRMASK)
                goto mips_be_fatal;

in ip28_be_interrupt is too strict. Load speculations to addresses
in the GIO address range where no device responds, will probably always
produce bus timeout. It might be worth to use 
check_addr_in_insn(cpu_err_addr, regs)) before killing the machine.

So

        if ((gio_err_stat & GIO_ERRMASK) &&
             check_addr_in_insn(gio_err_addr, regs))
                        goto mips_be_fatal;

might be better.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
