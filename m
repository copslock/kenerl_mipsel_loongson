Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g58DgxnC003330
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 8 Jun 2002 06:42:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g58DgxfC003329
	for linux-mips-outgoing; Sat, 8 Jun 2002 06:42:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g58DgpnC003326
	for <linux-mips@oss.sgi.com>; Sat, 8 Jun 2002 06:42:51 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id GAA03132;
	Sat, 8 Jun 2002 06:44:53 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA14837;
	Sat, 8 Jun 2002 06:44:50 -0700 (PDT)
Message-ID: <009001c20ef3$98874980$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kjeld Borch Egevang" <kjelde@mips.com>,
   "Brad Parker" <brad@parker.boston.ma.us>
Cc: "linux-mips mailing list" <linux-mips@oss.sgi.com>
References: <200206081240.g58Cewe10560@p2.parker.boston.ma.us>
Subject: Re: float crash
Date: Sat, 8 Jun 2002 15:51:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The FP sr value does of course get initialized by default,
but the bug which Kjeld identified could prevent it.
The proper initialization of the emulated FPU state is
done only if last_task_used_math != current, under
the assumption that if the current task is the last task
to have used the "FPU", the current emulation cannot
be its first.  But in exit_thread()/flush_thread(), we
set last_task_used_math to NULL only if we have
an FPU.  Kjeld's patch breaks down the code so
that the *hardware* shutdown is done only if there
is an FPU, but the clearing of last_task_used_math
must be done whenever the current process has done FP.
Sorry about my offhand remark about no understanding
its relevance in my earlier response about the usefulness
of cfc1 $0,$31.

Without Kjeld's patch, a process inheriting a thread
context slot from a process which had done FP
emulation would have inherited the FP register 
state, including SR, of that previous process.
If you're seeing the problem only *with* Kjeld's
patch, there must have been a typo inserted in
the chain somewhere...

            Kevin K.

----- Original Message ----- 
From: "Brad Parker" <brad@parker.boston.ma.us>
To: "Kjeld Borch Egevang" <kjelde@mips.com>; "Kevin D. Kissell" <kevink@mips.com>
Cc: "linux-mips mailing list" <linux-mips@oss.sgi.com>
Sent: Saturday, June 08, 2002 2:40 PM
Subject: re: float crash


> 
> Quick question -
> 
> I'm running a 2.4.17 kernel on an Au1000 (MIPS32).  Trying to run
> Kaffe I get SIGFPE's in odd places (like dividing 11 by 44).  I tracked
> it down to the fpe emulator setting the cx bit which is setting
> the "inexact" bit in the fp status reg.  
> 
> I think the real problem is that the fp sr is not being initialized.
> It doesn't happen in a trivial program but in Kaffe it happens a lot.
> it's somewhat random, however, as if something is not initialized.
> 
> I wonder if the fix you two where talking about is the problem; i.e.
> in traps.c "if (last_task_used_math != current) {"
> 
> Is there a recommended fix?  Just comment out the test?
> 
> thanks!
> 
> -brad
> 
> ps: I tried to subscribe to the linux-mips list but the sendmail on
> oss.sgi.com is rejecting my email with "access denied".  I don't have
> any open relays and I'm not a spammer :-)  I can't even send email
> to the postmaster...
> 
> 
