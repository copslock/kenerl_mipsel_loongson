Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 02:49:06 +0000 (GMT)
Received: from p508B5CF9.dip.t-dialin.net ([IPv6:::ffff:80.139.92.249]:13768
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225426AbTLMCtF>; Sat, 13 Dec 2003 02:49:05 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBD2mxoK025548;
	Sat, 13 Dec 2003 03:48:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBD2mxOW025547;
	Sat, 13 Dec 2003 03:48:59 +0100
Date: Sat, 13 Dec 2003 03:48:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: durai <durai@isofttech.com>
Cc: mips <linux-mips@linux-mips.org>
Subject: Re: Network problem in mips
Message-ID: <20031213024859.GA22208@linux-mips.org>
References: <008f01c3bff7$252e3b40$0a05a8c0@DURAI> <3FD88C4D.6010700@realitydiluted.com> <001d01c3c083$be226600$0a05a8c0@DURAI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c3c083$be226600$0a05a8c0@DURAI>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 12, 2003 at 01:14:14PM +0530, durai wrote:

> Kernel unaligned instruction access in unaligned.c:do_ade, line 428:
> $0 : 00000000 a0000000 00097fff ffffffff 80fa228c ba000000 a0f40000 00000000
> $8 : 00000045 00000001 00ff0000 00ff0000 80fa228c 80f90738 00003b00 80fdd812
> $16: 80fa2000 80fe8221 80fe6010 00008da9 ff000000 00ff0000 80fa2000 a0f40000
> $24: 00000001 80494970                   8043a000 8043a118 80fa228c 80f930c1
                                           ^^^^^^^^^^^^^^^^^

$28 is the current pointer, $29 the stack pointer.

> epc  : 80f930c1
> Status: 3000fc00
> Cause : 00000010
> Process   (pid: -2142680720, stackpage=8043a000)

You've overflowed the stack to the point where the process structure got
overwritten. which also explains the nonsense pid value.  -2142680720 is
0x80494970 which is probably some valid kernel address.

Find what's consuming so much stack - you should only use a split fraction
of that.  The epc value also looks quite strange because it's lowest bit is
set - does your CPU support MIPS16?

  Ralf
