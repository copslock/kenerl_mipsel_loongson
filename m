Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 15:26:05 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:49605 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225255AbTFDO0C>;
	Wed, 4 Jun 2003 15:26:02 +0100
Received: from dsl093-172-017.pit1.dsl.speakeasy.net
	([66.93.172.17] helo=nevyn.them.org ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19NZDj-0002Up-00; Wed, 04 Jun 2003 09:26:31 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19NZD2-00051t-00; Wed, 04 Jun 2003 10:25:48 -0400
Date: Wed, 4 Jun 2003 10:25:48 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"Krishnakumar. R" <krishnakumar@naturesoft.net>,
	linux-mips@linux-mips.org
Subject: Re: Single stepping in mips
Message-ID: <20030604142548.GA19282@nevyn.them.org>
References: <20030604055319.GB8778@linux-mips.org> <Pine.GSO.3.96.1030604161038.18707C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030604161038.18707C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 04, 2003 at 04:16:48PM +0200, Maciej W. Rozycki wrote:
> On Wed, 4 Jun 2003, Ralf Baechle wrote:
> 
> > > But the need is to raise an exception after instr1 (at addr1) is executed.
> > > One solution is using a break at instr2 (at addr2).
> > > But suppose instr1 is a jmp then there is no point
> > > in keeping a break at addr2.
> > > (inorder to raise an exception after instr1 is executed).
> > 
> > You understood correctly.  Now jumps and even more so the conditional
> > branches are sort of the ugly part of the whole thing.  The easiest
> > method is probably inserting a branch at the jump's destination address
> > or in case of a branch at the branch target and the instruction following
> > it's delay slot.  So that's a lot of inserting and removing of
> > breakpoints ...
> 
>  In a more finegrained but also more complicated example, you probably
> want to insert a breakpoint in the delay slot first and at the second step
> evaluate the branch's condition and put a breakpoint at the next
> instruction to be executed.  I'm not sure if the current version of gdb
> does the first step, but it inserts a single breakpoint in the second one
> only.  For branch likely instructions adjust the two steps as necessary. 

Does that actually work reliably across MIPS processors?  I don't
believe that it will.  I suppose you could re-execute the branch to get
the delay slot executed...

GDB simply executes the branch and its delay slot as a unit.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
