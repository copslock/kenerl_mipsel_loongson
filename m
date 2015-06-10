Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 17:57:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47513 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008049AbbFJP5Qv1XKu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Jun 2015 17:57:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t5AFvETF008613;
        Wed, 10 Jun 2015 17:57:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t5AFv9Zj008611;
        Wed, 10 Jun 2015 17:57:09 +0200
Date:   Wed, 10 Jun 2015 17:57:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: HAVE_CMPXCHG_LOCAL arch support.
Message-ID: <20150610155709.GH2753@linux-mips.org>
References: <55759543.1010408@gmail.com>
 <20150610145804.GG2753@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150610145804.GG2753@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47919
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

On Wed, Jun 10, 2015 at 04:58:04PM +0200, Ralf Baechle wrote:

> On Mon, Jun 08, 2015 at 03:14:43PM +0200, Xose Vazquez Perez wrote:
> 
> > If there is anything wrong, please report it in this thread:
> > https://marc.info/?t=143332955700003
> 
> 
> >    locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
> 
> This one was easy - we have the functions in the code just no "select
> HAVE_CMPXCHG_LOCAL" Kconfig.

Something's wrong there.  The new file
Documentation/features/locking/cmpxchg-local/arch-support.txt in linux-next
claims correctly that only s390 and x86 define HAVE_CMPXCHG_LOCAL.  And a
git grep -w cmpxchg_local finds that in addition to these alpha, arm, arm64,
avr32, blackfin, c6x, frv, ia64, m32r, m68k, mips, parisc, powerpc, sparc,
unicore32 and xtensa define cmpxchg_local.

These architectures seem to not define cmpxchg_local in their arch/ dir:

  arc cris hexagon metag microblaze mn10300 nios2 openrisc score sh tile um

Microblaze and nios2 include <asm-generic/cmpxchg.h> into their arch
cmpxchg.h so they get a definition of these functions but don't define
HAVE_CMPXCHG_LOCAL.  Peter Zijlstra said it the local versions are ~ 20
cycles faster on x86 than the "global" version.  But I've found one user
of cmpxchg_local, mm/vmstat.c and one user of cmpxchg64_local,
drivers/iommu/intel-iommu.c.  Sure, fixing the issue was trivial for me
on MIPS but is having cmpxchg{,64}_local actually worth it?  

Cheers,

  Ralf
