Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 18:33:05 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:21922 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225289AbSLQSdE>; Tue, 17 Dec 2002 18:33:04 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA15636;
	Tue, 17 Dec 2002 19:33:13 +0100 (MET)
Date: Tue, 17 Dec 2002 19:33:12 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Dominic Sweetman <dom@algor.co.uk>, Jun Sun <jsun@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
In-Reply-To: <20021217192344.A18364@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021217192814.7289E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Dec 2002, Ralf Baechle wrote:

> > Alternatively, many MIPS systems have a hardware feature which enables
> > them to generate imitation-x86 interrupt acknowledge cycles, so you
> > can keep the 8259s in complete ignorance that they're not being
> > controlled by an x86.  
> 
> Unless the hardware is an RM200 where under special circumstances the
> hardware acknowledge feature may result in loss of some or all i8259
> interrupts until full-reinitialization of the i8259 ...

 Can the hardware acknowledge be disabled?  If so, my proposed code should
work just fine.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
