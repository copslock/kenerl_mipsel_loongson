Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HMtVnC031625
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 15:55:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HMtVmW031624
	for linux-mips-outgoing; Mon, 17 Jun 2002 15:55:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HMtQnC031620
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 15:55:26 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5HMv9u03463;
	Mon, 17 Jun 2002 15:57:09 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: system.h asm fixes
From: Justin Carlson <justin@cs.cmu.edu>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20020617223650.GD20335@rembrandt.csv.ica.uni-stuttgart.de>
References: <1024338042.1463.21.camel@localhost.localdomain>
	<20020617224452.C27009@dea.linux-mips.net> 
	<20020617223650.GD20335@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 15:57:08 -0700
Message-Id: <1024354629.3160.8.camel@xyzzy.rlson.org>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-06-17 at 15:36, Thiemo Seufer wrote:
> Ralf Baechle wrote:
> [snip]
> > > Looks to me like we're missing some proper asm clobber markers:
> > 
> > No, as per convention $1 is never used by the compiler per convention,
> > so clobbering not necessary.  I recently removed all "$1" clobbers to
> > make the code a bit easier to read.
> 
> How can this work? A grep shows many instances of $1 usage,
> I don't think all of this code is interrupt safe.
> 

The "$x" clobber markers exist so that the *compiler* won't expect
values in those registers to be preserved across the asm call.  It has
nothing to do with safety across interrupts.  In other words, it's there
to prevent something like this:

	foo = 2;   // Compiler sticks foo a register, say, $2	
	asm (
		"  lw $2, baz\n"
		"  sw $2, (%0)\n"
		::"r" (sna));   // Assembly code uses $2 as a temp reg
	(*bar) = foo;      // Compiler erroneously does (*bar) = baz;

In terms of interrupt safety, there is no issue with $1; any interrupt
would save the register before mucking with it, and restore it before
returning.  The only registers for which this is not true are k0 and k1.

As others have rightly pointed out, the compiler isn't allowed to muck
with $1 anyways, as it is defined to be a temporary register for the
assembler.  So the clobber notation isn't necessary.

Make sense?

-Justin
