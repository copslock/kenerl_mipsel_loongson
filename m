Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2003 01:55:03 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:50998
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225450AbTJ3Bya>; Thu, 30 Oct 2003 01:54:30 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AF20Y-0004lW-00; Thu, 30 Oct 2003 02:53:54 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AF20X-0004Ut-00; Thu, 30 Oct 2003 02:53:53 +0100
Date: Thu, 30 Oct 2003 02:53:53 +0100
To: Jun Sun <jsun@mvista.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
Message-ID: <20031030015353.GE1486@rembrandt.csv.ica.uni-stuttgart.de>
References: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp> <20031029.163201.39178653.nemoto@toshiba-tops.co.jp> <20031029101400.J30683@mvista.com> <20031029181516.GA14443@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029181516.GA14443@nevyn.them.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
[snip]
> > > anemo> My program is huge enough so that older binutils causes
> > > anemo> "relocation truncated to fit" error.
> > > 
> > > More information.  My program's .got size exceeds 64K.  It seems the
> > > corruption does not happen if .got size is smaller then 64K.
> > > 
> > > $ mips-linux-readelf -e myapp
> > > ...
> > > Section Headers:
> > >   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
> > > ...
> > >   [21] .got              PROGBITS        100b15d0 a075d0 013a04 04 WAp  0   0 16
> > > 
> > 
> > Isn't this a known problem in binutils?  IIRC, someone is working or has
> > added "--big-got" support.
> 
> Atsushi-san's program would not even link with a binutils that didn't
> support multiple GOTs; I guess that something is going wrong with that
> support.

When building python-qt3 on debian unstable I get an oversize GOT and:

/usr/bin/ld: BFD 2.14.90.0.6 20030820 Debian GNU/Linux assertion fail ../../bfd/elfxx-mips.c:2287

Seems like multi-GOT is broken for this case.


Thiemo
