Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2005 21:38:01 +0100 (BST)
Received: from sccrmhc14.comcast.net ([IPv6:::ffff:204.127.202.59]:2016 "EHLO
	sccrmhc14.comcast.net") by linux-mips.org with ESMTP
	id <S8225534AbVGYUhn>; Mon, 25 Jul 2005 21:37:43 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (sccrmhc14) with SMTP
          id <2005072520400001400k7lr1e>; Mon, 25 Jul 2005 20:40:00 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Maxim Osipov'" <maxim.osipov@gmail.com>
Cc:	<linux-mips@linux-mips.org>
Subject: re: Fwd: mips64 gdb problem
Date:	Mon, 25 Jul 2005 16:39:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWRWQRmktoYciWyTb6SVMJu7q0Pug==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20050725203743Z8225534-3678+4331@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

I'm butting heads with this problem also.  I get the error below when
running mips64-unknown-linux-gdb on a 64 bit mips binary.  Has anyone come
up with a work around?

Thanks,
Bryan

>Hello,
>I wonder, is there some way to get debuger working on N64 target?
>Thanks,
>Maxim

>>On Fri, Jun 24, 2005 at 05:42:25PM +0400, Maxim Osipov wrote:
>> Hello,
>>
>> I have a problem trying to debug 64-bit mips binary with gdb-6.3. It
>> fails with the following message:
>>
>> /home # gdb 64test
>> GNU gdb 6.3
>> Copyright 2004 Free Software Foundation, Inc.
>> GDB is free software, covered by the GNU General Public License, and you
are
>> welcome to change it and/or distribute copies of it under certain
conditions.
>> Type "show copying" to see the conditions.
>> There is absolutely no warranty for GDB.  Type "show warranty" for
details.
>> This GDB was configured as "mips64-linux-gnu"...
>> ../../gdb-6.3/gdb/dwarf2-frame.c:1411: internal-error:
>> decode_frame_entry_1: Assertion `fde->cie != NULL' failed.
