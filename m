Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6C7tiRw016147
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 00:55:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6C7tiG3016146
	for linux-mips-outgoing; Fri, 12 Jul 2002 00:55:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6C7tYRw016123;
	Fri, 12 Jul 2002 00:55:34 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6C803Xb015492;
	Fri, 12 Jul 2002 01:00:03 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA25730;
	Fri, 12 Jul 2002 01:00:03 -0700 (PDT)
Message-ID: <003301c2297a$380ed400$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <00b401c228ba$88b29bf0$10eca8c0@grendel> <20020712034015.C16608@dea.linux-mips.net>
Subject: Re: Sigcontext->sc_pc Passed to User
Date: Fri, 12 Jul 2002 10:00:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Ralf Baechle" <ralf@oss.sgi.com>
> On Thu, Jul 11, 2002 at 11:08:21AM +0200, Kevin D. Kissell wrote:
[snip]
> > When a user catches a signal, such as SIGBUS, the
> > signal "payload" includes a pointer to a sigcontext
> > structure on the stack, containing the state of the
> > CPU when the exception associated with the signal
> > occurred.  But not exactly.  We seem to consistently
> > call compute_return_epc() before send_sig() or
> > force_sig().  This results in the user being passed
> > an indication of the faulting PC that is one instruction
> > past the true location.  That would be no problem,
> > except that the faulting instruction may have been 
> > in a branch delay slot, such that there is no practical
> > and reliable way for the signal handler to determine
> > which instruction failed on the basis of the sigcontext
> > data.
> > 
> > It is, of course, important that execution resume
> > at the instruction following any instruction generating
> > an exception/signal.  But that's not the same thing
> > as saying that the sigcontext should report the resumption
> > EPC instead of the faulting EPC.  There are various
> > ways of dealing with this, but before going into any
> > of them, I'm curious as to whether this has been 
> > discussed before, and whether anyone thinks that 
> > things really should be the way they are.
> 
> Our signal stackframe is almost the same as on IRIX5 which is what
> some software expects.  Maybe time to checkout what IRIX does ...

The IRIX team made some stunningly bad design 
decisions over the years, my favorite being "virtual
swap space" and its side effect of deliberately killing 
system daemons at random under load.  A signal scheme
such as we have now in MIPS/Linux, where a user program
*cannot* identify the instruction causing a signal if
that instruction was in the delay slot of a taken branch,
is broken from first principles.

            Kevin K.
