Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 18:56:04 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:16885 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225443AbTJVR4C>; Wed, 22 Oct 2003 18:56:02 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA15067;
	Wed, 22 Oct 2003 19:55:58 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 22 Oct 2003 19:55:58 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: LK201 keyboard
In-Reply-To: <20031022173444.GI20846@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1031022195223.11598O-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 22 Oct 2003, Jan-Benedict Glaw wrote:

> >  No problem -- I'll look at it.  We'll need the down/up mode for X11, so
> > it has to work.  Note: the LK4xx series keyboards start in the LK201
> 
> Erm, is this even correct if this keyboard isn't used "natively" by X11,
> but through the Input API?

 For the console (or the cooked mode) we already set up the device
correctly.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
