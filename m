Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2015 10:07:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37019 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007169AbbFCIHBm3UBx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Jun 2015 10:07:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t53870PQ012472;
        Wed, 3 Jun 2015 10:07:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t53870cM012471;
        Wed, 3 Jun 2015 10:07:00 +0200
Date:   Wed, 3 Jun 2015 10:07:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: IP27: Update/restructure CPU overrides
Message-ID: <20150603080700.GG9839@linux-mips.org>
References: <556E2833.8060407@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556E2833.8060407@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47826
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

On Tue, Jun 02, 2015 at 06:03:31PM -0400, Joshua Kinard wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> 
> Inspired by Maciej's recent patch to update DEC cpu-feature-overrides.h,
> I updated IP27's as well to disable features known to not apply to the
> IP27 platform or the R10K-series of CPUs.
> 
> Before:
>    text    data     bss     dec     hex filename
> 8616648  463200  472240 9552088  91c0d8 vmlinux
> 
> After:
>    text    data     bss     dec     hex filename
> 8592256  471392  472240 9535888  918190 vmlinux
> 
> I believe the increase in the size of the data section is for the same
> reasons as in the DEC patch.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  arch/mips/include/asm/mach-ip27/cpu-feature-overrides.h |   92 ++++++----
>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> The number of changes is due to restructuring the file to be similar to
> IP30's, so that eventually, all of the SGI platforms will have a similar
> look to their cpu-feature-overrides.h file, making it easier to update
> in the future.  I'll also send one for IP32 shortly, as that needs some
> more careful updating due to the various CPUs it supports.

Kernel bloat due to incomplete overrides.h files is a well known problem.
It's also somewhat hard problem since writing one requires intimate
knowledge of the CPU.  That used to be easy for the classic discrete
CPUs but with synthesizable cores many options can differ between
instances of that core.  Anyway, the solution I'm thinking off should
be no more complex that for example saying

#include <asm/cpus/r4000.h>
#include <asm/cpus/r4600.h>
#include <asm/cpus/r5000.h>

for an IP22.  Or something similarly obvious.

Patch queued for 4.2.

Thanks!

  Ralf
