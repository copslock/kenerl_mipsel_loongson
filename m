Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 13:15:16 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:63400 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQMPO>; Tue, 17 Jun 2003 13:15:14 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22870;
	Tue, 17 Jun 2003 14:16:13 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 14:16:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: Juan Quintela <quintela@trasno.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <20030617125216.E27590@ftp.linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030617141524.22214C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Ladislav Michl wrote:

> >  Well, I would see early_printk() as advantageous if it was also capable
> > to leave messages in the kernel ring buffer for dmesg or klogd to fetch. 
> 
> Ah, we probably don't understand each other. I should type EARLY_PRINTK
> instead of early_printk (sorry for my lazyness, I'm usually typing in
> lowercase). CONFIG_EARLY_PRINTK enables early console, you are supposed to
> use printk everywhere and that way you achieve such functionality.

 So you need to explicitly configure it?  That's very bad.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
