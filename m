Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 14:51:43 +0000 (GMT)
Received: from [IPv6:::ffff:209.226.172.94] ([IPv6:::ffff:209.226.172.94]:59822
	"EHLO semigate.zarlink.com") by linux-mips.org with ESMTP
	id <S8225541AbSLTOvn>; Fri, 20 Dec 2002 14:51:43 +0000
Received: from ottmta01.zarlink.com (ottmta01 [134.199.14.110])
	by semigate.zarlink.com (8.10.2+Sun/8.10.2) with ESMTP id gBKEpVL02164;
	Fri, 20 Dec 2002 09:51:31 -0500 (EST)
Subject: Re: Problems with CONFIG_PREEMPT
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org, rml@mvista.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF2066EDAB.79E8E12E-ON80256C95.00517ECB@zarlink.com>
From: Colin.Helliwell@Zarlink.Com
Date: Fri, 20 Dec 2002 14:51:24 +0000
X-MIMETrack: Serialize by Router on ottmta01/Semi(Release 5.0.11  |July 24, 2002) at 12/20/2002
 09:51:31 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Return-Path: <Colin.Helliwell@Zarlink.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Colin.Helliwell@Zarlink.Com
Precedence: bulk
X-list: linux-mips


Think I'm ok with respect to interrupt handling, but what does making
globals "safe or taken care of" consist of?




                                                                                                                                       
                      Jun Sun                                                                                                          
                      <jsun@mvista.com>        To:       Colin.Helliwell@Zarlink.Com                                                   
                                               cc:       linux-mips@linux-mips.org, rml@mvista.com, jsun@mvista.com                    
                      19-Dec-2002 05:59        Subject:  Re: Problems with CONFIG_PREEMPT                                              
                      PM                                                                                                               
                                                                                                                                       
                                                                                                                                       




On Thu, Dec 19, 2002 at 09:10:40AM +0000, Colin.Helliwell@Zarlink.Com
wrote:
>
> Thanks for the patch, but unfortunately the problem is still the same.

If the problem happens very soon after you boot up, there is something
*obviously* wrong.  The most common problem is that you have an interupt
handling path not going through standard do_IRQ().  Then you need to
do similar treatment like those in ll_timer_interrupt().

The second thing is to look for any *new* global variables you may
introduce in your kernel.  Most of current global variables are either
safe or taken care of (Although another update patch will come out
today or tomorrow to really close the final hole we have).

> I'm
> not sure whether it occurs as a result of interrupts, or just after a
> certain amount of scheduler 'activity' as it sits there copying the
initrd
> into ram disk. A few interrupts are enabled, but its only the MIPS timer
> which should be generating any interrupts at that point (I'll check that,
> in case its relevant).

FYI, I have mips kernel with initrd running just fine with preemptible
kernel.
In fact, it has passed some very stressful tests with initrd.

> I presume the change from "sti()" to "__sti()" was a semantic (or SMP)
> thing, since the former is #defined to the latter anyway? Please note
also
> the following modification which was required to 2.4.19:
>

This is true.  Since our kernel had synchronize_irq() added long time ago,
I probably forgot about it when I created the pre-k patch.

Jun
