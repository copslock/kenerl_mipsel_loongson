Received:  by oss.sgi.com id <S553824AbQLKLzz>;
	Mon, 11 Dec 2000 03:55:55 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:21394 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553855AbQLKLzb>;
	Mon, 11 Dec 2000 03:55:31 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA20895;
	Mon, 11 Dec 2000 12:28:19 +0100 (MET)
Date:   Mon, 11 Dec 2000 12:28:19 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
In-Reply-To: <20001209003222.A10669@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001211122115.18945B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 9 Dec 2000, Ralf Baechle wrote:

> Actually there is almost nothing left that uses /dev/{mem,kmem} these days.

 Last time I checked /dev/mem worked as expected.  For Alpha /dev/mem is
used to emulate PCI/ISA I/O space accesses (ioperm(), inb/outb() and
friends) by glibc.  At least XFree86 and SVGATextMode make use of these
features.  I suppose it's the same for MIPS (I haven't checked, though). 

 In general /dev/mem is useful for poking at hardware from user space.  On
the other hand, /dev/kmem is not very useful anymore, indeed. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
