Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 20:09:13 +0000 (GMT)
Received: from cpe.atm2-0-1031142.0x50c4469e.albnxx9.customer.tele.dk ([IPv6:::ffff:80.196.70.158]:33285
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8226107AbTAIUJM>; Thu, 9 Jan 2003 20:09:12 +0000
Received: from linux-mips.org (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.11.2/8.11.2) with ESMTP id h09KA2L01409;
	Thu, 9 Jan 2003 21:10:02 +0100
Message-ID: <3E1DD719.2464A916@linux-mips.org>
Date: Thu, 09 Jan 2003 21:10:01 +0100
From: Carsten Langgaard <carstenl@linux-mips.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Mike Uhler <uhler@mips.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
References: <Pine.GSO.3.96.1030108200826.7872A-100000@delta.ds2.pg.gda.pl> <200301081933.h08JX1F09754@uhler-linux.mips.com> <20030108204408.A27888@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@linux-mips.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Wed, Jan 08, 2003 at 11:33:01AM -0800, Mike Uhler wrote:
>
> > >  They do are different: KSEG0+entry*0x2000, likewise for XKPHYS -- see the
> > > patch.
> >
> > This is precisely what we use for our internal testing (which is also
> > exported to MIPS32 and MIPS64 architecture licensees) to initialize the
> > TLB.  I have not yet seen a case where this fails, and would be interested
> > in hearing about any case where it does fail.
>
> We used to use just KSEG0 instead of KSEG0+entry*0x2000.  That was running
> fine over years but had to be changed for the sake of two CPUs afair.  There
> was some discussion on this list about this and I accepted the change by that
> time because Kevin imho correctly argued that the spec left it unspecified
> if an implementation is feeding addresses in an unmapped address space
> though the TLB.
>

All MIPS's CPUs need these unique TLB entries otherwise you get a machine check
error.
Inspired by Kevin Kissell's changes to openBSD, I made the above change
(KSEG0+entry*0x2000) to the TLB routine in linux. It was done when we first tried
to boot linux on the MIPS 4Kc CPU, a couple of years ago.


>
>   Ralf
