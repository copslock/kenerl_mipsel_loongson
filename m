Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jan 2003 14:00:22 +0000 (GMT)
Received: from p508B79B9.dip.t-dialin.net ([IPv6:::ffff:80.139.121.185]:6614
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226028AbTAHOAW>; Wed, 8 Jan 2003 14:00:22 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h08Dxrv20075;
	Wed, 8 Jan 2003 14:59:53 +0100
Date: Wed, 8 Jan 2003 14:59:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Use XKPHYS for 64-bit TLB flushes
Message-ID: <20030108145953.B8396@linux-mips.org>
References: <Pine.GSO.3.96.1030108141332.1580F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030108141332.1580F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jan 08, 2003 at 02:27:05PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 08, 2003 at 02:27:05PM +0100, Maciej W. Rozycki wrote:

>  32-bit R4k TLB flush functions use KSEG0 as an impossible (unmapped) VPN2
> value for invalidated TLB entries.  64-bit ones use KSEG0 as well, but
> here KSEG0 is a valid XKSEG (mapped) value as it gets interpreted as
> 0xc00000ff80000000 when written into cp0.EntryHi.  The correct impossible
> (unmapped) VPN2 value for the 64-bit mode is XKPHYS. 

That's a funny one.  Historically the idea was to use KSEG0 because the
for KSEG0 the TLB is not used for translation.  That already failed for
the Sibyte SB1 which is why we have to use different KSEG0 addresses for
each entry there.

>  Here is a patch implementing it.  The code runs fine on my R4400SC.  OK
> to apply?

Yes.

>  BTW, show_tlb() (in the same file) is buggy and redundant --
> dump_tlb_all() is a correct equivalent.  I'd like to remove show_tlb() --
> OK?

Yes.  I'd eventually like to move the tlb dump functions away from the
lib directory into the mm directory which seems to be more the right
place for them.

  Ralf
