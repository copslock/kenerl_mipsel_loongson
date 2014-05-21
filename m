Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 08:46:31 +0200 (CEST)
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:56944
        "EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821198AbaEUGq26OpK7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 08:46:28 +0200
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
        by qmta13.westchester.pa.mail.comcast.net with comcast
        id 4WlB1o0081YDfWL5DWmN8X; Wed, 21 May 2014 06:46:22 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta20.westchester.pa.mail.comcast.net with comcast
        id 4WmM1o00V0JZ7Re3gWmN4u; Wed, 21 May 2014 06:46:22 +0000
Message-ID: <537C4BB6.8060400@gentoo.org>
Date:   Wed, 21 May 2014 02:46:14 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: SGI Octane & SMP, stuck in calibrate_delay(), help?
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1400654782;
        bh=ar+b3vIykWh82f17SMtiFRmD3LQX/F1hlyjUqY1A9Ys=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=tFo468ueOYY5IbAPDAd5uIo7pQjCZNG+M2IpVHqPrU1j2MpKtYpJ3RZC/x3Tui/OG
         AgEyxbV1k07U5wD2uJhQkYwP7U+UkRGpydhXgJmjkYJN6Dwwd/pK/DYAugskrol6YA
         QMBH/AC47EMBwVDzPmHzaMNnOPU7Q97Q4GvGMaFM1cKKhB4w45KJCpjst35gAi5ozr
         n5rtBoSFCNCYA8C8mwrXF5QllZjZCZ0qRu0+DlU2Bo9xtv3mbhC87W4Wu3X43gasyH
         Ygm5lj607xHgSixMAjBxDo9If8REF3HkuPo2MgtzbSsQHtDhYQzmquk+dwE37tFPmZ
         E6+XQlZnyRllw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

So I've been messing around with getting the SGI Octane to boot Linux again,
using some old patches I was sent several years ago, but forgot about
(credit goes to Tanzy for creating them).  A *lot* of devices are really
slow, however.  I suspect problems with the way I've got the IRQ handling
set up at the moment.  I.e., hdparm -t on MD-RAID SCSI reports 9MB/sec if
you boot with init=/bin/bash, or ~4.5MB/sec if I boot it normally.  It is
running an old Gentoo userland from ~2009, however, and there may be
something screwy w/ a modern (3.14.3) kernel against such an old userland.

Right now, though, I am trying to get SMP working (again).  I've gotten
IPI's setup via a percpu mailbox, but bringing up the second CPU is proving
to be very problematic.  It's hanging up in calibrate_delay(), when called
from arch/mips/kernel/smp.c::start_secondary().

Currently:
 - ip30_prepare_cpus: Acquires IPI IRQ for CPU0, unmasks STATUSF_IP4 (IPI).
 - ip30_boot_secondary: Sets sp/gp on CPU1 and boots it up. [1]
 - ip30_init_secondary: Unmasks STATUSF_IP{2,3,4,5,6,7} on CPU1 [2]
 - ip30_smp_finish: Acquires IPI IRQ for CPU1, enables local interrupts.

Notes:
1. I have discovered that if a printk() or pr_*() function is NOT placed
immediately at the end of the function, CPU1 is never launched.  This
appears to kickstart the CPU so that it probes itself and reports data to
dmesg.  Has anyone else seen this on other SMP platforms?

2. From reading other MIPS SMP implementations, all I need to do in
mp_ops->init_secondary is to set the interrupt mask bits in the CAUSE
register.  But this is where the machine hangs in calibrate_delay().  I
tried adding local_irq_enable() immediately after, which I know isn't
correct (that belongs in smp_finish), and that gets it to tick a few times,
but then it stops again.

This system uses the CONFIG_CEVT_R4K and CONFIG_CSRC_R4K for the CPU timers,
but it looks like cevt-r4k.c is rigged to only install one CPU timer -- any
other calls by other CPUs returns out of the r4k_clockevent_init function
early.  Older IP30 code included timer broadcasting bits, too, but these
were using IRQs that were hardwired to other functions in HEART (the system
ASIC/interrupt controller), so I dropped that approach.  I also don't think
they were compatible w/ the clockevent code added in ~2.6.24.

So, I am out of ideas.  Anyone got other ideas to try?

Thanks!,

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
