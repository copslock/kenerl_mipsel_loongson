Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 12:46:38 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:24486 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTFQLqe>; Tue, 17 Jun 2003 12:46:34 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA22474;
	Tue, 17 Jun 2003 13:47:09 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 17 Jun 2003 13:47:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@trasno.org>
cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] kill prom_printf
In-Reply-To: <867k7lsiq1.fsf@trasno.mitica>
Message-ID: <Pine.GSO.3.96.1030617134319.22214A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 17 Jun 2003, Juan Quintela wrote:

> Anyways, you can use early_printk() in MIPS.  You only need to put the
> setup of the early console sooner, as for you the setup is basically a NOP.

 Well, I would see early_printk() as advantageous if it was also capable
to leave messages in the kernel ring buffer for dmesg or klogd to fetch. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
