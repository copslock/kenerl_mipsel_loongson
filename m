Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 16:59:48 +0000 (GMT)
Received: from masquerade.micron.com ([IPv6:::ffff:137.201.242.130]:37803 "EHLO
	mail-srv1.micron.com") by linux-mips.org with ESMTP
	id <S8225205AbTB0Q7r>; Thu, 27 Feb 2003 16:59:47 +0000
Received: from mail-srv1.micron.com (localhost [127.0.0.1])
	by mail-srv1.micron.com (8.12.2/8.12.2) with ESMTP id h1RH1IhP008495
	for <linux-mips@linux-mips.org>; Thu, 27 Feb 2003 10:01:19 -0700 (MST)
Received: from ntexchangehub.micron.com (ntexchangehub.micron.com [137.201.16.84])
	by mail-srv1.micron.com (8.12.2/8.12.2) with ESMTP id h1RH1H4l008459;
	Thu, 27 Feb 2003 10:01:17 -0700 (MST)
Received: by ntexchangehub.micron.com with Internet Mail Service (5.5.2653.19)
	id <FLCLN4N5>; Thu, 27 Feb 2003 09:59:37 -0700
Message-ID: <DD4AFB45E2CCD211B6EE0008C7333BCF02FE6FDC@ntxmel01.micron.com>
From: ncrook <ncrook@micron.com>
To: "'ZhouY.external@infineon.com'" <ZhouY.external@infineon.com>,
	ncrook <ncrook@micron.com>
Cc: linux-mips@linux-mips.org
Subject: RE: MIPS Malta board Linux installation 
Date: Thu, 27 Feb 2003 09:59:32 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ncrook@micron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncrook@micron.com
Precedence: bulk
X-list: linux-mips

Hmm. The kernel is very old. (2.2). I suggest you grab something like
2.4.18 or later.. you don't need the root filesystem yet, just the kernel.
The fact that the LED display doesn't start scrolling indicates something
is going wrong quite early on.

suggestions:

- grab a mips-malta kernel version 2.4.18 or later
- try flipping your machine to Little Endian and try a little-endian
  kernel (shouldn't make any difference)

after that, time to read the source...

Neal.

-----Original Message-----
From: ZhouY.external@infineon.com [mailto:ZhouY.external@infineon.com]
Sent: 27 February 2003 16:44
To: ncrook@micron.com
Cc: linux-mips@linux-mips.org
Subject: AW: MIPS Malta board Linux installation 


I tried again. The result is same. 
The green LED display shows 'LINUX' not 'LINUX on malta'. All the status LED
are green except the LED rst is off. There are 2 kernel images(el and eb),
one of them is vmlinux-2.2.12.mips.malta.eb-01.05.srec, which is the current
one. I double checked my console and its baud rate is 38400. 
  From this symptom, what kind of conclusion can you draw?

  Best regards,

  Yidan
