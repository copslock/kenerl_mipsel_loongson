Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 21:37:19 +0000 (GMT)
Received: from p508B7AB1.dip.t-dialin.net ([IPv6:::ffff:80.139.122.177]:59007
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225377AbUCRVhS>; Thu, 18 Mar 2004 21:37:18 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2ILbEMk030445;
	Thu, 18 Mar 2004 22:37:14 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2ILbDH6030444;
	Thu, 18 Mar 2004 22:37:13 +0100
Date: Thu, 18 Mar 2004 22:37:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
Message-ID: <20040318213713.GC25815@linux-mips.org>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com> <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com> <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 18, 2004 at 02:18:01PM +0100, Maciej W. Rozycki wrote:

>  As a side note, it makes me wonder where the borderline of the RISC
> actually is.  Even Intel abandoned support for bit insert/extract
> instructions after an initial attempt for the i386.  They figured out the
> implementation was too complicated. ;-)

Take a look at the 68020 to see where instruction set madness can lead:

	movel	([42, a0, d0.2*2],123), ([43, a0, d0.2*2], 22)
	bfextu	([42, a0, d0.2*2],123){8:8}, d2

And I haven't even started bitching about CALLM's bloat over jsr on a
system with MMU disabled or the fantastic complexities it offers with
all gadgets enabled.  Probably desigend for MACH but in the end just
useless no known OS used them and Moto removed them again for the 030.

  Ralf
