Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 22:31:48 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:19665 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225526AbTIVVbp>;
	Mon, 22 Sep 2003 22:31:45 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A1YHN-0002gr-NH; Mon, 22 Sep 2003 17:31:33 -0400
Date: Mon, 22 Sep 2003 17:31:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Eric Christopher <echristo@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
Message-ID: <20030922213133.GA10288@nevyn.them.org>
Mail-Followup-To: Alexandre Oliva <aoliva@redhat.com>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Eric Christopher <echristo@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl> <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com> <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de> <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 22, 2003 at 06:26:40PM -0300, Alexandre Oliva wrote:
> On Sep 19, 2003, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:
> 
> > A third answer is to add a -msign-extend-addresses switch in the assembler.
> 
> In what sense is this different from -Wa,-mabi=n32 ?

GDB gets the idea that you've got n64 code instead of o32 or n32 or
whatever code.  It transfers 64-bit data to the remote stub, et cetera.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
