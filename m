Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 17:47:05 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:52662 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225197AbTDCQrF>; Thu, 3 Apr 2003 17:47:05 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA24847;
	Thu, 3 Apr 2003 18:47:22 +0200 (MET DST)
Date: Thu, 3 Apr 2003 18:47:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dominic Sweetman <dom@mips.com>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <16012.25072.379410.787234@gladsmuir.mips.com>
Message-ID: <Pine.GSO.3.96.1030403183957.19058J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 3 Apr 2003, Dominic Sweetman wrote:

> The length of the burst is encoded in the bus command sent out by the
> R4000 at the beginning of a read or write cycle.  For the system to
> work, the memory controller has to be able to do the right thing for
> both of the lengths which might happen...
[...]
> This is true: for L2-equipped chips I assume you can't see the
> difference between I- and D-.

 Ah sure -- now I see where a fault in my consideration is.  While
thinking of SC chips, I forgot of the existence of PC ones -- certainly if
the Magnum used a PC configuration, its chipset could easily observe a
change of a p-cache line size.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
