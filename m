Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2003 08:55:30 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:54990 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225200AbTG3Hz2>; Wed, 30 Jul 2003 08:55:28 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id JAA27010;
	Wed, 30 Jul 2003 09:55:26 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 30 Jul 2003 09:55:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Keith M Wesolowski <wesolows@foobazco.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030730031631.GD7366@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030730094741.26733B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jul 2003, Ralf Baechle wrote:

> >  I hope `uname -m' will continue to report the correct architecture and
> > that ARCH will be correctly handled (i.e. "mips" selecting a 32-bit build
> > and "mips64" a 64-bit one) -- have you considered this?
> 
> Not intend to change the behaviour of uname.  It actually changed in CVS,
> for now consider that a bug ...

 OK, I will.

> We should consider changing the behaviour though.  A machine type of
> mips64 broke lots of software.  Of course that was all 32-bit softare but
> it raises the question if returning mips64 is really a good idea?

 Yes it is.  It is the only way to check if the kernel is 32-bit or 64-bit
and config.guess needs it for guessing the canonical system name.  That,
plus checking the default ld emulation lets it (or will let, once written)
select what is the proper default native configuration: 
mips{,el}-unknown-linux-gnu, mips64{,el}-unknown-linux-gnu-abin32 or
mips64{,el}-unknown-linux-gnu-abi64. 

> As for choosing a 32-bit vs. 64-bit kernel, that's now a menu point and can
> be choosen like every other config option.

 Well, I liked the `make "ARCH=mips64"' way, but I suppose I'll have to
live with your change, sigh... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
