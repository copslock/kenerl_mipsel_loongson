Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 09:10:56 +0000 (GMT)
Received: from [IPv6:::ffff:209.226.172.94] ([IPv6:::ffff:209.226.172.94]:31901
	"EHLO semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S8225397AbSLSJKz>; Thu, 19 Dec 2002 09:10:55 +0000
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.10.2+Sun/8.10.2) with ESMTP id gBJ9AiL02936;
	Thu, 19 Dec 2002 04:10:44 -0500 (EST)
Subject: Re: Problems with CONFIG_PREEMPT
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org, rml@mvista.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF6E5B6266.DFC7C2F8-ON80256C94.002DE2D6@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Thu, 19 Dec 2002 09:10:40 +0000
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.11  |July 24, 2002) at 12/19/2002
 04:10:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips


Thanks for the patch, but unfortunately the problem is still the same. I'm
not sure whether it occurs as a result of interrupts, or just after a
certain amount of scheduler 'activity' as it sits there copying the initrd
into ram disk. A few interrupts are enabled, but its only the MIPS timer
which should be generating any interrupts at that point (I'll check that,
in case its relevant).
I presume the change from "sti()" to "__sti()" was a semantic (or SMP)
thing, since the former is #defined to the latter anyway? Please note also
the following modification which was required to 2.4.19:

diff -u -p -r1.1 -r1.2
--- scratch/include/asm-mips/hardirq.h    2002/09/26 15:58:11     1.1
+++ scratch/include/asm-mips/hardirq.h    2002/12/12 13:15:03     1.2
@@ -42,7 +42,7 @@
 #define irq_exit(cpu, irq)   (local_irq_count(cpu)--)

 #define synchronize_irq()    barrier();
-
+#define release_irqlock(cpu) do { } while (0)
 #else

 #include <asm/atomic.h>



(We had a look at the 2.5 (head) kernel, but this seems to have some wrong
coding, and doesn't build straight off. Things like duplicate #defines
ALIGN and a conditional branch instruction with only one operand!)




                                                                                                                                           
                      Jun Sun                                                                                                              
                      <jsun@mvista.com>            To:       Colin.Helliwell@Zarlink.Com                                                   
                      Sent by:                     cc:       linux-mips@linux-mips.org, jsun@mvista.com, rml@mvista.com                    
                      linux-mips-bounce@lin        Subject:  Re: Problems with CONFIG_PREEMPT                                              
                      ux-mips.org                                                                                                          
                                                                                                                                           
                                                                                                                                           
                      17-Dec-2002 06:03 PM                                                                                                 
                                                                                                                                           
                                                                                                                                           




On Tue, Dec 17, 2002 at 08:27:16AM +0000, Colin.Helliwell@Zarlink.Com
wrote:
>
> NEW_TIME_C is set. URL to the patch is:
>
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.19-2.patch

>

There are some bits missing.  Not sure if it is related to your problem or
not.

Robert, please take the MIPS preemptible kernel update patch.

> We ultimately want to add in real-time support, such as Ingo's O(1)
> scheduler - if this is 'complete' for MIPS.

O(1) shortens process dispatching time, usually not a big time saver
unless you have *lots* of process and/or you are doing frequent context
switches.

Another patch which is probably more important is the Ingo's breaking
selected big lock patch.  That will preemption work more effectively.

> I don't know if it would be
> better just to go for this in one hit, or if we'd need the preemption
> sorted out anyway first.

You do have to sort them out one by one.  (Or you get them all by becoming
mvista customer. :-0)

> Or should we just go to a 2.5.x kernel instead?

We'd love to have more people bang on 2.5 MIPS *grin* ...

Jun
