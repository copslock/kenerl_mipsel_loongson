Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2003 09:46:14 +0000 (GMT)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:16266 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225193AbTB1JqN> convert rfc822-to-8bit; Fri, 28 Feb 2003 09:46:13 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp2.infineon.com (8.12.2/8.12.2) with ESMTP id h1S9hs5N012659;
	Fri, 28 Feb 2003 10:43:54 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <FY222ZHR>; Fri, 28 Feb 2003 10:46:07 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B306@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: ncrook@micron.com
Cc: linux-mips@linux-mips.org
Subject: AW: MIPS Malta board Linux installation 
Date: Fri, 28 Feb 2003 10:46:04 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

Hi Neal,
  Thanks a lot!
  That's the problem of kernel. I downloaded the kernel of 2.4.X then the
problem is solved.
  So that shows the kernel from the MIPS Malta board CD doesn't match with
the board itself.

  Yidan

-----Ursprüngliche Nachricht-----
Von: ncrook [mailto:ncrook@micron.com]
Gesendet am: Donnerstag, 27. Februar 2003 18:00
An: Zhou Yidan (COM AC CE M external); ncrook
Cc: linux-mips@linux-mips.org
Betreff: RE: MIPS Malta board Linux installation 

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
