Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g47M6rwJ009825
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 15:06:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g47M6rrr009824
	for linux-mips-outgoing; Tue, 7 May 2002 15:06:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g47M6owJ009821
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 15:06:50 -0700
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01895
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 15:08:04 -0700 (PDT)
	mail_from (keith_siders@toshibatv.com)
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <26NPQG85>; Tue, 7 May 2002 17:06:35 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA379AA1@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Debugging of embedded target applications
Date: Tue, 7 May 2002 17:05:36 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am using x86 Linux for host development to a MIPS Linux embedded target. I
finally have a hardware debugger for my target board that works, but I have
to get large application files downloaded in a timely fashion. The debugger
must download to the target via JTAG, therefore downloads have lots of bits
of overhead, i.e. downloads are slow. Is there anything like a gdb server
that can I run on the target to connect to a remote client via ethernet? I
don't really want to have to compile a complete gdb tool to run on my target
board to do this. I don't have the luxury of a lot of memory on this board,
and no swap space (flash-based system, no hdd). The real catch is I would
like to be able to resolve the symbols of the application so the debugger
can be used to set hardware breakpoints, and provide source-level debugging
of the application. Or am I going about this totally bassackwards?

Keith
