Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FJwrnC009240
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 12:58:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FJwrvJ009239
	for linux-mips-outgoing; Sat, 15 Jun 2002 12:58:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nwd2mime2.analog.com (nwd2mime2.analog.com [137.71.25.114])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FJwnnC009236
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 12:58:50 -0700
Received: from nwd2gtw1 (unverified) by nwd2mime2.analog.com
 (Content Technologies SMTPRS 4.2.5) with SMTP id <T5b80ebb1d28947197216d@nwd2mime2.analog.com> for <linux-mips@oss.sgi.com>;
 Sat, 15 Jun 2002 16:02:34 -0400
Received: from golf.cpgdesign.analog.com ([137.71.139.100]) by nwd2mhb2.analog.com with ESMTP (8.9.3 (PHNE_18979)/8.7.1) id QAA09024 for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 16:01:25 -0400 (EDT)
Received: from ws4.cpgdesign.analog.com (ws4 [137.71.139.26])
	by golf.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id NAA25231
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 13:01:24 -0700 (PDT)
Received: from analog.com (localhost [127.0.0.1])
	by ws4.cpgdesign.analog.com (8.9.1/8.9.1) with ESMTP id NAA27520
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 13:01:24 -0700 (PDT)
Message-ID: <3D0B9D14.BFE27F7E@analog.com>
Date: Sat, 15 Jun 2002 13:01:24 -0700
From: Justin Wojdacki <justin.wojdacki@analog.com>
Reply-To: justin.wojdacki@analog.com
Organization: Analog Devices, Communications Processors Group
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Debugging using GDB and gdbserver 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


How does GDB work under MIPS Linux? I'm trying to do a bring-up of an
embedded device, and it looks like the kernel is missing the code
needed to handle software breakpoints. Are there patches that need to
be applied to the kernel? 

-- 
-------------------------------------------------
Justin Wojdacki        
justin.wojdacki@analog.com         (408) 350-5032
Communications Processors Group -- Analog Devices
