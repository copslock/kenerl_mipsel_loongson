Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 13:07:59 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:45488 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224941AbUAMNH6>; Tue, 13 Jan 2004 13:07:58 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 3AC474C175; Tue, 13 Jan 2004 14:07:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2CFF0129A; Tue, 13 Jan 2004 14:07:54 +0100 (CET)
Date: Tue, 13 Jan 2004 14:07:54 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
In-Reply-To: <20040113022826.GC1646@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 13 Jan 2004, Ralf Baechle wrote:

> > it seems the following is required in Linus' tree to get correct depends 
> > for DECSTATION:
> 
> Thanks,  applied.

 The dependency was intentional: stable for 32-bit, experimental for
64-bit.  I'm reverting the change immediately.  Please always contact me
before applying non-obvious changes for the DECstation.

 If there's anything wrong with the depends, it should be fixed elsewhere.  
Details, please.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
