Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2003 21:53:12 +0000 (GMT)
Received: from [IPv6:::ffff:209.116.120.7] ([IPv6:::ffff:209.116.120.7]:40967
	"EHLO tnint11.telogy.design.ti.com") by linux-mips.org with ESMTP
	id <S8225197AbTKYVxA>; Tue, 25 Nov 2003 21:53:00 +0000
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <W5NHJGXP>; Tue, 25 Nov 2003 16:52:21 -0500
Message-ID: <37A3C2F21006D611995100B0D0F9B73C02C8FCAE@tnint11.telogy.design.ti.com>
From: "Kapoor, Pankaj" <pkapoor@telogy.com>
To: linux-mips@linux-mips.org
Subject: MIPS Interrupts.
Date: Tue, 25 Nov 2003 16:52:20 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <pkapoor@telogy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkapoor@telogy.com
Precedence: bulk
X-list: linux-mips

All,

While studying the implementation of tasklets and softirq processing I came 
across certain issues which I have outlined below. 

The function mipsIRQ in the file mipsIRQ.s is the registered interrupt 
handler for all general purpose interrupts. 

The first thing that the function does is that it saves all registers. It 
then checks the CAUSE register to check the source of the interrupt.
Currently 
all we are interested in is INT5 (Timer) and INT0 (i.e. all other devices) 

Consider a timer interrupt which would cause the code to jump to 0x8000:0180

and cause all the registers to be saved (SAVE_ALL). It would then jump to
the 
mips_timer_interrupt function in the file time.c 

The function services the timer interrupt. At the end of the function there 
is an irq_exit and a check to see if there are any SOFT IRQ pending. 
If there are any the function jumps to the do_softirq function defined in 
the softirq.c. The function gets the softirq pending list, enables
interrupts 
and cycles through all pending soft irq's calling the appropriate handlers. 

Remember that the interrupts are enabled while executing the various bottom 
half handlers. 

Now there are 2 cases that can happen 

1. Since we have not exited the ISR and the exception level has still not 
   been restored there can be no more interrupts that are generated in the 
   system. In such a case does that mean that the all bottom half handlers 
   pending execution will run with interrupts disabled. 
   NOTE: This does not seem likely because the local_irq_enable routine
calls 
   _sti which clears the exception level in the status register and also 
   sets the IE bit. 

2. If we have large number of tasklets or if the bottom half handlers take
time 
   to execute, then we could get another timer interrupt or other device 
   interrupts causing context saves which would cause the stack to grow and 
   CRASH the system. 
  
Context is restored only when the code returns from do_softirq and uses the 
ret_from_irq. 

Is there anything that I am missing in this whole picture ? 

Thanks.
- Pankaj 
