Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g65NjtRw014327
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 5 Jul 2002 16:45:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g65Njtm4014326
	for linux-mips-outgoing; Fri, 5 Jul 2002 16:45:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g65NjnRw014316
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 16:45:49 -0700
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05061
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 16:49:50 -0700 (PDT)
	mail_from (brad@ltc.com)
Received: from [192.168.0.76] (helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 17QccH-0004ii-01; Fri, 05 Jul 2002 19:35:57 -0400
Message-ID: <006401c2247d$3356e580$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <sseeger@stellartec.com>
Cc: <linux-mips@oss.sgi.com>
References: <01c501c2243f$2951c700$3501a8c0@wssseeger>
Subject: Re: sys_execve problem
Date: Fri, 5 Jul 2002 19:39:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Spam-Status: No, hits=1.3 required=5.0 tests=MAY_BE_FORGED version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Is your init static?  Does it need ld.so?  Is ld.so executable (that's a
tricky one).

Regards,
Brad

----- Original Message -----
From: "Steven Seeger" <sseeger@stellartec.com>
To: <linux-mips@oss.sgi.com>
Sent: Friday, July 05, 2002 12:15 PM
Subject: sys_execve problem


> Hey guys. I have compiled 2.4.19-ac1 from the CVS with the linux_2_4 tag
for
> my NEC Osprey board (NEC VR4181) It boots fine and stuff, but doesn't load
> init. I've confirmed with simple print statements that do_execve is
> returning a 0 at the point in fs/exec.c where it says "/* execve success
*/"
> and yet init doesn't load. The system just sits there. I see on a scope
that
> my timer interrupt is firing every 10 ms and the serial console responds
> properly. It echos characters and stops the echo when it receives a ctrl-S
> and resumes it on ctrl-Q. Obviously this is the last little part of the
> kernel to work though here. Any ideas?
>
> Steve
