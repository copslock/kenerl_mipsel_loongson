Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g02IcDq17408
	for linux-mips-outgoing; Wed, 2 Jan 2002 10:38:13 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g02IcAg17403
	for <linux-mips@oss.sgi.com>; Wed, 2 Jan 2002 10:38:10 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <ZNHALPYX>; Wed, 2 Jan 2002 11:37:51 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B74D9@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: general linux question
Date: Wed, 2 Jan 2002 11:36:27 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This isn't mips-specific, so maybe belongs on another list, but I figured
someone here could probably answer just as quickly. I need to track versions
of all files in the system (embedded, flash-based, no disk media), but
cannot find a structure member where a version number can be stored in a
file header. Most linux command line apps generally have a -version command
line option, but is not viable for our application. Have I missed something?
Is there a standard Linux method/practice for version number tracking and
retrieval that is separate from CVS and the -version command switch, or do I
have to use something proprietary? Or should I just try to use the file
creation timestamp?

Keith Siders
Software Engineer
 Toshiba America Consumer Products, Inc.
Advanced Television Technology Center
801 Royal Parkway, Suite 100
Nashville, Tennessee 37214
Phone: (615) 257-4050
Fax:   (615) 453-7880
