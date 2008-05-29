Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:07:28 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:11433 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28575640AbYE2UFY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 21:05:24 +0100
Received: from elvis.franken.de ([193.175.24.41]:32749 "EHLO elvis.franken.de")
	by lappi.linux-mips.net with ESMTP id S1106895AbYE2UFS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 May 2008 22:05:18 +0200
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1K1oNB-0007x3-00; Thu, 29 May 2008 22:05:17 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 323171DA74B; Thu, 29 May 2008 22:05:07 +0200 (CEST)
Date:	Thu, 29 May 2008 22:05:07 +0200
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Malta build errors with 2.6.26-rc1
Message-ID: <20080529200506.GA27783@alpha.franken.de>
References: <20080512163107.GA19052@deprecation.cyrius.com> <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com> <20080528071240.GB10393@deprecation.cyrius.com> <20080528085033.GA6250@alpha.franken.de> <20080528151025.GA15325@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080528151025.GA15325@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, May 28, 2008 at 05:10:25PM +0200, Martin Michlmayr wrote:
> * Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2008-05-28 10:50]:
> > I didn't fix the problems above. The change to traps.c only fixes
> > traps.c for 64bit builds and it's a totally different issue. Looking
> > at the warning/errors someone needs to fix some data types and use
> > CKSEG0ADDR(). I don't have the hardware, so I could only provide an
> > untested patch, if no one else steps forward...
> 
> QEMU emulates Malta, so I (or someone else here) should be able to
> test the patch.


Fix 64bit Malta by using CKSEG0ADDR and correct casts

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/mips-boards/generic/amon.c |    4 ++--
 include/asm-mips/gic.h               |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mips-boards/generic/amon.c b/arch/mips/mips-boards/generic/amon.c
index b7633fd..96236bf 100644
--- a/arch/mips/mips-boards/generic/amon.c
+++ b/arch/mips/mips-boards/generic/amon.c
@@ -28,7 +28,7 @@
 
 int amon_cpu_avail(int cpu)
 {
-	struct cpulaunch *launch = (struct cpulaunch *)KSEG0ADDR(CPULAUNCH);
+	struct cpulaunch *launch = (struct cpulaunch *)CKSEG0ADDR(CPULAUNCH);
 
 	if (cpu < 0 || cpu >= NCPULAUNCH) {
 		pr_debug("avail: cpu%d is out of range\n", cpu);
@@ -53,7 +53,7 @@ void amon_cpu_start(int cpu,
 		    unsigned long gp, unsigned long a0)
 {
 	volatile struct cpulaunch *launch =
-		(struct cpulaunch  *)KSEG0ADDR(CPULAUNCH);
+		(struct cpulaunch  *)CKSEG0ADDR(CPULAUNCH);
 
 	if (!amon_cpu_avail(cpu))
 		return;
diff --git a/include/asm-mips/gic.h b/include/asm-mips/gic.h
index 3a492f2..954807d 100644
--- a/include/asm-mips/gic.h
+++ b/include/asm-mips/gic.h
@@ -24,8 +24,8 @@
 
 #define MSK(n) ((1 << (n)) - 1)
 #define REG32(addr)		(*(volatile unsigned int *) (addr))
-#define REG(base, offs)		REG32((unsigned int)(base) + offs##_##OFS)
-#define REGP(base, phys)	REG32((unsigned int)(base) + (phys))
+#define REG(base, offs)		REG32((unsigned long)(base) + offs##_##OFS)
+#define REGP(base, phys)	REG32((unsigned long)(base) + (phys))
 
 /* Accessors */
 #define GIC_REG(segment, offset) \


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
