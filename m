Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 15:16:44 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:29874 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQOQl>; Tue, 17 Jun 2003 15:16:41 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA24437;
	Tue, 17 Jun 2003 16:17:36 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 16:17:35 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: Juan Quintela <quintela@trasno.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <20030617134510.B32079@ftp.linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030617155734.22214I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Ladislav Michl wrote:

> >  There is also that minor implementation problem -- how to pass varargs
> > from printk() to ROM's printf()?  At least the firmware of the DECstation
> > implements a full-featured printf() as in the C library.
> 
> you are implementing early console not printf (sorry again for confusion),
> so there is no need to pass varargs anywhere. btw, early_printk() as known
> from other archs is supposed to die in future. printk() should be used
> everywhere.

 Hmm, calling the firmware for each character separately will certainly be
terribly slow, though it may be negligible as normally few messages will
be output this way.  And since the call to prom_printf() is so cheap for
the DECstation, I'm going to retain the function for real low-level
debugging, whether otherwise used or not. 

 BTW,I just realized console output via the firmware is mandatory for the
DECstation -- we have cases where the kernel is not going to be started
far enough to have any console set up because of a misconfiguration.  With
current prom_printf() implementation the reason is output to the console
and a user has a chance to know why.  With an optional early printk, he'll
just see the kernel return to the firmware for no apparent reason without
any output.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
