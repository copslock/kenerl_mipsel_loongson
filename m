Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 10:55:18 +0100 (BST)
Received: from NeSTGROUP.NET ([203.200.158.40]:37790 "EHLO ns2.nestgroup.net")
	by ftp.linux-mips.org with ESMTP id S20023209AbXFRJzO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 10:55:14 +0100
Received: from MAIL-TVM.tvm.nestgroup.net ([192.168.192.74])
	by ns2.nestgroup.net (8.13.1/8.13.1) with ESMTP id l5I9x4Ea002410;
	Mon, 18 Jun 2007 15:29:05 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: "Segfault/illegal instruction" - udevd - ntpd - glibc
Date:	Mon, 18 Jun 2007 15:21:29 +0530
Message-ID: <9A1299C7A40D7447A108107E951450CA01C9E01C@MAIL-TVM.tvm.nestgroup.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "Segfault/illegal instruction" - udevd - ntpd - glibc
Thread-Index: AcexAQS/8o5iaXsVRBW3fMJuu+ZjbAAiqDjwAACNqiA=
From:	"Sadarul Firos" <sadarul.firos@nestgroup.net>
To:	<ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <sadarul.firos@nestgroup.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sadarul.firos@nestgroup.net
Precedence: bulk
X-list: linux-mips


Thanks Ralf for the reply.

Regarding kernel, I am using the final release version of linux 2.6.18
kernel with some customizations. Out of the two boards which I have one
has MSP8150 Multi-Service Processor(MIPS 64) and the other has ITE 8172
system controller with RM7035C, 64-bit MIPS RISC microprocessor(MIPS V).

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Sunday, June 17, 2007 1:04 AM
To: Sadarul Firos
Cc: linux-mips@linux-mips.org
Subject: Re: "Segfault/illegal instruction" - udevd - ntpd - glibc

On Fri, Jun 15, 2007 at 09:23:34PM +0530, Sadarul Firos wrote:

> I am working with two MIPS based boards (one is MIPS and the other is
> MIPSEL) running linux-2.6.18/glibc-2.3.5. I am performing a
consecutive
> reboot test on these boards. After some number of reboots (say 80) I
am
> getting "segmentaion fault/illegal instruction" while running udevd
and
> ntpd during bootup. Upon observing the core dump, it is noted that the
> segfault occured from the _init function of libnss_dns.so (in the case
> of ntpd) and libnss_compat.so (in the case of udevd). I assume that
> there might be a problem somewhere in the call_init function in
> glibc-2.3.5/elf/dl-init.c. After I put some printf statements for
> debugging in the call_init function, there is no segfault/illegal
> instruction in the reboot testing. I have also used gdb to debug the
> problem but the "segfault/illegal instruction" doesn't occur during
the
> reboot test. Could anyone please help me to sort out this problem. The
> gdb output using coredump is attached.

Normally the address space layout and most other variables during a
program load should be identical each time so userspace should behave
identical.   So I sense the scent of a TLB or more likely cache
managment
problem.

What 2.6.18 variant exactly are you running, that is where & when did
download it, what CPU?

  Ralf
