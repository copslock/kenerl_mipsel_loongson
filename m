Received:  by oss.sgi.com id <S553768AbRCECBf>;
	Sun, 4 Mar 2001 18:01:35 -0800
Received: from short.adgrafix.com ([63.79.128.2]:4042 "EHLO short.adgrafix.com")
	by oss.sgi.com with ESMTP id <S553702AbRCECBU>;
	Sun, 4 Mar 2001 18:01:20 -0800
Received: from ppan2 (c534317-a.stcla1.sfba.home.com [24.20.134.153])
	by short.adgrafix.com (8.9.3/8.9.3) with SMTP id VAA20699;
	Sun, 4 Mar 2001 21:03:36 -0500 (EST)
From:   "Mike Klar" <mfklar@ponymail.com>
To:     <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Subject: FPU context clobbered by signals
Date:   Sun, 4 Mar 2001 17:56:38 -0800
Message-ID: <NDBBIDGAOKMNJNDAHDDMEEHOCOAA.mfklar@ponymail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Back in September, Atsushi Nemoto reported a problem with the way signal
handling was handling FPU contexts in the 2.2 kernel.  I think I'm seeing
the same thing in the 2.4 kernel.  The behavior I observe is that a user
process that is using floating point registers sees those registers get
whacked when another process gets a signal.  Just executing an arbitrary
command from a bash shell (while running floating point test app in the
background) is enough to demonstrate this.

Looking at setup_sigcontext() and restore_sigcontext() in
arch/mips/kernel/signal.c, the handling of FPU context certainly looks
wrong.  If nothing else, setting current->used_math to 0 will cause FPU
context to be reinitialized the next time that process reacquires the FPU
context.  I was going to fix this, but I really can't figure out what this
code is trying to do.

Currently setup_sigcontext() appears to behave as follows:
If the current process owns the FPU context, sc_ownedfp is set to 1 in the
sigcontext passed to the signal handler, and the floating point registers
are saved in that sigcontext.  This makes sense.
If the current process does not own the FPU context, but did at one point
execute FPU operations (which all glibc apps will do for initialization),
sc_ownedfp in the sigcontext is set to 0, and the floating point registers
are still saved.  This is, at the very least, a security hole, since those
registers belong to a different process at that point.

And restore_sigcontext() appears to behave thusly:
If sc_ownedfp is set in the sigcontext that is passed back from the signal
handler, the FPU context is restored from the sigcontext, and FPU context
ownership is given to the current process, without saving the old context.
Either I'm misunderstanding this, or there is a possibility that this will
simply forget about some other process' FPU context.

So what _is_ the desired behavior here?  The current behavior (again, unless
I'm misunderstanding something) gives the signal handler access to some
other process' FPU context in the case that the signaled process did not own
the FPU.  Should it:
1) Only pass the floating point registers in sigcontext if the signaled
process owned the FPU.  or
2) Always pass the signaled process' floating point registers if it had ever
used FPU operations.  This would require getting those registers from the
context saved on the stack instead of the current FP registers if the
current process does not own the FPU.

I guess what I'm trying to figure out here is the significance of sc_ownedfp
in struct sigcontext.  Option 1 would have it mean whether or not the
floating point register values in sigcontext are meaningful, but this seems
wrong.  The signal handler may want to know what the process' floating point
registers were at the time of the signal, unconditionally of whether it
owned the FPU context at the time.  Option 2 would have it mean... ummm...
I'm not sure.  I'm not sure why the signal handler would really care about
whether or not this process owned the FPU or some other process did, as long
as the floating point registers saved in sigcontext belong to the signaled
process.  It also doesn't seem all that useful to have the signal handler be
able to change the FPU ownership by changing the value of sc_ownedfp.

Mike Klar
