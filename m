Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5LLqknC030069
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 21 Jun 2002 14:52:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5LLqkSI030068
	for linux-mips-outgoing; Fri, 21 Jun 2002 14:52:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail2.camcare.com ([206.193.125.77])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5LLqgnC030065
	for <linux-mips@oss.sgi.com>; Fri, 21 Jun 2002 14:52:42 -0700
Received: from KES.camcare.com (IS~KES [10.10.95.4]) by mail2.camcare.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2650.21)
	id NAXGJ8WD; Fri, 21 Jun 2002 18:07:33 -0400
Received: by KES.camcare.com with Internet Mail Service (5.5.2650.21)
	id <HXGSH41Z>; Fri, 21 Jun 2002 17:55:34 -0400
Message-ID: <490E0430C3C72046ACF7F18B7CD76A2A568B9E@KES.camcare.com>
From: "Smith, Todd" <Todd.Smith@camc.org>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: DECstation
Date: Fri, 21 Jun 2002 17:55:33 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thank you for your information.  I was unsure since the website that I was
reading for information was very much out of date.

Keep up the good work!

Todd Smith

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]

 The system should be fine -- basically all I/O ASIC based systems should
work, though not all devices have been supplied with drivers yet. 

 You should be able to use X11 with an XF86_FBDev Xserver on a PMAG-B (CX) 
or a PMAGB-B (HX) display adapter (I wasn't able to try myself so far
though).  For other display adapters, the answer is either "not yet" or
"no way". 
