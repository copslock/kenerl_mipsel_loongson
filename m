Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 00:40:11 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:14854
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225547AbTIVXkJ>; Tue, 23 Sep 2003 00:40:09 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1A1aHY-0002iy-00; Tue, 23 Sep 2003 01:39:52 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1A1aHY-0002Ir-00; Tue, 23 Sep 2003 01:39:52 +0200
Date: Tue, 23 Sep 2003 01:39:52 +0200
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Eric Christopher <echristo@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl> <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com> <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Alexandre Oliva wrote:
> On Sep 19, 2003, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:
> 
> > A third answer is to add a -msign-extend-addresses switch in the assembler.
> 
> In what sense is this different from -Wa,-mabi=n32 ?

ELF64 instead of ELF32.


Thiemo
