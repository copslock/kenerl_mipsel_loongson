Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 06:40:25 +0000 (GMT)
Received: from p508B69C2.dip.t-dialin.net ([IPv6:::ffff:80.139.105.194]:20141
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTA2GkY>; Wed, 29 Jan 2003 06:40:24 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0T6eAN14945;
	Wed, 29 Jan 2003 07:40:10 +0100
Date: Wed, 29 Jan 2003 07:40:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
Message-ID: <20030129074010.A7741@linux-mips.org>
References: <geert@linux-m68k.org> <200301290139.h0T1d3R01891@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301290139.h0T1d3R01891@p2.parker.boston.ma.us>; from brad@parker.boston.ma.us on Tue, Jan 28, 2003 at 08:39:03PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 28, 2003 at 08:39:03PM -0500, Brad Parker wrote:

> I had a problem in tcp_rcv_established() where this "if" would trigger
> even though "th->syn" was zero:
> 
> ...
> 	if (th->syn && !before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
> ...
> 
> It turned out the tcp header was 'misaligned' after coming across a
> usb link.  I never figured out why it was failing, but it was clearly
> the emulation code which was doing the wrong thing.  This was on an
> alchemy au1000 (MIPS32).

A few days ago I fixed a special case in cvs where the unaligned handler
was misshandling the special case where

	bxx	$r1, dest
	load	$r1, offset($r2)

both instruction are using the same register $r1 and the effective address
offset + $r2 was missaligned.  In that case the emulation code was
executing the load instruction first then using the loaded value to deciede
if the branch was taken.

I know the bug was hitting in the netfilter code but chances are there are
other places in the network code affected as well.

  Ralf
