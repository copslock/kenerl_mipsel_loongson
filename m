Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2004 17:25:18 +0100 (BST)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:44200 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8224944AbUJZQZN>; Tue, 26 Oct 2004 17:25:13 +0100
Received: (qmail 13930 invoked from network); 26 Oct 2004 16:04:34 -0000
Received: from unknown (HELO ru.mvista.com) (192.168.1.199)
  by mail.dev.rtsoft.ru with SMTP; 26 Oct 2004 16:04:34 -0000
Message-ID: <417E7A66.8010700@ru.mvista.com>
Date: Tue, 26 Oct 2004 20:25:10 +0400
From: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
Subject: [PATCH] Toshiba RBHMA3100 IRQ handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pkiryukhin@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkiryukhin@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

   We have discovered a number of issues with IRQ handling code in 
linux/arch/mips/jmr3927/rbhma3100/irq.c.
   First, the most serious: if IRQ is get somehow disabled in its IRQ 
handler or just wasn't handled for some reason (or was nesting despite 
being masked off by jmr3927_irq_ack(), and so left unhandled) it 
shouldn't be unmasked by
jmr3927_irq_end(). This check is present for other MIPS boards but is 
still missing for RBHMA3100...
   Second, the most serious, which caused that unwanted IRQ nesting. The 
interrupt controller (IRC) registers are in the reserved KSEG2 area 
which is subject to the write buffering in the TX3927, and the interrupt 
level register (IRL) write masking off IRQ appear to get stuck in the 
write buffer until the CPU interrupts are re-enabled by do_IRQ() after 
calling jmr3927_irq_ack(), and so the IRQs were sometimes re-occuring 
while the IRQ handler was doing its stuff--the result was fatal: board 
was just quietly dying every time this was happening. Flushing the write 
buffer by reading the source status register (IRSSR) in 
[un]mask_irq_irc() fixes this; note, that the buffer flushing code was 
present in [un]mask_irq_*() for the ISA and I/O controller IRQs but was 
missing for the IRC IRQs...
   Below is the patch for 2.4 kernel, and 2.6 kernel seems to be missing 
this too!

Index: linux/arch/mips/jmr3927/rbhma3100/irq.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/jmr3927/rbhma3100/irq.c,v
retrieving revision 1.2.2.6
diff -a -u -r1.2.2.6 irq.c
--- linux/arch/mips/jmr3927/rbhma3100/irq.c    16 Apr 2003 12:59:33 
-0000    1.2.2.6
+++ linux/arch/mips/jmr3927/rbhma3100/irq.c    26 Oct 2004 16:02:36 -0000
@@ -149,7 +149,8 @@
     db_assert(irq >= jmr3927_irq_base);
     db_assert(irq < jmr3927_irq_base + JMR3927_NR_IRQ_IRC + 
JMR3927_NR_IRQ_IOC);

-    jmr3927_irq_enable(irq);
+    if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
+        jmr3927_irq_enable(irq);
 }

 static void jmr3927_irq_disable(unsigned int irq_nr)
@@ -234,6 +235,8 @@
     /* update IRCSR */
     tx3927_ircptr->imr = 0;
     tx3927_ircptr->imr = irc_elevel;
+    /* flush write buffer */
+    (void)tx3927_ircptr->ssr;
 }
 static void unmask_irq_irc(int irq_nr, int space_id)
 {
@@ -245,6 +248,8 @@
     /* update IRCSR */
     tx3927_ircptr->imr = 0;
     tx3927_ircptr->imr = irc_elevel;
+    /* flush write buffer */
+    (void)tx3927_ircptr->ssr;
 }

 struct tb_irq_space jmr3927_isac_irqspace = {
