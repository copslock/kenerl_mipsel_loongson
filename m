Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Apr 2004 14:15:29 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:11667 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225208AbUDFNP2>; Tue, 6 Apr 2004 14:15:28 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 2FEAA4BE44; Tue,  6 Apr 2004 15:15:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 222CD4BA73; Tue,  6 Apr 2004 15:15:22 +0200 (CEST)
Date: Tue, 6 Apr 2004 15:15:22 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mitch Lichtenberg <mpl@broadcom.com>
Cc: Jun Sun <jsun@mvista.com>, Martin Michlmayr <tbm@cyrius.com>,
	linux-mips@linux-mips.org
Subject: Re: [patch] swarm-cs4297a: Support little-endian configuration
In-Reply-To: <4071A555.8050202@broadcom.com>
Message-ID: <Pine.LNX.4.55.0404061512140.12172@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
 <20040405125436.GA2741@deprecation.cyrius.com>
 <Pine.LNX.4.55.0404051457010.31851@jurand.ds.pg.gda.pl> <20040405105535.D13322@mvista.com>
 <Pine.LNX.4.55.0404052010050.31851@jurand.ds.pg.gda.pl> <4071A555.8050202@broadcom.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 5 Apr 2004, Mitch Lichtenberg wrote:

> Adding ELF64 to CFE has been on my to-do list for ages.   Thanks for
> the reminder, I'll try to bump it up a few notches.

 Note it may be especially useful if booting a kernel (or any other
binary) to be loaded into XKPHYS.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
