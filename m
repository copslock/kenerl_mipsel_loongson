Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 15:15:56 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:33169 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225255AbTFDOPy>; Wed, 4 Jun 2003 15:15:54 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA20290;
	Wed, 4 Jun 2003 16:16:48 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Wed, 4 Jun 2003 16:16:48 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Krishnakumar. R" <krishnakumar@naturesoft.net>,
	linux-mips@linux-mips.org
Subject: Re: Single stepping in mips
In-Reply-To: <20030604055319.GB8778@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030604161038.18707C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 4 Jun 2003, Ralf Baechle wrote:

> > But the need is to raise an exception after instr1 (at addr1) is executed.
> > One solution is using a break at instr2 (at addr2).
> > But suppose instr1 is a jmp then there is no point
> > in keeping a break at addr2.
> > (inorder to raise an exception after instr1 is executed).
> 
> You understood correctly.  Now jumps and even more so the conditional
> branches are sort of the ugly part of the whole thing.  The easiest
> method is probably inserting a branch at the jump's destination address
> or in case of a branch at the branch target and the instruction following
> it's delay slot.  So that's a lot of inserting and removing of
> breakpoints ...

 In a more finegrained but also more complicated example, you probably
want to insert a breakpoint in the delay slot first and at the second step
evaluate the branch's condition and put a breakpoint at the next
instruction to be executed.  I'm not sure if the current version of gdb
does the first step, but it inserts a single breakpoint in the second one
only.  For branch likely instructions adjust the two steps as necessary. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
