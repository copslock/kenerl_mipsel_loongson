Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 12:07:39 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:33996 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225241AbTFELHh>; Thu, 5 Jun 2003 12:07:37 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA06283;
	Thu, 5 Jun 2003 13:08:20 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 5 Jun 2003 13:08:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Jun Sun <jsun@mvista.com>, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
In-Reply-To: <019201c32b40$2d54cf60$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1030605124326.5828D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 5 Jun 2003, Kevin D. Kissell wrote:

> > > > 1) clocks on different CPUs don't have the same frequency
> > > > 2) clocks on different CPUs drift to each other
> > > > 2) some fancy power saving feature such as frequency scaling
> > > > 
> > > > But I think for a foreseeable future most MIPS SMP machines
> > > > don't have the above issues (true?).  And it is probably worthwile
> > > > to synchronize count registers for them.
> > > 
> > > 1) and 2) affect most SGI systems.
> > >
> > 
> > Assuming SGI systems represent the past of MIPS, we are still ok
> > future-wise. :)
> 
> I personally think it would be foolish to assume that future MIPS 
> MP systems will not be subject to one or more such constraint.

 Depending on the system in use it may be easier to get a suitable
external clock reference, e.g. a chipset timer.  If an access to it would
be slow, it could be cached on timer interrupts and extended with
processors' timers.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
