Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 00:25:05 +0000 (GMT)
Received: from [IPv6:::ffff:209.116.120.7] ([IPv6:::ffff:209.116.120.7]:51975
	"EHLO tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S8226077AbTKZAYx>; Wed, 26 Nov 2003 00:24:53 +0000
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <W5NHJHL8>; Tue, 25 Nov 2003 19:24:18 -0500
Message-ID: <37A3C2F21006D611995100B0D0F9B73C02C8FCAF@tnint11.telogy.design.ti.com>
From: "Kapoor, Pankaj" <pkapoor@telogy.com>
To: 'Jun Sun' <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: RE: MIPS Interrupts.
Date: Tue, 25 Nov 2003 19:24:18 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <pkapoor@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkapoor@telogy.com
Precedence: bulk
X-list: linux-mips

> The nested interrupt call, do_IRQ(), may still try to call do_softirq()
but
> that it will return immediately as it discovers another instance of
do_softirq()
> is running.  No further nesting occurs as a result. 

How is this detected ? Is this the check of "softirq_pending(cpu)" in the
do_softirq() ?

Can we have a case as shown below :

1. Interrupt 1 is generated : Jump to general exception handler
(0x8000:0180)
2. Save the current context
3. Interrupt 1 is processed which schedules tasklet1 for execution.
	softirq_pending(cpu) = TASKLET_SOFTIRQ
4. Interrupts are reenabled.
5. do_softirq : Tasklet1 is executing & softirq_pending(cpu) = 0.
6. -------> Interrupt 2 is generated : Jump to general exception handler
(0x8000:0180)
		6a) Save the current context
		6b) Interrupt2 is processed which schedules tasklet2 for
execution. 
			softirq_pending(cpu) = TASKLET_SOFTIRQ
		6c) Interrupts are reenabled.
		6d) do_softirq : Tasklet2 is executing &
softirq_pending(cpu) = 0.
		6e) ----> Interrupt3 is generated
			.... and so on.
		.
		.
		.
		6f) Context is restored. Return from exception.
.
.
.
7. Context is restored. Return from exception.

Thanks. 
- Pankaj
