Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 05:36:34 +0100 (BST)
Received: from NeSTGROUP.NET ([203.200.158.40]:5059 "EHLO ns2.nestgroup.net")
	by ftp.linux-mips.org with ESMTP id S20022066AbXGEEg2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jul 2007 05:36:28 +0100
Received: from MAIL-TVM.tvm.nestgroup.net ([192.168.192.74])
	by ns2.nestgroup.net (8.13.1/8.13.1) with ESMTP id l654iARY022023
	for <linux-mips@linux-mips.org>; Thu, 5 Jul 2007 10:14:11 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Glibc - Segmentation Fault
Date:	Thu, 5 Jul 2007 10:04:25 +0530
Message-ID: <9A1299C7A40D7447A108107E951450CA01C9E087@MAIL-TVM.tvm.nestgroup.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Glibc - Segmentation Fault
Thread-Index: Ace+vcSXj/zuIAL9TnqBSv5wVHu3Pw==
From:	"Sadarul Firos" <sadarul.firos@nestgroup.net>
To:	<linux-mips@linux-mips.org>
Return-Path: <sadarul.firos@nestgroup.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sadarul.firos@nestgroup.net
Precedence: bulk
X-list: linux-mips

Hi all,

I have already posted this issue to this list but without more details,
I think that may be the reason why I am not getting more replies. This
time I have come up with all the steps which I have tried to solve the
problem. I think these will give you more insight into the problem.

The problem:
I'm performing continuous reboot test on a MIPS based board running
linux-2.6.18/glibc-2.3.5/gcc-3.3.6. After several hours of rebooting
(say after 80, purely random) I've observed Segmentation fault or
Illegal instruction error while starting the udevd and ntpd programs
during the startup. The error appears pretty much random, it doesn't
usually take more than an hour or two to catch an instance of the
Segfault.

Steps I have tried to resolve the problem:
1. Used environment variable LD_DEBUG=all for debugging ntpd and udevd.
After a few hours of reboot test I could observe segmentation fault. The
last line printed on the console at the time of segmentation fault was
"calling init". From the log file it was observed that the segmentation
fault occur after the "init" function call of libnss_dns.so (in the case
of ntpd) and libnss_compat.so/libnss_files.so (in the case of udevd).
But the function "init" doesn't present in both libraries, I think a
default "init" would be used if none is present.


2. Added printf statements in the call_init function in
glibc-2.3.5/elf/dl-init.c. Since putting those printf statements into
the call_init function I have NOT seen a single segfault or illegal
instruction in over 2400 reboots!


3. Run the application udevd and ntpd during startup using gdb. Couldn't
observe segfault/illegal instruction error for long hours of reboot.


4. Registered a signal handler in ntpd and udevd to get the backtrace
using sigaction at the time of segmentation fault, but got only a single
address location (NOT a full stack trace). After that, tried to map this
address with the application using 'nm' utility, but couldn't locate the
same.


5. Generated core dump at the time of segfault. Analyzed the core dump
using gdb and observed that the segfault occur at init function of
libnss_compat.so (in the case of udevd) and libnss_dns.so (in the case
of ntpd). 

6. As per my understanding, the default init that would be used is
located in sysdep/generic/initfini.c. Compared this file for glibc
version 2.3.5 and 2.5 but no differences were found. 


7. Compiled ntpd and udevd statically and performed the reboot test. But
segfault was observed after 34 reboots.


8. Added a dummy _init/_fini function in both the nss libraries
(libnss_dns.so and libnss_compat.so) to override the default init
functions. But segfault was observed after 207 reboots.


9. Added constructor/destructor routine in libnss_dns.so and
libnss_compat.so. Segmentation fault occurred after several hours of
reboot. 


10. Used LD_BIND_NOW option (enabled this option just before
ntpd/udevd), using this option all symbols will be resolved at the
loading time. Even after enabling this feature, didn't observe any
difference in the issue i.e. observed segfault after 265 reboots 

11. Changed the order of invocation of the programs udevd and ntpd.
Previously, in the init scripts, udevd was started first and ntpd was
called somewhere near the last stage of init scripts. Now ntpd is
started immediately after invoking udevd. Surprisingly, the frequency of
appearing segfault was increased, ie previously it would take nearly 100
reboots to observe a segfault, but now it would take nearly 10 reboots
to observe a segfault!

Hope these will give you inputs to comment on this problem. Waiting for
your valuable replies

Firos
