Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 10:36:29 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:13539 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225206AbUCZKg2>; Fri, 26 Mar 2004 10:36:28 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 9726547A2D; Fri, 26 Mar 2004 11:36:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 83CA547781; Fri, 26 Mar 2004 11:36:21 +0100 (CET)
Date: Fri, 26 Mar 2004 11:36:21 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Shantanu Gogate <sagogate@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mips gcc compile error : unrecognized opcode errors
In-Reply-To: <20040326102917.53609.qmail@web60703.mail.yahoo.com>
Message-ID: <Pine.LNX.4.55.0403261134030.3736@jurand.ds.pg.gda.pl>
References: <20040326102917.53609.qmail@web60703.mail.yahoo.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 26 Mar 2004, Shantanu Gogate wrote:

> I am trying to cross compile a user mode application for mips and I am getting these error
> messages when trying to do that:
> 
> /tmp/ccgvdHuk.s: Assembler messages:
> /tmp/ccgvdHuk.s:1270: Error: unrecognized opcode `btl $4,0($2)'
> /tmp/ccgvdHuk.s:1270: Error: unrecognized opcode `setcb $25'
> /tmp/ccgvdHuk.s:3124: Error: unrecognized opcode `btl $4,0($2)'
> /tmp/ccgvdHuk.s:3124: Error: unrecognized opcode `setcb $25'
> /tmp/ccgvdHuk.s:3769: Error: unrecognized opcode `btl $4,0($2)'
> /tmp/ccgvdHuk.s:3769: Error: unrecognized opcode `setcb $25'

 These are not MIPS instructions.  Make sure the file is built with a 
compiler for the MIPS target.  There's likely a bug in your Makefile.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
