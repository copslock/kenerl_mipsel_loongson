Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FMbdnC014187
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 15:37:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FMbdiv014186
	for linux-mips-outgoing; Sat, 15 Jun 2002 15:37:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FMbXnC014183
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 15:37:34 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b817d02a18947197216d@nwd2mime2.analog.com>;
 Sat, 15 Jun 2002 18:41:17 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb2.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id SAA15663; Sat, 15 Jun 2002 18:40:09 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id PAA28149;
	Sat, 15 Jun 2002 15:40:08 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id PAA27867;
	Sat, 15 Jun 2002 15:40:08 -0700 (PDT)
Message-ID: <3D0BC248.16CB7EC2@analog.com>
Date: Sat, 15 Jun 2002 15:40:08 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
References: <3D0B9D14.BFE27F7E@analog.com> <20020615151413.A19123@crack.them.org> <3D0BA3C4.79ED2B5D@analog.com> <20020615153831.B19123@crack.them.org> <3D0BBCA5.5A0D722A@analog.com> <20020615172645.A19472@crack.them.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
>
> Wait, wait.  What are you trying to do?  Originally you were talking
> about userspace debugging via gdbserver.  Now you're talking about
> kernel debugging via kgdb.  They're separate (and coexisting can cause
> problems if you are not careful with your exception handlers; I do not
> remember when my patches to make that work went into the tree, or if
> someone else did it).
> 
> gdbserver can just use TCP.
> 
> --
> Daniel Jacobowitz                           Debian GNU/Linux Developer
> MontaVista Software                         Carnegie Mellon University

Sorry for the confusion. I've been discussing userspace debugging via
gdbserver the entire time. However, I've noticed that gdbserver
doesn't seem to be fully functional because the kernel doesn't seem to
be handling the "BREAK 5" instruction correctly. You mentioned
problems with board exception handling and I looked at the ddb series
board support code. In there, I found handling for software
breakpoints, and got the impression from the code that it was a
general debugging interface, not just for kernel debugging. Again,
sorry for the confusion.

As it stands right now, when I get hit a "BREAK 5" instruction,
gdbserver never get's a chance to handle it, as the kernel keeps
scheduling the child process I'm trying to debug, and hitting the
"BREAK 5" instruction over and over again. What I can't seem to find
out is how gdbserver is supposed to get scheduled again. 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
