Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 14:56:11 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:3054 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225366AbTJVN4H>; Wed, 22 Oct 2003 14:56:07 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA12473;
	Wed, 22 Oct 2003 15:56:03 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 22 Oct 2003 15:56:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: LK201 keyboard
In-Reply-To: <20031021202328.GO20846@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1031022155154.11598B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 21 Oct 2003, Jan-Benedict Glaw wrote:

> What the "old" lk driver uses is more-or-less what could be referred as
> power-on configuration. Even if there are set mode commande - if they
> were ignored, it would silently work as expected. Could you set all
> groups to "DOWN_UP_MODE" and verify that it no longer works?

 No problem -- I'll look at it.  We'll need the down/up mode for X11, so
it has to work.  Note: the LK4xx series keyboards start in the LK201
compatibility mode -- they have to be switched to the native mode with a
command if desired, so unless you are reprogramming your LK401 to its
native mode, what works for it should also work for the LK201. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
