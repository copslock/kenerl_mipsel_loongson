Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 17:41:33 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:11310
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225469AbTISQla>; Fri, 19 Sep 2003 17:41:30 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A0OJs-00036g-00; Fri, 19 Sep 2003 18:41:20 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A0OJr-0003ca-00; Fri, 19 Sep 2003 18:41:19 +0200
Date: Fri, 19 Sep 2003 18:41:19 +0200
To: Eric Christopher <echristo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl> <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Eric Christopher wrote:
> On Fri, 2003-09-19 at 05:52, Maciej W. Rozycki wrote:
> > On Thu, 18 Sep 2003, Eric Christopher wrote:
> > 
> > > > But mips64 kernel assumes that the kernel itself is compiled with
> > > > "-mabi=64".  For example, some asm routines pass more than 4 arguments
> > > > via aN registers.
> > > 
> > > Yes, but then you aren't abi compliant are you? If you want n64 then say
> > > n64. If you want o32 extended to 64-bit registers then use o64.
> > 
> >  I think "-mabi=64" is OK (I use it for over a year now) and for those
> > worried of every byte of precious memory, "-mabi=n32 -mlong64" might be
> > the right long-term answer (although it might require verifying if tools
> > handle it right).  Given the experimental state of the 64-bit kernel it
> > should be OK to be less forgiving on a requirement for recent tools. 
> 
> OK as in "it works for me", and OK as in "this is the correct usage" are
> two different things. I believe that for a 64-bit kernel either -mabi=64
> or -mabi=n32 (-mlong64) are the right long term answer,

A third answer is to add a -msign-extend-addresses switch in the assembler.
Together with -mabi=64 this would produce optimized ELF64 output.

> part of Daniel's
> problem was that his bootloader couldn't deal with ELF64.

Well, implementing an ELF64 bootloader ins't that hard. :-)


Thiemo
