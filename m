Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 10:06:20 +0000 (GMT)
Received: from mail.baslerweb.com ([IPv6:::ffff:145.253.187.130]:60380 "EHLO
	mail.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225251AbUK2KGN>; Mon, 29 Nov 2004 10:06:13 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id iATA3HdJ025137
	for <linux-mips@linux-mips.org>; Mon, 29 Nov 2004 11:03:17 +0100
Received: from unknown by gateway id /var/KryptoWall/smtpp/kw42EI5G; Mon Nov 29 11:02:51 2004
Received: from [172.16.13.253] (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id XSRQDBHL; Mon, 29 Nov 2004 11:05:44 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Ralf Baechle <ralf@linux-mips.org>
Subject: titan_ge etherent driver
Date: Mon, 29 Nov 2004 11:05:43 +0100
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org, Manish Lachwani <mlachwani@mvista.com>
MIME-Version: 1.0
Message-Id: <200411291105.43441.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

since I noticed that you are working on the titan_ge driver,
I think it is time to let you know that I am currently
reworking that driver in the context of a new platform port.
The primary goal is to cleanly separate the  titan_ge driver
from the yosemite platform and to make it usable with other
RM9000-based platforms as well.

The work is rather advanced, I did implement all the necessary
changes and am now debugging through the thing to make it
work. During the process I found quite a number of issues with
the old driver that I fixed along the way.

The main points addressed by my work are these:

- Do no longer monopolize the message interrupt, so the titan_ge
  can coexist with other drivers for OCDs.

- Do not refuse to initialize if the link is down. This
  would prevent a statically linked kernel from booting if
  no network cord was attached :-(

- Properly allocate and deallocate any resources used.

- Introduce a mapping layer, so that the driver can be told to
  use any ethernet slice for any port number, and even leave
  alone slices so they can be used for different purposes (GPI).

- Introduce a general OCD access framework that is designed to be
  useful for new platform ports.

I will submit my work work for review once it is completed (since
I am working on it full time, that should not take too long). Until
then, I'd like to avoid unnecessary duplication of work, so I am
announcing this.

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
