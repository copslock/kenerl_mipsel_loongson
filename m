Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2003 12:04:17 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:49624 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbTA0MEQ>; Mon, 27 Jan 2003 12:04:16 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA01425;
	Mon, 27 Jan 2003 13:04:26 +0100 (MET)
Date: Mon, 27 Jan 2003 13:04:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <20030127072857.A13629@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030127125225.1077A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 27 Jan 2003, Ralf Baechle wrote:

> > Log message:
> > 	Fix a restoration of assembler's settings in csum_ipv6_magic().
> 
> Wow, how did you catch this one - running IPv6?

 I do run IPv6 -- I get to my 32-bit box with SSH over IPv6 just to make
sure I'll find more bugs (the previous one was the multicast filter). ;-) 
I even have ipv6.o as a module (which also triggered bugs in the past). 
Will have to try with the 64-bit box. ;-)))

 But this bug I've actually spotted studying compiler's diagnostic output
-- a "Macro instruction expanded into multiple instructions in a branch
delay slot" warning isn't normal for a .c file. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
