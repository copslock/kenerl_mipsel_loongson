Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g02JMvP19031
	for linux-mips-outgoing; Wed, 2 Jan 2002 11:22:57 -0800
Received: from server3.toshibatv.com (mail.toshibatv.com [67.32.37.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g02JMqg19028
	for <linux-mips@oss.sgi.com>; Wed, 2 Jan 2002 11:22:53 -0800
Received: by SERVER3 with Internet Mail Service (5.5.2653.19)
	id <ZNHALPZ6>; Wed, 2 Jan 2002 12:22:36 -0600
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA1B74DB@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'Bradley D. LaRonde'" <brad@ltc.com>,
   "Linux-Mips (E-mail)"
	 <linux-mips@oss.sgi.com>
Subject: RE: general linux question
Date: Wed, 2 Jan 2002 12:21:10 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Brad,

Thanks for the quick reply...

Well, rcs looks like a source control system, which _would_ allow me to
create revision history files, but I was hoping that a file carried its
version number in a file header, like the superblock structure, for quick
access without having to create more files. This is a flash memory system,
so storage constraints and access performance reign supreme. Not to mention
that I'd have to include rcs as part of the distribution, taking up more
memory in the flash file system.

Keith

-> -----Original Message-----
-> From: Bradley D. LaRonde [mailto:brad@ltc.com]
-> Sent: Wednesday, January 02, 2002 11:52 AM
-> To: Siders, Keith; Linux-Mips (E-mail)
-> Subject: Re: general linux question
-> 
-> 
-> ----- Original Message ----- 
-> From: "Siders, Keith" <keith_siders@toshibatv.com>
-> To: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
-> Sent: Wednesday, January 02, 2002 12:36 PM
-> Subject: general linux question
-> 
-> 
-> > I need to track versions
-> > of all files in the system (embedded, flash-based, no disk media)
-> 
-> Maybe use rcs?
-> 
-> Regards,
-> Brad
-> 
