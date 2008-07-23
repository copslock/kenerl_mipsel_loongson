Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 18:46:01 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:21216 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28577450AbYGWRp7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 18:45:59 +0100
Received: (qmail 6123 invoked by uid 1000); 23 Jul 2008 19:45:57 +0200
Date:	Wed, 23 Jul 2008 19:45:57 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v3 0/8] Alchemy updates
Message-ID: <20080723174557.GA5986@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19932
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Here's a new set of patches to modernize Alchemy setup and PM code.
All patches have been compile-tested with db100 and db1200 defconfigs,
and have been runnning on a few custom Au1250 boards for now more than
4 weeks.  I've suspended and resumed a few hundred times while stressing
the system (continuously reading from SD cards and playing audio and
compiling GCC) without any problems.

#1 removes unussed functions
#2 removes the cpu_table and replaces it with simpler code (IMHO of course)
#3 enables use of cp0 counter as a fallback,
#4 clockevent/clocksource support using one of the 2 counters of the Au1xxx
   this also enables the use of the 'wait' instruction; depends on #3
#5 cleanup made possible with #4 
#7 and #8 fix suspend/resume.

I didn't touch the current Alchemy sysctl PM implementation to not change
existing behavior except when necessary (e.g. in #4), although I'm
itching to remove it completely and replace it with something better
suited (and -looking) for 2.6.  It is broken for newer Alchemy SoCs anyway.


Changes V2->V3:
- swap patches 1 and 2 
- minor refinements, no function changes.

Changes V1->V2:
- address Sergei's comments wrt. config[OD] handling
- change TOY clocksource to RTC clocksource
- add another patch (#5)


Thanks,
	Manuel Lauss
