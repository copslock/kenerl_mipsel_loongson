Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 18:53:24 +0000 (GMT)
Received: from p508B796B.dip.t-dialin.net ([IPv6:::ffff:80.139.121.107]:28343
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225257AbTBTSxY>; Thu, 20 Feb 2003 18:53:24 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1KIrE602557;
	Thu, 20 Feb 2003 19:53:14 +0100
Date: Thu, 20 Feb 2003 19:53:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Cobalt IRQ handler CP0 interlock?
Message-ID: <20030220195314.C30853@linux-mips.org>
References: <Pine.GSO.3.96.1030220182355.25777G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030220182355.25777G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Feb 20, 2003 at 06:31:02PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 06:31:02PM +0100, Maciej W. Rozycki wrote:

>  Does Cobalt have a processor that implements its pipeline differently or
> interlocks on CP0 loads?  If not, I'll apply the following fix. 

Mfc0 doesn't need a nops on any R4000 class CPU I know of.

  Ralf
