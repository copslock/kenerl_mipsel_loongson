Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 21:04:25 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:56078
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225376AbTIWUEW>; Tue, 23 Sep 2003 21:04:22 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1tNq-0003dB-00; Tue, 23 Sep 2003 22:03:38 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1tNp-00068S-00; Tue, 23 Sep 2003 22:03:37 +0200
Date: Tue, 23 Sep 2003 22:03:37 +0200
To: Zack Weinberg <zack@codesourcery.com>
Cc: Eric Christopher <echristo@redhat.com>,
	Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030923200337.GE18698@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl> <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com> <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br> <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de> <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com> <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de> <1064340070.21720.14.camel@ghostwheel.sfbay.redhat.com> <20030923181659.GA30037@nevyn.them.org> <87eky7b867.fsf@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eky7b867.fsf@codesourcery.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Zack Weinberg wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
> 
> > On Tue, Sep 23, 2003 at 11:01:11AM -0700, Eric Christopher wrote:
> >> 
> >> I'm still trying to figure out why you are going through such weird
> >> contortions at all. I understand not having an elf64 loader. That's what
> >> the objcopy comment was for, everything else I don't understand. Why not
> >> compile for the abi you want?
> >
> > Compare the optimal way to load an address into a register when you
> > have a full 64-bit address space and when you know that addresses are
> > sign extended.  I'm told it saves over 100K of code.
> 
> Maybe what you really want is an -mdata-model=kernel switch (or some
> such spelling)

Well, an ELF64 kernel loaded in the 64bit address space is also legal,
and desireable on some (bigger) hardware. Btw, it would have to be
-mtext-model=kernel, the data is the same. :-)

> that tells gcc to do the right thing in the first place?

Gcc still generates MIPS assembler macros, so such a switch would
do nothing yet. Gcc should be changed to do the expansion itself
(and improve code quality by that), but that's a much larger task.


Thiemo
