Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B93bRw022477
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 02:03:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B93bsU022476
	for linux-mips-outgoing; Thu, 11 Jul 2002 02:03:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B93VRw022465
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 02:03:31 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B97vXb011255
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 02:07:57 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA05099
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 02:07:56 -0700 (PDT)
Message-ID: <00b401c228ba$88b29bf0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <linux-mips@oss.sgi.com>
Subject: Sigcontext->sc_pc Passed to User
Date: Thu, 11 Jul 2002 11:08:21 +0200
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

In responding to an enquiry from one of MIPS' third-party
software vendors, I noted something that seems a little
broken to me in the current (and maybe all historical)
MIPS/Linux kernels.  Please forgive me for opening
old wounds if this has been beaten to death in the past.

When a user catches a signal, such as SIGBUS, the
signal "payload" includes a pointer to a sigcontext
structure on the stack, containing the state of the
CPU when the exception associated with the signal
occurred.  But not exactly.  We seem to consistently
call compute_return_epc() before send_sig() or
force_sig().  This results in the user being passed
an indication of the faulting PC that is one instruction
past the true location.  That would be no problem,
except that the faulting instruction may have been 
in a branch delay slot, such that there is no practical
and reliable way for the signal handler to determine
which instruction failed on the basis of the sigcontext
data.

It is, of course, important that execution resume
at the instruction following any instruction generating
an exception/signal.  But that's not the same thing
as saying that the sigcontext should report the resumption
EPC instead of the faulting EPC.  There are various
ways of dealing with this, but before going into any
of them, I'm curious as to whether this has been 
discussed before, and whether anyone thinks that 
things really should be the way they are.

            Regards,

            Kevin K.
