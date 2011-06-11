Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Jun 2011 02:21:01 +0200 (CEST)
Received: from imr3.ericy.com ([198.24.6.13]:53216 "EHLO imr3.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491138Ab1FKAU5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 11 Jun 2011 02:20:57 +0200
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
        by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id p5B0Kh8q010415
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 10 Jun 2011 19:20:50 -0500
Received: from [155.53.96.104] (147.117.20.214) by
 eusaamw0711.eamcs.ericsson.se (147.117.20.179) with Microsoft SMTP Server id
 8.3.137.0; Fri, 10 Jun 2011 20:20:42 -0400
Subject: Re: Linux 2.6.39 on Cavium CN38xx
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <4DF15068.30906@caviumnetworks.com>
References: <1307653714.8271.130.camel@groeck-laptop>
         <4DF13E25.2060502@caviumnetworks.com> <20110609220614.GA13583@ericsson.com>
         <4DF15068.30906@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: Ericsson
Date:   Fri, 10 Jun 2011 17:20:42 -0700
Message-ID: <1307751642.8271.315.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
X-archive-position: 30337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9665

On Thu, 2011-06-09 at 18:59 -0400, David Daney wrote:
> On 06/09/2011 03:06 PM, Guenter Roeck wrote:
> > Hi David,
> >
> > On Thu, Jun 09, 2011 at 05:41:57PM -0400, David Daney wrote:
> >> On 06/09/2011 02:08 PM, Guenter Roeck wrote:
> >>> Hi folks,
> >>>
> >>> I am trying to get Linux 2.6.39
> >>
> >> Where did you get your 2.6.39?  Or in othe rwords, what's the SHA1 Kenneth?
> >>
> >> From kernel.org. 2.6.39.1, more specifically. We have some local modifications,
> > but nothing relevant, ie nothing in the mips boot path.
> >
> >> And, what is your .config?
> >>
> > Please see attached.
> 
> 
> With:
> 
> commit cf29f916c310c9b13c19514b496700c549597e11
> Author: Greg Kroah-Hartman <gregkh@suse.de>
> Date:   Fri Jun 3 09:34:20 2011 +0900
> 
>      Linux 2.6.39.1
> 
> 
> And with the attached config I can do:
> 
> octeon:~# cat /proc/version
> Linux version 2.6.39.1 (ddaney@dd1.caveonetworks.com) (gcc version 4.6.1 
> 20110328 (prerelease) [gcc-4_6-branch revision 171639] (GCC) ) #1031 SMP 
> Thu Jun 9 15:44:46 PDT 2011
> octeon:~# head /proc/cpuinfo
> system type		: EBT3000 (CN3860p3.X-500-NSP)
> processor		: 0
> cpu model		: Cavium Octeon V0.3
> BogoMIPS		: 1000.00
> wait instruction	: yes
> microsecond timers	: yes
> tlb_entries		: 32
> extra interrupt vector	: yes
> hardware watchpoint	: yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
> ASEs implemented	:
> 
> 
> Boots on all 16 CPUs.

Hi David,

Turns out my primary problem is that octeon_irq_setup_secondary_ciu()
sets C0_STATUS to 0x1000efe0, ie all interrupts except IP4 are enabled.
This mask is primarily set through octeon_irq_percpu_enable(), which
sets C0_STATUS to 0x1000e3e0. The value differs from CPU 0, where
C0_STATUS is set to 0x10008ce0.

This causes persistent spurious interrupts on our boards (both with
CN38xx and CN58xx), where C0_CAUSE persistently reads as zero in the
interrupt handling code but interrupts are triggered anyway. The
spurious interrupt problem goes away if I mask out IP0, IP1, IP5, and
IP6 at the end of octeon_irq_setup_secondary_ciu().

There is some other problem later on (maybe I disabled too much or
something else is wrong), but with the mask changes the SMP boot
proceeds to:

calling  tcp_congestion_default+0x0/0xc @ 1
initcall tcp_congestion_default+0x0/0xc returned 0 after 1 usecs
calling  initialize_hashrnd+0x0/0x28 @ 1
initcall initialize_hashrnd+0x0/0x28 returned 0 after 11 usecs
 Return from do_initcalls [ this is an added log message ]
open console
Warning: unable to open an initial console.
checking ramdisk
async_waiting @ 1

before I get another hangup.

I'll track that one down next. Key question right now, though, is why
the secondary CPU boot code enables (almost) all interrupts. Any idea ?

Thanks,
Guenter
