Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 02:11:31 +0000 (GMT)
Received: from law10-f96.law10.hotmail.com ([IPv6:::ffff:64.4.15.96]:51214
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225074AbUBBCLb>; Mon, 2 Feb 2004 02:11:31 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 1 Feb 2004 18:11:23 -0800
Received: from 24.209.41.112 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 02 Feb 2004 02:11:22 GMT
X-Originating-IP: [24.209.41.112]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: linux-mips@linux-mips.org
Subject: mipsel-linux-objcopy problem
Date: Mon, 02 Feb 2004 02:11:22 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F967gzKHmdpVn0001d29b@hotmail.com>
X-OriginalArrivalTime: 02 Feb 2004 02:11:23.0007 (UTC) FILETIME=[DACD68F0:01C3E931]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi folks

On one system, I've got

# mipsel-linux-objcopy --version
GNU objcopy 2.8.1
Copyright 1997 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.

# ls -l memload-full
-rwxr-xr-x    1 root     root      1791550 Feb  1 20:46 memload-full

# mipsel-linux-objcopy -Obinary --remove-section=.bss --remove-section=.data 
--remove-section=.mdebug --pad-to=0x9fe00000 memload-full tryrom

[root@mjolnir hfload]# ls -l tryrom
-rwxr-xr-x    1 root     root      2097152 Feb  1 21:09 tryrom

on another system,

# mipsel-unknown-linux-gnu-objcopy --version
GNU objcopy 2.13.90.0.18 20030121
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.

# ls -l memload-full
-rwxr-xr-x    1 root     root      1791550 Feb  1 20:35 memload-full

mipsel-unknown-linux-gnu-objcopy -Obinary --remove-section=.bss 
--remove-section=.data --remove-section=.mdebug --pad-to=0x9fe00000 
memload-full tryrom

# ls -l tryrom
-rwxr-xr-x    1 root     root      1725680 Feb  1 21:01 tryrom

Any idea why tryrom made with mipsel-unknown-linux-gnu-objcopy ver 
2.13.90.0.18 is smaller than the one made with mipsel-linux-objcopy ver 
2.8.1

This is a step in making a rom image for an emulator.  The emulator needs 
the file tryrom to be  2097152.  I'm stuck.

Help.

Mark

_________________________________________________________________
Learn how to choose, serve, and enjoy wine at Wine @ MSN. 
http://wine.msn.com/
