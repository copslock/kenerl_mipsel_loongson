Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18MieO12326
	for linux-mips-outgoing; Fri, 8 Feb 2002 14:44:40 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18MibA12322
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 14:44:37 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g18MibR26360
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 14:44:37 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: ANNOUNCE: GT-64240 project
Date: Fri, 8 Feb 2002 14:44:37 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIMEGKCFAA.mdharm@momenco.com>
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

I wanted to publically announce that I'm now working on a port of
Linux to the Momentum Computer Ocelot-G board, which uses a
Gallileo/Marvell GT-64240 host bridge.

I know that there is at least one other person who is/will be working
on a similar board.  Pooling resources will be good, especially since
this chip is a total nightmare.  There was some earlier discussion on
this list about it -- I won't rehash the details now.  Suffice to say,
I have a 16550A-compatible UART, and I'm feeling really lucky about
it. :)

If anyone has anything to contribute/share, please let me know.  Since
there are going to be at least two different boards which use this
chip and have linux support, getting together now will be good -- if
nothing else, it will eliminate the pain of trying to merge lots of
functionally-equivalent code later.

Matthew Dharm

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
