Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2003 09:03:14 +0100 (BST)
Received: from huawei.com ([IPv6:::ffff:61.144.161.2]:62234 "EHLO
	mta0.huawei.com") by linux-mips.org with ESMTP id <S8225201AbTGHIDM>;
	Tue, 8 Jul 2003 09:03:12 +0100
Received: from r19223b (mta0.huawei.com [172.17.1.62])
 by mta0.huawei.com (iPlanet Messaging Server 5.2 HotFix 0.8 (built Jul 12
 2002)) with ESMTPA id <0HHP00HRJ4YDVV@mta0.huawei.com> for
 linux-mips@linux-mips.org; Tue, 08 Jul 2003 16:01:25 +0800 (CST)
Date: Tue, 08 Jul 2003 16:00:08 +0800
From: renwei <renwei@huawei.com>
Subject: gdb/insight 5.3 buggy   in kernel module debug
To: linux-mips@linux-mips.org
Message-id: <003501c34526$f5adfcc0$6efc0b0a@huawei.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
Content-type: text/plain; charset=gb2312
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Return-Path: <renwei@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: renwei@huawei.com
Precedence: bulk
X-list: linux-mips

Is there anyone else find the same problem?


I download the gdb/insight 5.3 , want to use 
it to debug my mipsel idt334 board.
configure as --target=mipsel-linux.

when connect to the target , it always give me
some wrong addr:

new thead xxxxxx
   0xffffffff83f28040 in ??()
something like that.
and the backtrace command can't work, also.
but my gdb5.0 for mipsel is ok.


I think that's the gdb get the pc as 64bit, but my 
board's cpu is 32bit, so it can't get the correct pc ...
The kernel addr is up to 0x80000000, so it's negative.

I trace the gdb5.3 , and find the place in 
mips-tdep.c, so I just fix the read_pc , make it 
as 32bit , now it can work, and the backtrace command 
can display the call trace .

But I'm not sure if my fix is a full one ? 
Anyone have full patch please tell me ...

                                      renc
