Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 19:44:23 +0000 (GMT)
Received: from p508B6BF1.dip.t-dialin.net ([IPv6:::ffff:80.139.107.241]:11996
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226065AbTAHToW>; Wed, 8 Jan 2003 19:44:22 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h08Ji8M28110;
	Wed, 8 Jan 2003 20:44:08 +0100
Date: Wed, 8 Jan 2003 20:44:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Mike Uhler <uhler@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
Message-ID: <20030108204408.A27888@linux-mips.org>
References: <Pine.GSO.3.96.1030108200826.7872A-100000@delta.ds2.pg.gda.pl> <200301081933.h08JX1F09754@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301081933.h08JX1F09754@uhler-linux.mips.com>; from uhler@mips.com on Wed, Jan 08, 2003 at 11:33:01AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 08, 2003 at 11:33:01AM -0800, Mike Uhler wrote:

> >  They do are different: KSEG0+entry*0x2000, likewise for XKPHYS -- see the
> > patch. 
> 
> This is precisely what we use for our internal testing (which is also
> exported to MIPS32 and MIPS64 architecture licensees) to initialize the
> TLB.  I have not yet seen a case where this fails, and would be interested
> in hearing about any case where it does fail.

We used to use just KSEG0 instead of KSEG0+entry*0x2000.  That was running
fine over years but had to be changed for the sake of two CPUs afair.  There
was some discussion on this list about this and I accepted the change by that
time because Kevin imho correctly argued that the spec left it unspecified
if an implementation is feeding addresses in an unmapped address space
though the TLB.

  Ralf
