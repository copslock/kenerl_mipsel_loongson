Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FMDXnC012744
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 15:13:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FMDXbW012743
	for linux-mips-outgoing; Sat, 15 Jun 2002 15:13:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FMDTnC012740
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 15:13:30 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b816701638947197216d@nwd2mime2.analog.com>;
 Sat, 15 Jun 2002 18:17:15 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb1.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id SAA11501; Sat, 15 Jun 2002 18:16:06 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id PAA27663;
	Sat, 15 Jun 2002 15:16:05 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id PAA27809;
	Sat, 15 Jun 2002 15:16:05 -0700 (PDT)
Message-ID: <3D0BBCA5.5A0D722A@analog.com>
Date: Sat, 15 Jun 2002 15:16:05 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
References: <3D0B9D14.BFE27F7E@analog.com> <20020615151413.A19123@crack.them.org> <3D0BA3C4.79ED2B5D@analog.com> <20020615153831.B19123@crack.them.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> 
> Software breakpoints have worked at least as far back as 2.4.2.  This
> most likely means that the exception handling for your board is broken.
> 

Sorry, originally misinterpretted your use of "board" as referring to
the board itself, and perhaps PMON (I've found a number of references
online to GDB talking to PMON, but not much else). 

So what I've found by looking at other board-specific code revolves
around GDB talking to an in-kernel stub via the serial port. As the
board I'm working with has an unreliable serial port (and some
incarnations don't even have that), what about ethernet-based
debugging? Is that do-able, say via putDebugChar() (although I suspect
this poses an initialization problem)? 

Thanks for the info so far. 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
