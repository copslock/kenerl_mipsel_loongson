Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2004 05:01:27 +0000 (GMT)
Received: from dsl-KK-049.206.95.61.touchtelindia.net ([IPv6:::ffff:61.95.206.49]:33719
	"EHLO trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224900AbUL2FBW>; Wed, 29 Dec 2004 05:01:22 +0000
Received: from procsys.com ([192.168.1.128])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id iBT4mvXb012270
	for <linux-mips@linux-mips.org>; Wed, 29 Dec 2004 10:19:08 +0530
Message-ID: <41D23806.BC19A3C9@procsys.com>
Date: Wed, 29 Dec 2004 10:22:22 +0530
From: priya <priya@procsys.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Problem when the CPU cache is turned on
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <priya@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,
Iam trying to bring up a custom board
with RM5231A MIPS processor and IT8172
companion chip. Right now i have an
issue related to running Linux 2.4.25 on
MIPS with cache enabled.

When i run the kernel with CPU Cache
enabled, i get the following error
messages.
A. "Unhandled kernel unaligned access or
invalid instruction in
unaligned.c::emulate_load_store_insn,
line 493:"
B. "Reserved instruction in kernel code
in traps.c::do_ri, line 663:"
C. "Unable to handle kernel paging
request at virtual address 00000000

These errors happen when i run fsck, vi
or a simple du command.

When i trun on the "Run uncached"
option  these errors disapper.

I do not know where to start debugging.
Can any one tell me what could be the
problem when the cache is turned on.

regards
priya
