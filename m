Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 06:53:22 +0100 (BST)
Received: from p508B7EE4.dip.t-dialin.net ([IPv6:::ffff:80.139.126.228]:35994
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225244AbTFDFxU>; Wed, 4 Jun 2003 06:53:20 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h545rJbY009154;
	Tue, 3 Jun 2003 22:53:19 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h545rJ7Y009153;
	Wed, 4 Jun 2003 07:53:19 +0200
Date: Wed, 4 Jun 2003 07:53:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Single stepping in mips
Message-ID: <20030604055319.GB8778@linux-mips.org>
References: <200306040918.01943.krishnakumar@naturesoft.net> <20030604051818.GA2365@linux-mips.org> <200306041107.55492.krishnakumar@naturesoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306041107.55492.krishnakumar@naturesoft.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 11:07:55AM +0530, Krishnakumar. R wrote:

> we will get a break point exception as soon as the break
> in addr1 is executed (correct me if I have wrongly understood !! )
> 
> But the need is to raise an exception after instr1 (at addr1) is executed.
> One solution is using a break at instr2 (at addr2).
> But suppose instr1 is a jmp then there is no point
> in keeping a break at addr2.
> (inorder to raise an exception after instr1 is executed).

You understood correctly.  Now jumps and even more so the conditional
branches are sort of the ugly part of the whole thing.  The easiest
method is probably inserting a branch at the jump's destination address
or in case of a branch at the branch target and the instruction following
it's delay slot.  So that's a lot of inserting and removing of
breakpoints ...

  Ralf
