Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB9EH5N06736
	for linux-mips-outgoing; Sun, 9 Dec 2001 06:17:05 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB9EGwo06733
	for <linux-mips@oss.sgi.com>; Sun, 9 Dec 2001 06:16:58 -0800
Message-Id: <200112091416.fB9EGwo06733@oss.sgi.com>
Received: (qmail 13776 invoked from network); 9 Dec 2001 12:52:02 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 9 Dec 2001 12:52:02 -0000
Date: Sun, 9 Dec 2001 20:54:47 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Chris Dearman <chris@algor.co.uk>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: the cause of spurious interrupt problem 
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Chris,

days ago you said,
>  The spurious interrupts are caused by posted writes to PCI devices. 
>The sequence is usually something like:
>  o write device to clear interrupt (write gets posted)
>  o enable CPU interrupts (interrupt is still pending)
>  o CPU enters interrupt handler and reads 8259 which causes posted
>write
>    to be flushed and so now there is no interrupt...
>
>  The only fix is to do an explicit PCI (eg ISA port) before reenabling
>interrupts.  The 2.4.x kernel reenables interrupts more quickly than the
>older kernel which is why it is more noticeable.
>
I am trying to find a better way to work around according to your analyse 
these days.But things are not working as expected at all.If spurious 
interrupts are caused by posted writes,then define SLOW_DOWN_IO
or even REALLY_SLOW_IO in io.h should help; or,from bonito manual,
i find read pciMSTAT register can ensure write is actually performed.
but they all failed.
  Then all at a suddenly i find the REAL reason: the way we use to
determine which interrupt happens has severe flaw.That code simply
does this:
       isr = inb(0x20);
       irq = ffz(~isr); /* found first non zero bit,*/
       if (irq == 2) {
           isr = inb(0xa0);
           irq = 8 + ffz(~isr);
       }
       ...
 In fact this interrupt is probably not triggered by IRQ'irq'.the 
IRR register  has multiple bits set!On x86(including some non-x86 platform),
the interrupting vector is fetched from the controller via bus,
so it is accurate. But p6032 does not provide us such a vector
and we use the above and fail:(

 Most popular sequence should look like this:
     
        irq A happens,
            mask A,send EOI
                    IRQ B happens(A<B)
                      because A hasn't been serviced,the IRR bit for A
                      is still set,our code report A irq happens!
                        ---> oops,spurious interrupt happens
                service A
i have make a patch,now it leaves kernel/i8259.c untouched and working
well(previous inb(0x60) hack suffer from characters lost).I have updated
patch on my site.Pretty simple,just skip irqs with IRQ_INPROGRESS set.

  Also i notice that after new patch,all interrupt should be programed into
edge trigger mode(with level trigger mode i've seen a IRQ7 spurious interrupt 
and the machine locked up during boot).
  Am i right?

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
