Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FLYlnC002070
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 14:34:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FLYlU6002069
	for linux-mips-outgoing; Wed, 15 May 2002 14:34:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from host099.momenco.com (IDENT:root@jeeves.momenco.com [64.169.228.99])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FLYdnC002066
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 14:34:44 -0700
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g4FLYm325834
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 14:34:58 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: MIPS 64?
Date: Wed, 15 May 2002 14:34:47 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
That kinda blows the 32-bit MIPS port option right out of the water...

What does it take to do a 64-bit port?  The first problem I see is the
boot loader -- do I have to be in 64-bit mode when the kernel starts,
or can I start in 32-bit mode and then transfer to 64-bit mode?

I looked in the arch/mips64/ directory, but I don't see much for
specific boards there, but there are references to the Malta
boards....

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
