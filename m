Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 09:15:02 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:5129
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225387AbTIWIPA>; Tue, 23 Sep 2003 09:15:00 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1iJr-0006Rr-00; Tue, 23 Sep 2003 10:14:47 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1iJr-0003kn-00; Tue, 23 Sep 2003 10:14:47 +0200
Date: Tue, 23 Sep 2003 10:14:47 +0200
To: Eric Christopher <echristo@redhat.com>
Cc: Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl> <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com> <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br> <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de> <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Eric Christopher wrote:
> On Mon, 2003-09-22 at 16:39, Thiemo Seufer wrote:
> > Alexandre Oliva wrote:
> > > On Sep 19, 2003, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:
> > > 
> > > > A third answer is to add a -msign-extend-addresses switch in the assembler.
> > > 
> > > In what sense is this different from -Wa,-mabi=n32 ?
> > 
> > ELF64 instead of ELF32.
> 
> objcopy?

You mean, let gcc generate n64 code, stuff it in n32 objects, and
objcopy it back to n64? Well, it may work, but it looks more like
a test of binutils sign-extension handling than a straightforward
way of creating kernels to me.

Besides, as soon as gcc handles 64bit expansions itself we need
such an option anyway.


Thiemo
