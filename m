Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 13:30:22 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:44957 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225225AbTDNMaV>; Mon, 14 Apr 2003 13:30:21 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA25442;
	Mon, 14 Apr 2003 14:31:00 +0200 (MET DST)
Date: Mon, 14 Apr 2003 14:31:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Erik J. Green" <erik@greendragon.org>, linux-mips@linux-mips.org
Subject: Re: Where does physical RAM start in kseg0?
In-Reply-To: <20030413042529.A20034@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030414142823.24742B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sun, 13 Apr 2003, Ralf Baechle wrote:

> Due to the Octane's funky address space layout and the current tools
> limitations the kernel will have to run in CKSEG2 instead of KSEG0 ...

 Recent tools (like these at my site) should be fine for making an XPHYS
kernel -- it's the assumption of being in the 32-bit address space made
here and there in the kernel that bites...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
