Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 12:30:29 +0000 (GMT)
Received: from p508B6A65.dip.t-dialin.net ([IPv6:::ffff:80.139.106.101]:48420
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbUL0MaZ>; Mon, 27 Dec 2004 12:30:25 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBRCUDxm025961;
	Mon, 27 Dec 2004 13:30:13 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBRCU9Y9025960;
	Mon, 27 Dec 2004 13:30:09 +0100
Date: Mon, 27 Dec 2004 13:30:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Nori, Soma Sekhar" <nsekhar@ti.com>
Cc: linux-mips@linux-mips.org, "Iyer, Suraj" <ssiyer@ti.com>
Subject: Re: do_ri exception in Linux (MIPS 4kec)
Message-ID: <20041227123009.GB25442@linux-mips.org>
References: <F6B01C6242515443BB6E5DDD63AE935F60FFFF@dbde2k01.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F6B01C6242515443BB6E5DDD63AE935F60FFFF@dbde2k01.itg.ti.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 23, 2004 at 04:58:03PM +0530, Nori, Soma Sekhar wrote:

> We are using montavista Linux version 2.4.17, gcc version 2.95.3 running on MIPS 4kec.
> 
> Here is the dump:
> $0 : 00000000 0044def4 000001ac 0000006b 00000000 7fff7c08 00000001 00000000
> $8 : 0000fc00 00000001 00000000 941524d0 00004700 00000000 97fc3ea0 7fff7c08
> $16: 100048a4 100029d8 100029d8 10003020 00000000 7fff7dc8 10003b60 2d8e2163
> $24: 00000001 2ab7bc30                   10008e70 7fff7bf0 04000000 00439e50
> Hi : 00000000
> Lo : 00000001
> epc  : 00439e84    Not tainted
> Status: 0000fc13
> Cause : 10800028
> Process sh (pid: 18, stackpage=97fc2000)
> Stack: 00000001 00000000 2abd0ff0 7fff7c28 10008e70 00000000 10008e6c 00000000
>        100049a0 0042f188 00000000 100029d8 00000001 00000001 7fff7f04 10008e70
>        00427fe4 00427f00 00000000 00000000 10002764 10008e70 10008e70 00000000
>        00000000 00000000 10008e70 00422734 00000001 00000001 7fff7f04 10008e70
>        10008e70 00000003 10008e70 004315cc 00000001 00000000 10002764 00000000
>        10008e70 ...
> Call Trace:
> Code: 00000000  2421dd48  00220821 <8c220000> 00000000  005c1021  00400008  0000
> 0000  8f99802c
> 
> The epc is not in kernel space and ksymoops did not provide any info. The epc keeps changing to different locations in user space over multiple runs.

In a case like this you're likely dealing with double exceptions.  Your
code is taking an exception and the exception handler while running with
c0_status set is taking another exception.  If the first exception handler
is still running with the c0_status.exl bit set the CPU when taking the
second exception it will not record the PC of the second exception and
you will have a seemingly unexplainable exception.

A few processors have the nasty habit of throwing RI receptions or do
similarly weird things when executing code that is mapped through multiple
TLB pages but the 4kEC shouldn't.

  Ralf
