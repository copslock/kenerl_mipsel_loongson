Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6V0USRw012126
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 17:30:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6V0USBd012125
	for linux-mips-outgoing; Tue, 30 Jul 2002 17:30:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f207.dialo.tiscali.de [62.246.16.207])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6V0UKRw012116
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 17:30:22 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6V0Ve503371;
	Wed, 31 Jul 2002 02:31:40 +0200
Date: Wed, 31 Jul 2002 02:31:40 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: GAS 4kc question...
Message-ID: <20020731023140.B2142@dea.linux-mips.net>
References: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com>; from nmckee@telogy.com on Tue, Jul 30, 2002 at 06:28:32PM -0400
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 30, 2002 at 06:28:32PM -0400, Zajerko-McKee, Nick wrote:

> I'm trying to write some inline assembler code that needs the madd and mulu
> op codes found on the 4KC processor.  I've tried setting the cpu to 4650,
> but it failed to recognize the mulu instruction.  Can someone give me the
> magic incantation?  I'm running right now GCC 2.95.3 from Montavista.  I
> guess one way I can attack it for now is to build the op code by hand, but
> that is quite dirty, IMHO...

That's an inconsistence in the MIPS instruction set.  The old two operand
multiply instruction exists as both signed and unsigned (mult / multu)
but the new-style signed multiply only in an unsigned flavour.  In other
words, there is no mulu instruction.

I guess the reason was that this instruction is mainly used for DSP-style
stuff which need signed arithmetics while burning valuable space in the
instruction set for a mulu instruction wasn't considered worth the
instruction space.

  Ralf
