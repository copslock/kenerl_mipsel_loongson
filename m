Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2006 03:10:12 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:41957 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038960AbWJICKJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2006 03:10:09 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CFE problem: starting secondary CPU.
Date:	Sun, 8 Oct 2006 19:10:05 -0700
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D3E7352@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CFE problem: starting secondary CPU.
thread-index: AcbptnK09wiGicUZQwSJalVBZNRNVQBjFPJg
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> I've seen the case where the second CPU did not start
> on a Broadcom 1250 running a 64-bit kernel, but I
> don't know if anyone has a good solution. I just
> rigged the values in the Linux kernel so that it knows
> about the second CPU.

Do you have a patch for that?

> It's a godawful hack, but I
> needed something quick at the time.

I wrote another hack. I struggled with it for hours and
then finally got it to work. Whoo! 

The idea is based on the hypothesis that the 64 bit
kernel's environment somehow makes the CFE calls unreliable.

Under this hack, the CPUs are started early through CFE,
before most other initializations. They go into a holding function
which is almost identical to the one inside CFE, 
except that it's running kernel code.

Then later at the point where the CPU's are to be released
into the kernel, it's purely an in-kernel operation, no
longer involving any calls to CFE.



Remarks:



I have some CFE code which reads environment variables
using CFE. Under 64 bit, there is a mysterious oops in it.
The code looks good, and runs fine under 32.

What could it be? Maybe CFE doesn't like being called from
a task! Something about the 64 bit stack?

Note that code which starts the other CPU's is called from a
kernel thread which calls the init() function, not from
the mainline.

I will investigate further.
