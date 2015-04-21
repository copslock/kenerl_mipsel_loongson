Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 17:41:38 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:60694 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006895AbbDUPlhTTwbl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Apr 2015 17:41:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=U9CccwSj7zWPfS91jRH531xX0Kgp+fqOCK2/3/L9WY8=;
        b=OEM/XUbQa1pTHM3lG17QYP7B4Uib27Hgi3Uwo8CRd7gXmQgS5q9lHboSG0HxxO+i8USF2mDK63ZWGu4rRuj7aUEdBDA7gGBZPeCk3C/KSV3026OUXpJ6k5i3FVrw8EvUOzfmh6pN49D9dp2o7JgrqthQ6MDxS3OQgxphXXtq23o=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YkaIm-002QEB-N2
        for linux-mips@linux-mips.org; Tue, 21 Apr 2015 15:41:32 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49592 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1YkaIP-002Q7a-Tv; Tue, 21 Apr 2015 15:41:11 +0000
Date:   Tue, 21 Apr 2015 08:41:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
Message-ID: <20150421154108.GA20223@roeck-us.net>
References: <20150420194028.GA10814@roeck-us.net>
 <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
 <87fv7up15k.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fv7up15k.fsf@rustcorp.com.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.55366FAD.0052,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 6
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Tue, Apr 21, 2015 at 01:45:35PM +0930, Rusty Russell wrote:
> Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> > Hi,
> >
> > On Mon, Apr 20, 2015 at 12:40:28PM -0700, Guenter Roeck wrote:
> >> the upstream kernel fails to build mips:nlm_xlp_defconfig,
> >> mips:nlm_xlp_defconfig, mips:cavium_octeon_defconfig, and possibly
> >> other targets, with errors such as
> >> 
> >> arch/mips/kernel/smp.c:211:2: error:
> >> 	passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier
> >> 	from pointer target type
> >> arch/mips/kernel/process.c:52:2: error:
> >> 	passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier
> >> 	from pointer target type
> >> arch/mips/cavium-octeon/smp.c:242:2: error:
> >> 	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier
> >> 	from pointer target type
> >> 
> >> The problem was introduced with commit 8dd928915a73 (" mips: fix up
> >> obsolete cpu function usage"). I would send a patch to fix it, but I
> >> am not sure if removing 'volatile' from the variable declaration(s)
> >> would be a good idea.
> >
> > I think removing volatile from cpu_callin_map declaration should be OK,
> > since test_cpu (only reader) uses test_bit which takes care of it:
> >
> > 	static inline int test_bit(int nr, const volatile unsigned long *addr)
> 
> No, that got replaced too, with cpumask_test_cpu AFAICT.
> 
> You can open-code it, like so:
> 
>         test_bit(0, cpumask_bits(cpu_callin_map));
> 
> But you probably want to put a barrier in that loop instead of relying
> on volatile.
> 
The following might do it. Note that I can not really test it since I don't have
a real mips system, and qemu gets rcu hangs if I enable more than one CPU (I see
that with older kernels as well, so it is not a new problem). Someone will have
to test the patch on a real multi-core system.

Guenter

---
From 94026cc98a6b7b3567780a5443674c71202e2497 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 Apr 2015 08:31:01 -0700
Subject: [PATCH] mips: Fix SMP builds
Content-Length: 2261
Lines: 65

Mips SMP builds fail with error messages similar to the following.

arch/mips/kernel/smp.c:211:2: error:
	passing argument 2 of 'cpumask_set_cpu' discards 'volatile'
	qualifier from pointer target type
arch/mips/kernel/process.c:52:2: error:
	passing argument 2 of 'cpumask_test_cpu' discards 'volatile'
	qualifier from pointer target type
arch/mips/cavium-octeon/smp.c:242:2: error:
	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile'
	qualifier from pointer target type

cpu_callin_map is declared as volatile variable, but passed to various
functions with non-volatile arguments. Make it non-volatile and add a
memory barrier at the one location where volatile might be needed.

Fixes: 8dd928915a73 ("mips: fix up obsolete cpu function usage")
Cc: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/include/asm/smp.h | 2 +-
 arch/mips/kernel/smp.c      | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index bb02fac9b4fa..2b25d1ba1ea0 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -45,7 +45,7 @@ extern int __cpu_logical_map[NR_CPUS];
 #define SMP_DUMP		0x8
 #define SMP_ASK_C0COUNT		0x10
 
-extern volatile cpumask_t cpu_callin_map;
+extern cpumask_t cpu_callin_map;
 
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 193ace7955fb..158191394770 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -43,7 +43,7 @@
 #include <asm/time.h>
 #include <asm/setup.h>
 
-volatile cpumask_t cpu_callin_map;	/* Bitmask of started secondaries */
+cpumask_t cpu_callin_map;		/* Bitmask of started secondaries */
 
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
 EXPORT_SYMBOL(__cpu_number_map);
@@ -218,8 +218,10 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	/*
 	 * Trust is futile.  We should really have timeouts ...
 	 */
-	while (!cpumask_test_cpu(cpu, &cpu_callin_map))
+	while (!cpumask_test_cpu(cpu, &cpu_callin_map)) {
 		udelay(100);
+		mb();
+	}
 
 	synchronise_count_master(cpu);
 	return 0;
-- 
2.1.0
