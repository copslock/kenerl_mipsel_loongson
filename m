Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 19:12:35 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:18343 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225358AbUDESMe>; Mon, 5 Apr 2004 19:12:34 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 87B434AEA0; Mon,  5 Apr 2004 20:12:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 64B904AC7D; Mon,  5 Apr 2004 20:12:28 +0200 (CEST)
Date: Mon, 5 Apr 2004 20:12:28 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: [patch] swarm-cs4297a: Support little-endian configuration
In-Reply-To: <20040405105535.D13322@mvista.com>
Message-ID: <Pine.LNX.4.55.0404052010050.31851@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl>
 <20040405125436.GA2741@deprecation.cyrius.com>
 <Pine.LNX.4.55.0404051457010.31851@jurand.ds.pg.gda.pl> <20040405105535.D13322@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 5 Apr 2004, Jun Sun wrote:

> I have been using objcopy to convert ELF64 to ELF32 and then boot through 
> CFE (suggested by Drow).  This seems to be working fine.

 It does work and the Linux Makefile even does the conversion
automatically.  It's a bit annoying, though, to have to keep two images.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
