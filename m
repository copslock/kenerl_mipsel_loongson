Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2015 18:00:05 +0200 (CEST)
Received: from casper.infradead.org ([85.118.1.10]:41359 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008049AbbFJQAEGAgAu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2015 18:00:04 +0200
Received: from 178-85-85-44.dynamic.upc.nl ([178.85.85.44] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1Z2iQ6-0003Jw-QQ; Wed, 10 Jun 2015 16:00:02 +0000
Received: by twins (Postfix, from userid 1000)
        id 5CE701254D760; Wed, 10 Jun 2015 18:00:00 +0200 (CEST)
Message-ID: <1433952000.1495.56.camel@twins>
Subject: Re: HAVE_CMPXCHG_LOCAL arch support.
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Date:   Wed, 10 Jun 2015 18:00:00 +0200
In-Reply-To: <20150610155709.GH2753@linux-mips.org>
References: <55759543.1010408@gmail.com>
         <20150610145804.GG2753@linux-mips.org>
         <20150610155709.GH2753@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Wed, 2015-06-10 at 17:57 +0200, Ralf Baechle wrote:
> On Wed, Jun 10, 2015 at 04:58:04PM +0200, Ralf Baechle wrote:
> 
> > On Mon, Jun 08, 2015 at 03:14:43PM +0200, Xose Vazquez Perez wrote:
> > 
> > > If there is anything wrong, please report it in this thread:
> > > https://marc.info/?t=143332955700003
> > 
> > 
> > >    locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
> > 
> > This one was easy - we have the functions in the code just no "select
> > HAVE_CMPXCHG_LOCAL" Kconfig.
> 
> Something's wrong there.  The new file
> Documentation/features/locking/cmpxchg-local/arch-support.txt in linux-next
> claims correctly that only s390 and x86 define HAVE_CMPXCHG_LOCAL.  And a
> git grep -w cmpxchg_local finds that in addition to these alpha, arm, arm64,
> avr32, blackfin, c6x, frv, ia64, m32r, m68k, mips, parisc, powerpc, sparc,
> unicore32 and xtensa define cmpxchg_local.
> 
> These architectures seem to not define cmpxchg_local in their arch/ dir:
> 
>   arc cris hexagon metag microblaze mn10300 nios2 openrisc score sh tile um
> 
> Microblaze and nios2 include <asm-generic/cmpxchg.h> into their arch
> cmpxchg.h so they get a definition of these functions but don't define
> HAVE_CMPXCHG_LOCAL.  Peter Zijlstra said it the local versions are ~ 20
> cycles faster on x86 than the "global" version.  But I've found one user
> of cmpxchg_local, mm/vmstat.c and one user of cmpxchg64_local,
> drivers/iommu/intel-iommu.c.  Sure, fixing the issue was trivial for me
> on MIPS but is having cmpxchg{,64}_local actually worth it?  

If you traverse the obfuscation chain a little, you'll find that
local_cmpxchg() is implemented using cmpxchg_local(), and there are a
few more users of that.
