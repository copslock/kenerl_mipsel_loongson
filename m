Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:51:29 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:6302 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225758AbUDXHv2>; Sat, 24 Apr 2004 08:51:28 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id CB80F4AEE3; Sat, 24 Apr 2004 09:51:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id B4F76475C5; Sat, 24 Apr 2004 09:51:22 +0200 (CEST)
Date: Sat, 24 Apr 2004 09:51:22 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
Message-ID: <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 24 Apr 2004, Stanislaw Skowronek wrote:

> Yeah. The weirdness is not in that part; what's weird is placing the rest
> of memory somewhere else.

 Perhaps to be able to put iomem stuff in CKSEG1 without implying a hole
in the RAM.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
