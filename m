Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 22:17:19 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:55743 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23822400AbYKUWRN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 22:17:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mALMGN23031611;
	Fri, 21 Nov 2008 22:16:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mALMGJ9F031609;
	Fri, 21 Nov 2008 22:16:19 GMT
Date:	Fri, 21 Nov 2008 22:16:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, gcc@gcc.gnu.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org,
	Adam Nemet <anemet@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Make BUG() __noreturn.
Message-ID: <20081121221619.GB28154@linux-mips.org>
References: <49260E4C.8080500@caviumnetworks.com> <20081121100035.3f5a640b@lxorguk.ukuu.org.uk> <Pine.LNX.4.64.0811211126420.26004@anakin> <4926E499.4070706@caviumnetworks.com> <Pine.LNX.4.64.0811211940450.29539@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0811211940450.29539@anakin>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 21, 2008 at 07:46:43PM +0100, Geert Uytterhoeven wrote:

> > up with a couple of options:
> > 
> > 1) Enhance the _builtin_trap() function so that we can specify the
> >   break code that is emitted.  This would allow us to do something
> >   like:
> > 
> > static inline void __attribute__((noreturn)) BUG()
> > {
> > 	__builtin_trap(0x200);
> > }

I had suggested this one before ...

> > 2) Create a new builtin '__builtin_noreturn()' that expands to nothing
> >   but has no CFG edges leaving it, which would allow:
> > 
> > static inline void __attribute__((noreturn)) BUG()
> > {
> > 	__asm__ __volatile__("break %0" : : "i" (0x200));
> > 	__builtin_noreturn();
> > }
> 
> Now I remember, yes, __builtin_trap() is how we fixed it on m68k:

I like this interface.

> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e8006b060f3982a969c5170aa869628d54dd30d8
> 
> Of course, if you need a different trap code than the default, you're in
> trouble.

MIPS ISA newer than MIPS I also have conditional break codes allowing
something like this:

#define BUG_ON(condition)                                               \
do {                                                                    \
        __asm__ __volatile__("tne $0, %0, %1"                           \
                             : : "r" (condition), "i" (BRK_BUG));       \
} while (0)

that is test of condition and the trap as a single instruction.  Note there
are break and trap instructions on MIPS and they are basically doing the
same job ...

  Ralf
