Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2004 01:33:00 +0100 (BST)
Received: from p508B7E12.dip.t-dialin.net ([IPv6:::ffff:80.139.126.18]:48511
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225220AbUGXAcz>; Sat, 24 Jul 2004 01:32:55 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6O0WmL0009166;
	Sat, 24 Jul 2004 02:32:48 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6O0WiHF009159;
	Sat, 24 Jul 2004 02:32:44 +0200
Date: Sat, 24 Jul 2004 02:32:44 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Srinivas Kommu <kommu@hotmail.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: mips32 kernel memory mapping
Message-ID: <20040724003244.GA8802@linux-mips.org>
References: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com> <Pine.LNX.4.58L.0407231348580.5644@blysk.ds.pg.gda.pl> <20040723202439.GA3711@linux-mips.org> <Pine.GSO.4.58.0407232233430.13094@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407232233430.13094@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 23, 2004 at 10:34:35PM +0200, Geert Uytterhoeven wrote:

> On Fri, 23 Jul 2004, Ralf Baechle wrote:
> > There are still improvments to be made for BCM1250 support.  Somebody
> > thought scattering the first 1GB of memory through the lowest 4GB of
> > physical address space like a three year old his toys over the floor
> > was a good thing ...  The resulting holes in the memory map are wasting
> > significant amounts of memory for unused memory; the worst case number
> > that is reached for 64-bit kernel on a system with > 1GB of RAM is 96MB!
> 
> Perhaps you want to start using virtually mapped zones, like m68k?

We could do that, yes.  In the cases that would gain most such as the
BCM1250 it'd not be possible though - there simply is not enough virtual
address space left in KSEG2/3.

  Ralf
