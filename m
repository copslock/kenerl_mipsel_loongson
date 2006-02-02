Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 13:39:06 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:35846 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465626AbWBBNis (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Feb 2006 13:38:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k12DhT4r014629;
	Thu, 2 Feb 2006 13:43:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k12DhTdL014628;
	Thu, 2 Feb 2006 13:43:29 GMT
Date:	Thu, 2 Feb 2006 13:43:29 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Johannes Stezenbach <js@linuxtv.org>,
	Daniel Jacobowitz <dan@debian.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
Message-ID: <20060202134329.GD4986@linux-mips.org>
References: <20060131171508.GB6341@linuxtv.org> <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl> <20060201164423.GA4891@nevyn.them.org> <20060201194443.GB21871@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201194443.GB21871@linuxtv.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006 at 08:44:43PM +0100, Johannes Stezenbach wrote:

> If I understand this correctly, gdbserver should check the
> register size supported by the OS, and communicate this to gdb?
> 
> I'm using a Linux kernel with CONFIG_32BIT, and if I understand
> the ptrace interface correctly, the registers as seen through
> ptrace are 32bit then, even though the CPU has 64bit registers.

Correct.  On 32-bit kernels Linux will largely forget about the 64-bitness
of the processor.  User processes will run with 64-bit (UX bit) disabled,
so they're never able to anything 64-bitish.  The kernel will only save
and restore the lower 32-bit of registers, so the upper 32-bit will be
lost.  That means only using the $zero register as 64-bit register is safe
and that's exploited by clear_page().  There are a few place where 64-bit
loads and stores are needed because particular hardware doesn't like being
talked to with 32-bit accesses; those accesses need make sure they're not
interrupted or bad things happen.  See the code for *readq() and write()
in <asm/io.h>.

Ages ago I tried leaving all the 64-bit functionality available as far as
possible even in 32-bit kernels.  It turned out to be example messy and I
was happy to have gotten rid of it, I think in 2.1.14.

> (I have no idea if the cp0 status suggested by others in this
> thread reflect CONFIG_32BIT vs. CONFIG_64BIT on Linux.)

On 32-bit kernels Linux will clear c0_status.kx, c0_status.ux and
c0_status.fr - on hardware were those bits exist at all, that is.

On 64-bit kernels Linux will set c0_status.kx.  It will also always set
c0_status.ux which means 64-bit operations are legal even for 32-bit
processes.  To my knowledge nobody is exploiting that; I guess it could
be exploited for a faster memcpy and similar.  Finally c0_status.fr which
will be set according to the ABI of the process, that is it'll be cleared
for o32 and set for N32 and N64 processes.

  Ralf
