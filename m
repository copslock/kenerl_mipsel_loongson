Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2003 14:46:38 +0100 (BST)
Received: from news.ti.com ([IPv6:::ffff:192.94.94.33]:55971 "EHLO
	dragon.ti.com") by linux-mips.org with ESMTP id <S8225289AbTHMNqZ>;
	Wed, 13 Aug 2003 14:46:25 +0100
Received: from dlep52.itg.ti.com ([157.170.134.103])
	by dragon.ti.com (8.12.9/8.12.9) with ESMTP id h7DDkH1p012950
	for <linux-mips@linux-mips.org>; Wed, 13 Aug 2003 08:46:18 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep52.itg.ti.com (8.12.9/8.12.9) with ESMTP id h7DDkHTh018445
	for <linux-mips@linux-mips.org>; Wed, 13 Aug 2003 08:46:17 -0500 (CDT)
Received: from dlee70.itg.ti.com (dlee70.itg.ti.com [157.170.135.145])
	by dlep90.itg.ti.com (8.12.9/8.12.9) with ESMTP id h7DDkHJ5007891
	for <linux-mips@linux-mips.org>; Wed, 13 Aug 2003 08:46:17 -0500 (CDT)
Received: by dlee70.itg.ti.com with Internet Mail Service (5.5.2653.19)
	id <QZCGK96C>; Wed, 13 Aug 2003 08:46:17 -0500
Received: from ti.com (cbc0794930.isr.asp.ti.com [137.167.2.134]) by dile70.itg.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id QZ2BQF5F; Wed, 13 Aug 2003 16:46:04 +0300
From: "Sirotkin, Alexander" <demiurg@ti.com>
To: linux-mips@linux-mips.org
Message-ID: <3F3A411C.70603@ti.com>
Date: Wed, 13 Aug 2003 16:46:04 +0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: tasklet latency and system calls on mips
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <demiurg@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: demiurg@ti.com
Precedence: bulk
X-list: linux-mips

Hello dearest all.

I have a question regarding tasklets on MIPS. I suspect that there is a
bug in generic MIPS kernel, but I'm not sure yet.

Linux kernel has a couple of so called "checkpoints" when the system
should check if there are tasklets to
run and run them in the following way :

if (softirq_pending(cpu))
                    do_softirq();

One of these places is at the end of interrupt handler (do_IRQ()),
however this is not the only place. I was under
impression that this code should be called after system call too. The
caveat here is that on MIPS (contrary to
other architectures, such as x86) system call is not an interrupt (it's
a different exception) and has completely
different handler. So in x86 it is sufficient to call

if (softirq_pending(cpu))
                    do_softirq();

at the end of do_IRQ because do_IRQ handles system call too, but on MIPS
it is not. Therefore I believe
these lines should be added to the end of sys_syscall function on MIPS.

What do you think ?

P.S. The whole issue started when we noticed that user process making
many system calls has very
significant impact on device drivers running in tasklet mode and no
impact whatsoever on device
drivers running in interrupt mode.
