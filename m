Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 20:56:52 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:19934 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225376AbTIWT4t>;
	Tue, 23 Sep 2003 20:56:49 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A1tH5-0002Qc-9m; Tue, 23 Sep 2003 15:56:39 -0400
Date: Tue, 23 Sep 2003 15:56:39 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Zack Weinberg <zack@codesourcery.com>
Cc: Eric Christopher <echristo@redhat.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030923195638.GA9318@nevyn.them.org>
Mail-Followup-To: Zack Weinberg <zack@codesourcery.com>,
	Eric Christopher <echristo@redhat.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl> <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com> <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br> <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de> <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com> <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de> <1064340070.21720.14.camel@ghostwheel.sfbay.redhat.com> <20030923181659.GA30037@nevyn.them.org> <87eky7b867.fsf@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eky7b867.fsf@codesourcery.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 23, 2003 at 12:45:36PM -0700, Zack Weinberg wrote:
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
> such spelling) that tells gcc to do the right thing in the first
> place?

GCC should get a switch to do this.  But GCC doesn't (does 3.4 yet?)
emit these itself anyway.  Binutils expands them from the dla macro.


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
