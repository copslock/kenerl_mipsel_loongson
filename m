Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FN35nC015961
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 16:03:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FN35J8015960
	for linux-mips-outgoing; Sat, 15 Jun 2002 16:03:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FN31nC015957
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 16:03:01 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b819458fe8947197216d@nwd2mime2.analog.com>;
 Sat, 15 Jun 2002 19:06:46 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb1.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id TAA13616; Sat, 15 Jun 2002 19:05:38 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id QAA28695;
	Sat, 15 Jun 2002 16:05:37 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id QAA27932;
	Sat, 15 Jun 2002 16:05:36 -0700 (PDT)
Message-ID: <3D0BC840.669BEE96@analog.com>
Date: Sat, 15 Jun 2002 16:05:36 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
References: <3D0B9D14.BFE27F7E@analog.com> <20020615151413.A19123@crack.them.org> <3D0BA3C4.79ED2B5D@analog.com> <20020615153831.B19123@crack.them.org> <3D0BBCA5.5A0D722A@analog.com> <20020615172645.A19472@crack.them.org> <3D0BC248.16CB7EC2@analog.com> <20020615180325.B19472@crack.them.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> 
> What should happen is that the child receives a signal (SIGTRAP) after
> the exception.  Then it is scheduled again, drops into do_signal, and
> the kernel notices that the traced bit is set and wakes the tracer.  I'd
> guess your board needs to do something different to deliver the SIGTRAP
> properly, if that isn't happening.
> 
> --
> Daniel Jacobowitz                           Debian GNU/Linux Developer
> MontaVista Software                         Carnegie Mellon University

Okay, thanks for the clarification. :)

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
