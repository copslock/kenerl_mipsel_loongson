Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2002 14:07:08 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:37534 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122117AbSJ3NHH>; Wed, 30 Oct 2002 14:07:07 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA04038;
	Wed, 30 Oct 2002 14:07:25 +0100 (MET)
Date: Wed, 30 Oct 2002 14:07:25 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
In-Reply-To: <20021029133021.D18288@mvista.com>
Message-ID: <Pine.GSO.3.96.1021030135048.1859E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 29 Oct 2002, Jun Sun wrote:

> > Why do you want to move the config? Is there any technical reason besides
> > grouping the subarch specific character devices below the generic
> > character devices instead of having a subarch specific menu ("DECstation
> > character devices")?
> 
> My limited xconfig knowledge seems to tell me that moving to the generic
> config file is the only way to make it work.  If you know a better way to fix
> this, I will be happy to see it.

 The DECstation setup is plain broken.  I've promised to look into it
once, but I haven't looked into it yet, sorry.  I'll see what I can do --
it shouldn't be hard.  I'll make a fix and ask you to test if it makes
your problems go away.  The submenu for "DECstation character devices" is
going to remain where it is now for 2.4, as the devices are (incorrectly)
scattered across directories.  For 2.5 they are going to be moved to
"drivers/serial" where they belong.  Especially as they are not really
DECstation-specific -- the VAX and Alpha (DEC 3000) ports may want to use
them as well. 

 The problem is CONFIG_SERIAL having different meanings for the MIPS port. 
It causes annoyance with dynamic parsers (like `make config') and I'm not
surprised it breaks the xconfig static parser. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
