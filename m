Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 14:41:08 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:49839 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQNlG>; Tue, 17 Jun 2003 14:41:06 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA23911;
	Tue, 17 Jun 2003 15:42:03 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 15:42:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: Juan Quintela <quintela@trasno.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <20030617131859.A32079@ftp.linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030617153617.22214E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Ladislav Michl wrote:

> >  So you need to explicitly configure it?  That's very bad.
> 
> I think we can leave it enabled by default, since it doesn't hurt too much.

 That's not the point -- someone will sooner or later disable it and
someone else will use that kernel and report bugs stating there is nothing
output and the kernel hangs.  And he might be unable to rebuild the kernel
for whatever reason or the rebuilt kernel will "magically" work. 

> Kernel cmdline argument could control usage of early console.

 No problem -- it's like the "debug" option today, that I can ask someone
to add to get a more detailed report (my systems use it by default). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
