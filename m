Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FMKQnC012843
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 15:20:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FMKQXN012842
	for linux-mips-outgoing; Sat, 15 Jun 2002 15:20:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FMKNnC012839
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 15:20:23 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5FMMTM01743;
	Sat, 15 Jun 2002 15:22:29 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: reenabling interrupts on return from function
From: Justin Carlson <justin@cs.cmu.edu>
To: Justin Carlson <justin@cs.cmu.edu>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <1024177741.1549.4.camel@localhost.localdomain>
References: <1024177741.1549.4.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Jun 2002 15:22:28 -0700
Message-Id: <1024179748.1549.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 2002-06-15 at 14:49, Justin Carlson wrote:
> I'm obviously missing something basic here.
> 
> Looking at stackframe.h, I see this code as a part of RESTORE_SOME
> 
> 
> 		mfc0	t0, CP0_STATUS;                  \
> 		.set	pop;                             \
> 		ori	t0, 0x1f;                        \
> 		xori	t0, 0x1f;                        \
> 		mtc0	t0, CP0_STATUS;                  
> 

OK, this was a stupid question; the answer was staring me in the face
(the restoration of the status register from the stack), and I didn't
see it.

However, I still don't see the point of the above code.  Why do we
explicitly clear bits 4-0 of the status register just before reloading
it from the system stack?  

-Justin
