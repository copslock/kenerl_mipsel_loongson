Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UHlWnC025661
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 10:47:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UHlW5D025660
	for linux-mips-outgoing; Thu, 30 May 2002 10:47:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UHlTnC025656
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 10:47:29 -0700
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <26NPQT26>; Thu, 30 May 2002 11:02:38 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA379B17@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: system() function
Date: Thu, 30 May 2002 11:01:30 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I was planning to use system() to invoke a shell and launch a script.
However it appears that this causes the parent process to terminate. A note
in Linux Programming Bible (Goerzen, 2000) says to never invoke a shell or
use the system() function. Having looked at fork() and exec(), these will
require obscene amounts of memory and overhead (for an embedded box). I've
also looked at vfork() and execve(), which looks like it will do what I
want. So do I do the vfork()/execve() pair, or is there a better way? And
would sigaction() handling be the way to pass progress information from the
child back to the parent process?

Keith Siders
Software Engineer
 Toshiba America Consumer Products, Inc.
Advanced Television Technology Center
801 Royal Parkway, Suite 100
Nashville, Tennessee 37214
Phone: (615) 257-4050
Fax:   (615) 453-7880
