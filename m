Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2004 13:52:35 +0000 (GMT)
Received: from p508B7CA6.dip.t-dialin.net ([IPv6:::ffff:80.139.124.166]:31803
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225528AbUCXNwe>; Wed, 24 Mar 2004 13:52:34 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2ODqRoM005102;
	Wed, 24 Mar 2004 14:52:27 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2ODqPlH005101;
	Wed, 24 Mar 2004 14:52:25 +0100
Date: Wed, 24 Mar 2004 14:52:25 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
Message-ID: <20040324135225.GE1983@linux-mips.org>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com> <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com> <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl> <20040318213713.GC25815@linux-mips.org> <Pine.GSO.4.58.0403191141290.2173@waterleaf.sonytel.be> <20040319125502.GA32363@linux-mips.org> <87isguwhbw.fsf@mrvn.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isguwhbw.fsf@mrvn.homelinux.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 24, 2004 at 01:38:27PM +0100, Goswin von Brederlow wrote:

>  move.l 31530(A0, D0*2), 5675(A0, D0*2)  (that would give a bus error)
> 
> before assembly right?
> 
> That instruction is great to access array or aligned structure members
> with an offset and compilers should be able to generate it for it. But
> its only realy usefull if your short on registers, which gcc does not
> optimize for.
> 
> Don't think they got removed. Could it be you are thinking about
> mulu.l d0,d0:d1   (32*32=64 bit mul) and the like?

Maybe - my memories of 68k are getting dusty.  In '92 or '93 I had started
my own Linux/68k port but disgusted by the complexity of some parts of the
68k architecture - such as execution timing tables of several pages just
for the move instruction or even shell scripts in case of the 68851 MMU.
Eventually I got my hands on a MIPS box in '94, again for porting Linux
to MIPS as the very first MIPS project I ever did.  Architectures tend to
get ugly when they age, when new features are added and compatibility
issues arrise but for most part I think MIPS has managed to age very
gracefully which I believe in part is one of the benefits of RISC design
principles, so I'm still happy after 10 years of MIPS stuff and feel
little desire to open those Motorola manuals on my shelf :-)

  Ralf
