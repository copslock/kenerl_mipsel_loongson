Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2003 18:00:37 +0100 (BST)
Received: from mail.securewebs.net ([IPv6:::ffff:80.190.40.19]:6929 "EHLO
	izd.de") by linux-mips.org with ESMTP id <S8225236AbTE3RAf> convert rfc822-to-8bit;
	Fri, 30 May 2003 18:00:35 +0100
Received: from so9 [80.132.168.241] by izd.de with ESMTP
  (SMTPD32-7.15) id AE2C12E0074; Fri, 30 May 2003 19:00:28 +0200
From: "Michael Weichselgartner" <mw@izd.de>
To: <linux-mips@linux-mips.org>
Subject: RaQ2+ NIC problem 2nd try
Date: Fri, 30 May 2003 19:00:28 +0200
Message-ID: <005d01c326cc$f9468c80$0300a8c0@so9>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Return-Path: <mw@izd.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mw@izd.de
Precedence: bulk
X-list: linux-mips

hello,

unfortunately i never got feedback to my problem allthough
i know many people have the same problem. So i will try it
again with additional information.

Used hardware: Cobalt RaQ2+, 256MB, Nevada CPU, Galileo Chipset
Used OS: Debian 3.0 Woody, Kernel 2.4.18/2.4.20/2.4.21

Problem: If i enable both nic´s network traffic stops after
a few minutes withour any error message.

No matter wether you use tulip as module or not. The higher
the kernel version the shorter the time until all networktraffic
stops. The server is still running and i can logon to the
serial console. Restarting networking solves the problem
until i connect with ssh, ftp or whatever and start to 
transfer data (even fast scrolling in midnight commander
kills the network traffic).

If load only one of the nic´s (tulip as module and only
one alias for modutils) everthing works great, fast and day
for day.

I spent weeks to locate the problem by reading the old
(original) source of the cobalttulip_raq driver (Kernel 2.0). 
But i am not able to see which patches have been merged into
the kernel 2.4.x because the entire format has changed.

The question is has someone fixed this bug?
Did the developers merge the cobalt specific changes?

I have seen a lot of information in the old drivers telling
the RaQ would not be DMA COHERENT and therefore needs
some cache flushing within the network driver. I cant
see such information in the current tulip driver (0.9.12 - 0.9.15).
Could this cause the freezing?

I realy do not know what else i can do. Any hints?

Your feedback is welcome.

Best regards

Michael
