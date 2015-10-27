Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 15:47:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35372 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011384AbbJ0OruxCKS2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Oct 2015 15:47:50 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t9RElnnI024057;
        Tue, 27 Oct 2015 15:47:49 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t9RElnkE024056;
        Tue, 27 Oct 2015 15:47:49 +0100
Date:   Tue, 27 Oct 2015 15:47:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
Message-ID: <20151027144748.GA23785@linux-mips.org>
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
 <5629904A.2070400@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5629904A.2070400@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Oct 22, 2015 at 06:41:30PM -0700, Leonid Yegoshin wrote:

> You can not use R4K CP0_count in SMP (multicore) without core-specific
> adjustment.
> After first power-saving with core clock off or core down the values in
> CP0_count
> in different cores are absolutely different.
> 
> Until you include in system a patch like
> http://patchwork.linux-mips.org/patch/10871/
> 
>     "MIPS: Setup an instruction emulation in VDSO protected page instead of
> user stack"
> 
> which creates a per-thread memory and put into that memory an adjustment
> value
> (which can be changed during re-schedule to another core), the use of R4K
> counter is incorrect
> in SMP environment.
> 
> Note: It is also possible to setup and maintain a per-core page with that
> value too as
> an alternative variant for adjustment.

The CPU hot plugging code is supposed to resychronize the counters when
a CPU is coming online again so that case should be handled.  Beyond that
the r4k timer code in the kernel also doesn't support clock scaling
so I'm ok if the VDSO series doesn't support this properly.

  Ralf
