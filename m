Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3NNg1wJ003833
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Apr 2002 16:42:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3NNg1RV003832
	for linux-mips-outgoing; Tue, 23 Apr 2002 16:42:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from darth.paname.org (root@ns0.paname.org [212.27.32.70])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3NNftwJ003829
	for <linux-mips@oss.sgi.com>; Tue, 23 Apr 2002 16:41:56 -0700
Received: from darth.paname.org (localhost [127.0.0.1])
	by darth.paname.org (8.12.1/8.12.1/Debian -2) with ESMTP id g3NNgHZB011459
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 01:42:17 +0200
Received: (from rani@localhost)
	by darth.paname.org (8.12.1/8.12.1/Debian -2) id g3NNgHrI011458
	for linux-mips@oss.sgi.com; Wed, 24 Apr 2002 01:42:17 +0200
From: Rani Assaf <rani@paname.org>
Date: Wed, 24 Apr 2002 01:42:17 +0200
To: linux-mips@oss.sgi.com
Subject: Interrupts, exceptions and modules
Message-ID: <20020424014217.W27181@paname.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux darth 2.4.17-pre8 
X-NCC-RegID: fr.proxad
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I  run into  the following  problem when  loading a  module that  uses
interrupts (net driver):

1) Module loads and request_irq()

2) We take an interrupt before doing anything else in the module.
   Our low level IRQ handler (for the RC32300) disables interrupts
   by clearing the IE bit in CP0_STATUS (code based on the various
   implementations of other boards)

3) in handle_IRQ_event() the module handler is called through:
     action->handler(irq, action->dev_id, regs);

4) The processor does an exception (tlb miss/refill) to get the
   page pointed by action->handler.
   At the end of the tlb exception handler, we have an "eret"
   => interrupts are enabled again (IE bit goes to 1)

5) We take another interrupt (because we didn't get into
   the handler to clear the cause yet), in do_IRQ() we see that
   one is already pending => eret

6) goto 5

I had  to disable  interrupts through  CP0_STATUS IM  bits in  the low
level interrupt handler to handle this.  I looked at the code of other
boards and none seemed to do this.

So did  I miss something? Couldn't  this happen to anyone  who loads a
module  and get  the modules's  intialization code  and the  interrupt
handler go into different pages?

Regards,
Rani
