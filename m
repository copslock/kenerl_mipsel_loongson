Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 13:14:00 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:54696 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQMN6>; Tue, 17 Jun 2003 13:13:58 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA22851;
	Tue, 17 Jun 2003 14:14:56 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 14:14:55 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: Juan Quintela <quintela@trasno.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <20030617085346.A27590@ftp.linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030617134735.22214B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Ladislav Michl wrote:

> Idea is to have only one way for printing kernel messages. In case of Indy,
> O2 and SNI RM200 "arc" console will do it. Here you can find where should
> be early console initialized:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105519188505235&w=2
> As Juan pointed out setup for such console is actually a nop and one is
> supposed to enable this feature only when debugging kernel. DEC prom console

 That's a valid point, as long as enabling it does not require a
reconfiguration.

> however needs some setup to determine REX entry points. early console is
> currently used on sh, alpha, x86_64 and ia64 architectures. Btw, see comment
> at the top of arch/sparc/prom/printf.c

 The DEC's entry points are a part of the problem only -- to support a
generic kernel, we need to move early_printk setup after setup_arch(), as
the level of variation is huge then.. 

 There is also that minor implementation problem -- how to pass varargs
from printk() to ROM's printf()?  At least the firmware of the DECstation
implements a full-featured printf() as in the C library. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
