Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L2d5T04987
	for linux-mips-outgoing; Wed, 20 Feb 2002 18:39:05 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L2cx904982;
	Wed, 20 Feb 2002 18:38:59 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1L1cxR26789;
	Wed, 20 Feb 2002 17:38:59 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Adding code to the tree...
Date: Wed, 20 Feb 2002 17:38:59 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAICEKCCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

So, I'm porting Linux to our latest board... and I've got this pile of
new code, and I'm itching to check it in somewhere.  It's not perfect
yet, but the board definately starts to come up, and the Symbios
53c875 driver can probe and identify devices on the SCSI bus.... so
I'm thinking that I'm doing pretty well here.

So, if I send this code as is, will it be accepted into the tree?  Or
do I have to wait until it's completely finished before I send it?  I
can see arguments either way, so I'm guessing it really comes down to
Ralf's personal preferences...

Matt

P.S. Is there any way to get permission to make CVS commits, or should
everything be done via Ralf?  I've got another 2 designs behind this
one which will all get Linux ported to them...

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
