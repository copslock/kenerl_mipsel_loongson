Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Sep 2003 20:45:53 +0100 (BST)
Received: (root@3ffe:8260:2028:fffe::1) by linux-mips.org
	id <S8225375AbTIHTpU>; Mon, 8 Sep 2003 20:45:20 +0100
Received: from webmail8.rediffmail.com ([IPv6:::ffff:202.54.124.153]:40386
	"HELO rediffmail.com") by linux-mips.org with SMTP
	id <S8225200AbTIDIEE>; Thu, 4 Sep 2003 09:04:04 +0100
Received: (qmail 26760 invoked by uid 510); 4 Sep 2003 08:03:15 -0000
Date: 4 Sep 2003 08:03:15 -0000
Message-ID: <20030904080315.26759.qmail@webmail8.rediffmail.com>
Received: from unknown (210.210.7.195) by rediffmail.com via HTTP; 04 sep 2003 08:03:15 -0000
MIME-Version: 1.0
From: "ashish  anand" <ashish_ibm@rediffmail.com>
Reply-To: "ashish  anand" <ashish_ibm@rediffmail.com>
To: inux-mips@linux-mips.org
Subject: why irq -1 is being passed to do_IRQ..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Resent-From: root@ftp.linux-mips.org
Resent-Date: Mon, 8 Sep 2003 20:45:20 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <root@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: root@ftp.linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

I am writing to this list after a long back.

I have spurious interrupt problem in do_IRQ() in otherwise 
stable
linux port on mips lexra board .problem happens if I use ISDN 
phones.
but it doesn't happen essentially before or after ISDN card 
interrupt.
we have tried writing FFh in ISDN card mask register then again 
restoring old mask in end of ISDN ISR as indicated in ISDN manual 
for interfacing with some interrupt controllers , but it didn't 
help much.
so might be some minute problem in BSP.but i have a more 
fundamental question for now.

actually do_IRQ calls mask_irq and unmask_irq and there it 
prints
".......wrong irq number -1 pased.........."
if i see the code for file int-handler.S

In the first level interrupt handling code  we jump to do_IRQ only 
when irq is >= 0 otherwise we just  return as per the code piece 
below.

as per the code below do_IRQ() should always be passed a valid irq 
number.

                 lw      
a0,%lo(cpu_irq_nr-cpu_mask_tbl-PTRSIZE)(t1)
                  nop
                 bgez    a0, handle_it           # irq_nr >= 0?
                                                # irq_nr < 0: just 
exit
                  nop
                  j       return_
                  nop                            # delay slot

handle_it:      jal     do_IRQ
                  move   a1,sp
return_:        j       ret_from_irq
                  nop

                 END(lx_handle_int)
#endif
I am litle confused why irq -1 is being passed to do_IRQ at all.
pls. cc the reply to me as well.

Best Regards,
Ashish
___________________________________________________
Meet your old school or college friends from
1 Million + database...
Click here to reunite www.batchmates.com/rediff.asp
