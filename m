Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FLkxnC012501
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 14:46:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FLkxNG012500
	for linux-mips-outgoing; Sat, 15 Jun 2002 14:46:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FLksnC012497
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 14:46:55 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5FLn2x01680;
	Sat, 15 Jun 2002 14:49:02 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: reenabling interrupts on return from function
From: Justin Carlson <justin@cs.cmu.edu>
To: linux-mips@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Jun 2002 14:49:01 -0700
Message-Id: <1024177741.1549.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm obviously missing something basic here.

Looking at stackframe.h, I see this code as a part of RESTORE_SOME


		mfc0	t0, CP0_STATUS;                  \
		.set	pop;                             \
		ori	t0, 0x1f;                        \
		xori	t0, 0x1f;                        \
		mtc0	t0, CP0_STATUS;                  

Here, we're explicitly clearing the IE bit (among others) in the status
register, and we leave it cleared.  The status register is not touched
again until we do an eret.

First, why do we explicitly clear the IE bit, when we're running with
the EXL bit set?  And where is the black magic that is re-enabling
interrupts for the return to usermode?

I must be missing something really fundamental here.  Anyone care to
point out my obvious gaps of knowledge?  :) 

Thanks,
  Justin
