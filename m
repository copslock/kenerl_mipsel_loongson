Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 18:24:13 +0000 (GMT)
Received: from p508B6DCE.dip.t-dialin.net ([IPv6:::ffff:80.139.109.206]:13973
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225285AbSLQSYM>; Tue, 17 Dec 2002 18:24:12 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBHINjI18394;
	Tue, 17 Dec 2002 19:23:45 +0100
Date: Tue, 17 Dec 2002 19:23:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] add dispatch_i8259_irq() to i8259.c
Message-ID: <20021217192344.A18364@linux-mips.org>
References: <20021216124009.D10178@mvista.com> <Pine.GSO.3.96.1021217131352.7289A-100000@delta.ds2.pg.gda.pl> <15871.13866.515311.16388@arsenal.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15871.13866.515311.16388@arsenal.algor.co.uk>; from dom@algor.co.uk on Tue, Dec 17, 2002 at 02:35:22PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 02:35:22PM +0000, Dominic Sweetman wrote:

> Alternatively, many MIPS systems have a hardware feature which enables
> them to generate imitation-x86 interrupt acknowledge cycles, so you
> can keep the 8259s in complete ignorance that they're not being
> controlled by an x86.  

Unless the hardware is an RM200 where under special circumstances the
hardware acknowledge feature may result in loss of some or all i8259
interrupts until full-reinitialization of the i8259 ...

Bugs, bugs ...

  Ralf
