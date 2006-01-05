Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2006 15:12:31 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35271 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133546AbWAEPMN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jan 2006 15:12:13 +0000
Received: from localhost (p4083-ipad30funabasi.chiba.ocn.ne.jp [221.184.79.83])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 70B0AA538; Fri,  6 Jan 2006 00:14:45 +0900 (JST)
Date:	Fri, 06 Jan 2006 00:14:12 +0900 (JST)
Message-Id: <20060106.001412.93019293.anemo@mba.ocn.ne.jp>
To:	rmk@arm.linux.org.uk
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] serial_txx9: forcibly init the spinlock for PCI UART
 used as a console
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051227184152.GA4474@flint.arm.linux.org.uk>
References: <43B143EE.6070700@ru.mvista.com>
	<20051228.003457.74752441.anemo@mba.ocn.ne.jp>
	<20051227184152.GA4474@flint.arm.linux.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 27 Dec 2005 18:41:52 +0000, Russell King <rmk@arm.linux.org.uk> said:

>> Yes, you are right.  I missed the register_console call in
>> uart_add_one_port().  So your patch will fix the problem.  But I
>> suppose the spinlock should be initialized in serial_core.  How
>> about this?

rmk> I think you're layering work-around on top of work-around on top
rmk> of work-around here.

Russell, could you tell me where is the right place to initialize
port's spinlock ?

Currently, serial_core do initialize the spinlock in uart_set_options
(for console) and uart_add_one_port (for other ports).  And some low
level drivers also initialize it in some place.
(serial8250_isa_init_ports, etc.)

A.  The initialization in serial_core is just for failsafe and low
    level drivers should initialize the spinlock.

B.  Those initializations in low level drivers are there just by
    historical (or any other) reason and now redundant.  They can be
    omitted because serial_core is responsible to initialize the
    spinlock.

Which is right ? (if both are wrong, could you correct me ?)

I will update and send patch(es) based on your answer.  Thank you.

---
Atsushi Nemoto
