Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FKgcnC009910
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 13:42:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FKgcK3009909
	for linux-mips-outgoing; Sat, 15 Jun 2002 13:42:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FKgZnC009905
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 13:42:35 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b8113b7cb8947197216d@nwd2mime2.analog.com>;
 Sat, 15 Jun 2002 16:46:17 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb2.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id QAA10862; Sat, 15 Jun 2002 16:45:09 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id NAA26121;
	Sat, 15 Jun 2002 13:45:08 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id NAA27611;
	Sat, 15 Jun 2002 13:45:07 -0700 (PDT)
Message-ID: <3D0BA753.B0A51BCC@analog.com>
Date: Sat, 15 Jun 2002 13:45:07 -0700
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
> --
> Daniel Jacobowitz                           Debian GNU/Linux Developer
> MontaVista Software                         Carnegie Mellon University

What exception handling is the board expected to provide? 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
