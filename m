Received:  by oss.sgi.com id <S42420AbQI3XPn>;
	Sat, 30 Sep 2000 16:15:43 -0700
Received: from u-142.karlsruhe.ipdial.viaginterkom.de ([62.180.19.142]:54538
        "EHLO u-142.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42232AbQI3XPa>; Sat, 30 Sep 2000 16:15:30 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868874AbQI3KSX>;
        Sat, 30 Sep 2000 12:18:23 +0200
Date:   Sat, 30 Sep 2000 12:18:23 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Decstation broken Was: CVS Update@oss.sgi.com: linux
Message-ID: <20000930121823.A32244@bacchus.dhis.org>
References: <20000928214002.B767@paradigm.rfc822.org> <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000929112103.16748A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Sep 29, 2000 at 11:36:07AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Sep 29, 2000 at 11:36:07AM +0200, Maciej W. Rozycki wrote:

>  Well, I asked for testing before the commit, but nobody bothered to write
> anything, so I assumed everything is correct, sigh...

Not sigh ...  The lesson that not speaking up is a also wrong!

>  OK, the /240 is definitely tested (the uptime of my -test7 was three
> weeks before I rebooted to test NFS problems) so /260 should work for you. 
> But the latter is R4K.  As Ralf already remarked me in a separate mail,
> 64-bit registers can get corrupted for the 32-bit kernel (but 64-bit code
> is used throughout the kernel, strange), so please change the "#if
> _MIPS_ISA" at the beginning of include/asm-mips/div64.h into "#if 1" and
> tell me if it works for the /260. 

The ddiv usage outside of do_div / do_div64_32 is actually ok because
interrupts are always disabled.  We don't have the same guarantee for
do_div / do_div64_32 calls.

Hmm...  We got two error scenarios left - bus errors and cache errors.  If
we get one of those doomsday is near anyway ...  Anyway, these are rare,
so we rather make these exception handlers pay the price.

  Ralf
