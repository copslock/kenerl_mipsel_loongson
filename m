Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 01:36:11 +0000 (GMT)
Received: from p508B6BF1.dip.t-dialin.net ([IPv6:::ffff:80.139.107.241]:15840
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226079AbTAIBgK>; Thu, 9 Jan 2003 01:36:10 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h091a1a03540;
	Thu, 9 Jan 2003 02:36:01 +0100
Date: Thu, 9 Jan 2003 02:36:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Mike Uhler <uhler@mips.com>, Dominic Sweetman <dom@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
Message-ID: <20030109023601.A1213@linux-mips.org>
References: <20030108204408.A27888@linux-mips.org> <Pine.GSO.3.96.1030108210002.11293A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030108210002.11293A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jan 08, 2003 at 09:12:03PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 08, 2003 at 09:12:03PM +0100, Maciej W. Rozycki wrote:

>  Well, like it or not, CAMs do not like multiple matches -- up to a
> physical damage even.  So they should be avoided if possible.  While KSEG0
> won't match for any real address translation, there is a non-zero
> probability of executing a tlbp for it as a result of buggy code or
> execution gone wild (root running crashme?). 

I'm told the TLB Shutdown bit in the R4000 is basically implemented as an
overcurrent protection.  That is on many chips even a hit on several
entries won't cause a tlb shutdown until the matches do result in the
TLB drawing more than a certain current.

A tlbp on a KSEG0 address shouldn't happen.  If it's attempted we already
have worse problems.

  Ralf
