Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g27IVgR12221
	for linux-mips-outgoing; Thu, 7 Mar 2002 10:31:42 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g27IVd912218
	for <linux-mips@oss.sgi.com>; Thu, 7 Mar 2002 10:31:40 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <FQRY6LW1>; Thu, 7 Mar 2002 11:31:28 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B75EB@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: lockup
Date: Thu, 7 Mar 2002 11:29:14 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have a userland application which runs at fairly high priority. If I run
the application from either a terminal or telnet shell I can successfully
kill it with ctrl-c. However, if I simply close the shell window (terminal
or telnet) by clicking X button, the entire system locks up. If I go to
another system and telnet into the locked box, I get that telnet is
connected but no login prompt is ever displayed. Any ideas where I should
begin looking, approaches to take, things to try?? Any helpful pointers
appreciated.

Keith Siders
Toshiba America Consumer Products
Advanced Television Technology Center
