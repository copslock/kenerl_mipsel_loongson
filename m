Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2010 09:43:34 +0200 (CEST)
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:36397 "EHLO
        qmta08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491920Ab0GIHna (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jul 2010 09:43:30 +0200
Received: from omta19.emeryville.ca.mail.comcast.net ([76.96.30.76])
        by qmta08.emeryville.ca.mail.comcast.net with comcast
        id fjiy1e0061eYJf8A8jjNh5; Fri, 09 Jul 2010 07:43:22 +0000
Received: from [10.0.0.109] ([98.248.135.54])
        by omta19.emeryville.ca.mail.comcast.net with comcast
        id fjjM1e0031AbZWA01jjMNd; Fri, 09 Jul 2010 07:43:22 +0000
Message-ID: <4C36D31A.5000500@notav8.com>
Date:   Fri, 09 Jul 2010 00:43:22 -0700
From:   Chris Rhodin <chris@notav8.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: IP22 Debian Install
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chris@notav8.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@notav8.com
Precedence: bulk
X-list: linux-mips

Hi,

How much memory is required to install Debian (3.1 and 5) on an 
Indigo2?  I have 128MB and get this when I attempt to install:

tip22: IP22 Linux tftpboot loader 0.3.8.6
Loading program segment 2 at 0x88002000, size = 0x218000
Zeroing memory at 0x8821a000, size = 0x365b0
Starting kernel; entry point = 0x881e0040
Copied initrd from 0x88aab190 to 0x88251000 (0x1d5ce2 bytes)

Exception: <vector=Normal>
Status register: 0x30044803<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x30008010<CE=3,IP8,EXC=RADE>
Exception PC: 0x88124c74, Exception RA: 0x881f61b0
Read address error exception, bad address: 0x2a
Local I/O interrupt register 1: 0x80 <VR/GIO2>
Local I/O interrupt register 2: 0xc8 <EISA,SLOT0,SLOT1>
  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
  arg: a8740000 881dffe0 882505ac 88000000
  tmp: a8740000 2 887fe378 887fe4cc 0 8 887fe7d4 881e0040
  sve: a8740000 3 400000 8000000 16 3f80 0 c000000
  t8 a8740000 t9 fffff7ff at bfefff7f v0 ffbff5ef v1 fff71fbf k1 500
  gp a8740000 fp fefbfeff sp fffdffff ra feeffff7

PANIC: Unexpected exception

It looks like the kernel is loading at 0x88002000 which is more than 
128MB away from the beginning of kseg0.

Thanks,


Chris Rhodin
