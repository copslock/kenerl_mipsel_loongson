Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FKRQnC009575
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 13:27:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FKRQcS009574
	for linux-mips-outgoing; Sat, 15 Jun 2002 13:27:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FKRInC009570
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 13:27:21 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b8105cb388947197216d@nwd2mime2.analog.com>;
 Sat, 15 Jun 2002 16:31:04 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb2.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id QAA10191; Sat, 15 Jun 2002 16:29:57 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id NAA25815;
	Sat, 15 Jun 2002 13:29:56 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id NAA27579;
	Sat, 15 Jun 2002 13:29:56 -0700 (PDT)
Message-ID: <3D0BA3C4.79ED2B5D@analog.com>
Date: Sat, 15 Jun 2002 13:29:56 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
References: <3D0B9D14.BFE27F7E@analog.com> <20020615151413.A19123@crack.them.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> 
> On Sat, Jun 15, 2002 at 01:01:24PM -0700, Justin Wojdacki wrote:
> >
> > How does GDB work under MIPS Linux? I'm trying to do a bring-up of an
> > embedded device, and it looks like the kernel is missing the code
> > needed to handle software breakpoints. Are there patches that need to
> > be applied to the kernel?
> 
> No.  If you use a current GDB (I recommend 5.2 or CVS) it should work
> just fine, if you are using a recent kernel (you didn't mention what
> version you were looking at).
> 
> --
> Daniel Jacobowitz                           Debian GNU/Linux Developer
> MontaVista Software                         Carnegie Mellon University

Sorry, I'm using the 2.4.10 kernel and GDB 5.2. What I see happening
is the BREAK 5 instruction from a software breakpoint is hit, and the
kernel loops continuously on that, as it appears to have no way to
deal with that exception. I'm running gdbserver on the MIPS target and
gdb as a cross-debugger on an x86 host (RedHat 7.1). To me, it looks
like when the debugging breakpoint is hit, gdbserver should get
scheduled to run and handle the breakpoint, but instead the child
keep's getting scheduled. 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
