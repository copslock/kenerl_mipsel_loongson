Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 16:13:30 +0200 (CEST)
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:57783 "EHLO
	fw-cam.cambridge.arm.com") by linux-mips.org with ESMTP
	id <S1122961AbSIMON3>; Fri, 13 Sep 2002 16:13:29 +0200
Received: by fw-cam.cambridge.arm.com; id PAA05832; Fri, 13 Sep 2002 15:13:07 +0100 (BST)
Received: from unknown(172.16.9.107) by fw-cam.cambridge.arm.com via smap (V5.5)
	id xma005380; Fri, 13 Sep 02 15:12:28 +0100
Date: Fri, 13 Sep 2002 15:12:36 +0100
From: Gareth <g.c.bransby-99@student.lboro.ac.uk>
To: linux-mips@linux-mips.org
Subject: Instruction tracing
Message-Id: <20020913151236.45429b74.g.c.bransby-99@student.lboro.ac.uk>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <g.c.bransby-99@student.lboro.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: g.c.bransby-99@student.lboro.ac.uk
Precedence: bulk
X-list: linux-mips

Hello,

I am trying to debug a program running on a mips malta dev board (no operating
system). I am using gdb running on a linux pc connected to the board via
serial and the board is running YAMON gdb. I can step through the code, set
break points, examine memory and variables etc, but what I would really like 
to do is get an instruction trace of the program. 

Any help greatly appreciated.
Gareth
