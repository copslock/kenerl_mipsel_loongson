Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1N1N0J28431
	for linux-mips-outgoing; Fri, 22 Feb 2002 17:23:00 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1N1Mw928427
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 17:22:58 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1N0MvR04915
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 16:22:57 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Anyone have the e1000.o driver working?
Date: Fri, 22 Feb 2002 16:22:57 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIMELICFAA.mdharm@momenco.com>
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

Does anyone here have the e1000.o driver from Intel for their gigabit
ethernet devices working on a MIPS?

After overcoming the intitial CFLAGS problem, the darned thing just
seems to keep crashing on me during initialization.  I'm looking for a
datapoint to suggest that it's either (a) a problem with my linux
port, or (b) a problem with their driver.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
