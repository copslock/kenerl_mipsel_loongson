Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 19:04:48 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:56773 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225474AbTI3SEq>; Tue, 30 Sep 2003 19:04:46 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA13163;
	Tue, 30 Sep 2003 20:04:43 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 30 Sep 2003 20:04:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Finney, Steve" <Steve.Finney@SpirentCom.COM>,
	linux-mips@linux-mips.org
Subject: Re: 64 bit operations w/32 bit kernel
In-Reply-To: <20030930160023.GB4231@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030930195415.11368C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 30 Sep 2003, Ralf Baechle wrote:

> > What would be the downside to enabling 64 bit operations in user space
> > on a 32 bit kernel (setting the PX bit in the status register?). The
> > particular issue is that I want to access 64 bit-memory mapped registers,
> > and I really need to do it as an atomic operation. I tried borrowing
> > sibyte/64bit.h from the kernel, but I get an illegal instruction on the
> > double ops.
> 
> Common design bug in hardware, imho ...

 Well, ioremap() can be used to get at these areas (as well as any
others), whether we call it a bug or not.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
