Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 16:18:54 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:14021 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225225AbTFPPSv>; Mon, 16 Jun 2003 16:18:51 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA05168;
	Mon, 16 Jun 2003 17:19:46 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Mon, 16 Jun 2003 17:19:45 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <20030616143303.GA18363@simek>
Message-ID: <Pine.GSO.3.96.1030616165248.2112D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 16 Jun 2003, Ladislav Michl wrote:

> I was told by many people that prom_printf and friends should die and
> early_printk should be used instead. this patch (against 2.5) does first
> part of job. compiles and works on IP22 (SNI RM200 and IP32 don't
> compile anyway). Feedback appreciated, as always.

 Hmm, strange idea -- I guess that originates from systems that have no
suitable firmware to perform such an operation at the console.  Currently
only x86_64 implements early_printk() -- if we have an implementation for
MIPS, we may consider removing the alternative.  Also prom_printf() comes
almost for free and works very early and as I see in the x86_64 version
early_printk() requires initialization of a console driver, which may be
unfortunate if debugging a problem within the driver. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
