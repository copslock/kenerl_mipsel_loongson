Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 22:34:03 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:44871 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20032780AbYG2Vd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 22:33:58 +0100
Received: from 10.8.0.25 ([10.8.0.25]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Tue, 29 Jul 2008 21:33:49 +0000
Received: from kh-ubuntu by webmail.razamicroelectronics.com; 29 Jul 2008 16:33:54 -0500
Subject: Re: [PATCH v4 0/10] Alchemy updates.
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080729165853.GB8784@roarinelk.homelinux.net>
References: <20080729165853.GB8784@roarinelk.homelinux.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:	Tue, 29 Jul 2008 16:33:54 -0500
Message-Id: <1217367234.13597.11.camel@kh-ubuntu.razamicroelectronics.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Manuel,

Thanks for sending these out again.  I've patched my tree (an up-to-date
git of 2.6.27-rc1) and have some preliminary feedback:
1.  I like the interface you added in patch #10.  Much better than the
old /proc one and flexible enough for a lot of different boards.  I
agree with your own comment that maybe it should be in the
board-specific directories so that people can name the nodes better, but
for now I think this is great.

2.  If I use the db1200_defconfig and enable Power Management
(CONFIG_PM), the build fails on the Au1xxx IDE and fb drivers.  Are you
seeing this too?  I see no reason to reject this patch if they don't
build with CONFIG_PM, I just want to make sure I'm not doing something
wrong.

3.  In my preliminary testing, the system was able to suspend and resume
correctly on a DB1200 board.  I will do some stress testing in the next
couple of days to make sure that it is stable in the long term. 

Thanks again.
-Kevin


On Tue, 2008-07-29 at 18:58 +0200, Manuel Lauss wrote:
> Hello,
> 
> Here's again a new set of patches to modernize Alchemy setup and PM code.
> All patches have been compile-tested with db1100 and db1200 defconfigs,
> and have been runnning on a few custom Au1250 boards for now more than
> 5 weeks.  I've suspended and resumed a few hundred times while stressing
> the system (continuous SD + CF reads while playing some wave files and
> compiling sources).
> 
> #1 removes unused functions
> #2 removes the cpu_table and replaces it with simpler code (IMHO of course)
> #3 enables use of cp0 counter as a fallback,
> #4 clockevent/clocksource support using one of the 2 counters of the Au1xxx
>    this also enables the use of the 'wait' instruction; depends on #3
> #5 cleanup made possible with #4 
> #7 and #8 fix suspend/resume.
> #9 adds DBDMA suspend/resume support.
> #10 replaces sysctl suspend interface with something better (IMO).
> 
> All patches depend on each other, have been run-tested on a custom AU1200
> system and compile-tested with a minimal config on db1100 and db1200.
> 
> Changes V3->V4:
> - rediffed against 2.6.27-rc1
> - add patch #10.
> 
> Changes V2->V3:
> - swap patches 1 and 2 
> - minor refinements, no function changes.
> 
> Changes V1->V2:
> - address Sergei's comments wrt. config[OD] handling
> - change TOY clocksource to RTC clocksource
> - add another patch (#5)
> 
> 
>  arch/mips/Kconfig                     |    8 
>  arch/mips/au1000/Kconfig              |    4 
>  arch/mips/au1000/common/Makefile      |    4 
>  arch/mips/au1000/common/clocks.c      |   65 +++--
>  arch/mips/au1000/common/cputable.c    |   52 ----
>  arch/mips/au1000/common/dbdma.c       |   65 +++++
>  arch/mips/au1000/common/dbg_io.c      |    4 
>  arch/mips/au1000/common/irq.c         |   57 ----
>  arch/mips/au1000/common/platform.c    |  257 ++++++++++++++++++++
>  arch/mips/au1000/common/power.c       |  421 ++++++----------------------------
>  arch/mips/au1000/common/setup.c       |   39 ---
>  arch/mips/au1000/common/sleeper.S     |  121 +++++----
>  arch/mips/au1000/common/time.c        |  305 ++++++++----------------
>  arch/mips/au1000/db1x00/Makefile      |    1 
>  arch/mips/au1000/mtx-1/Makefile       |    2 
>  arch/mips/au1000/pb1000/Makefile      |    1 
>  arch/mips/au1000/pb1100/Makefile      |    1 
>  arch/mips/au1000/pb1200/Makefile      |    2 
>  arch/mips/au1000/pb1500/Makefile      |    1 
>  arch/mips/au1000/pb1550/Makefile      |    1 
>  arch/mips/au1000/xxs1500/Makefile     |    1 
>  arch/mips/kernel/Makefile             |    4 
>  arch/mips/kernel/cevt-r4k.c           |    2 
>  arch/mips/kernel/csrc-r4k.c           |    2 
>  include/asm-mips/mach-au1x00/au1000.h |   64 +++--
>  include/asm-mips/time.h               |   24 +
>  26 files changed, 719 insertions(+), 789 deletions(-)
> 
> Thanks,
> 	Manuel Lauss
> 
-- 
Kevin Hickey
﻿Alchemy Solutions
RMI Corporation
khickey@RMICorp.com
P: 512.691.8044
