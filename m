Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5LGKtnC010734
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 21 Jun 2002 09:20:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5LGKtvV010733
	for linux-mips-outgoing; Fri, 21 Jun 2002 09:20:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5LGKpnC010729
	for <linux-mips@oss.sgi.com>; Fri, 21 Jun 2002 09:20:51 -0700
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <26NPRAQL>; Fri, 21 Jun 2002 11:23:24 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA379B78@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: File permission handling
Date: Fri, 21 Jun 2002 11:22:05 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am attempting to bunzip and untar a file in an embedded system. The
application invokes a system() call to launch bzcat piped to tar. tar is
reporting the filenames, but refuses to untar complaining about permissions
violations. How do I get the files to untar successfully? Script invocation
is "bzcat -xk %s | tar xf -" and a filename is supplied to the string
argument through sprintf(). What am I doing wrong here? 

BTW, for those who would throw up security warning flags, this is an
enclosed box where I don't have much worry about security issues revolviing
around forking a shell script.

Keith Siders
Software Engineer
 Toshiba America Consumer Products, Inc.
Advanced Television Technology Center
801 Royal Parkway, Suite 100
Nashville, Tennessee 37214
Phone: (615) 257-4050
Fax:   (615) 453-7880
