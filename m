Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Mar 2016 06:27:04 +0100 (CET)
Received: from forward.webhostbox.net ([5.100.155.124]:48462 "EHLO
        forward.webhostbox.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006622AbcCOF1BbbK0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Mar 2016 06:27:01 +0100
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
        by forward.webhostbox.net (Postfix) with ESMTP id 62F4755C09EF;
        Tue, 15 Mar 2016 05:26:59 +0000 (GMT)
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:34698 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1afhVU-0027Qr-4m; Tue, 15 Mar 2016 05:27:00 +0000
Date:   Mon, 14 Mar 2016 22:26:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for Mar 14 (mips qemu failure bisected)
Message-ID: <20160315052659.GA9320@roeck-us.net>
References: <20160314174037.0097df55@canb.auug.org.au>
 <20160314143729.GA31845@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160314143729.GA31845@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.1 cv=NfdGrz34 c=1 sm=1 tr=0
        a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
        a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
        a=7OsogOcEt9IA:10 a=r8N4ijXKTd2s8t9S8RsA:9 a=CjuIK1q_8ugA:10
Return-Path: <SRS0+9QRA=PL=roeck-us.net=linux@forward.webhostbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52589
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

On Mon, Mar 14, 2016 at 07:37:29AM -0700, Guenter Roeck wrote:
> On Mon, Mar 14, 2016 at 05:40:37PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20160311:
> > 
> > The vfs tree gained a conflict against Linus' tree. I also applied a
> > patch for a known runtime bug.
> > 
> > The tip tree gained a conflict against the mips tree.
> > 
> > The aio tree still had a build failure so I removed several commits
> > from it.  It also gained a conflict against the vfs tree.
> > 
> > Non-merge commits (relative to Linus' tree): 11202
> >  8646 files changed, 426680 insertions(+), 211740 deletions(-)
> > 
> 
> To give people an idea what to expect in the merge window, here are my current
> build and runtime test results. Some of the runtime failures are due to the
> newly introduced i2c bug, but many (including the arm64 boot failures) have
> been around for a while.
> 
[ ... ]

> Qemu test results:
> 	total: 96 pass: 69 fail: 27
> Failed tests:
[ ... ]
> 	mips:mips_malta_smp_defconfig

I bisected this failure to commit bb11cff327e54 ("MIPS: Make smp CMP, CPS and MT
use the new generic IPI functions". Bisect log is attached.

> 	mips64:smp:mips_malta64_defconfig
> 	mips:mipsel_malta_smp_defconfig
> 	mips:mipsel_malta64_smp_defconfig

If necessary I can repeat the bisect for those. Please let me know.

Thanks,
Guenter

---
Bisect log:

# bad: [4342eec3c5a2402ca5de3d6e56f541fe1c5171e2] Add linux-next specific files for 20160314
# good: [f6cede5b49e822ebc41a099fe41ab4989f64e2cb] Linux 4.5-rc7
git bisect start 'HEAD' 'v4.5-rc7'
# good: [0525c3e26ec2c43cd509433be3be25210a0154ef] Merge remote-tracking branch 'drm-tegra/drm/tegra/for-next'
git bisect good 0525c3e26ec2c43cd509433be3be25210a0154ef
# bad: [385128a1b49762c1b9515c9f6294aeebbc55b956] Merge remote-tracking branch 'usb-chipidea-next/ci-for-usb-next'
git bisect bad 385128a1b49762c1b9515c9f6294aeebbc55b956
# good: [dfdb27baab4fc45c9399a991270413d0fb1c694a] Merge remote-tracking branch 'spi/for-next'
git bisect good dfdb27baab4fc45c9399a991270413d0fb1c694a
# bad: [e368d7d2a0dce6d6795ead1fc8a09bcca8a4a565] Merge branch 'timers/nohz'
git bisect bad e368d7d2a0dce6d6795ead1fc8a09bcca8a4a565
# good: [ced30bc9129777d715057d06fc8dbdfd3b81e94d] Merge tag 'perf-core-for-mingo-20160310' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
git bisect good ced30bc9129777d715057d06fc8dbdfd3b81e94d
# bad: [656a61d4d9cbb8dfc2d007281190b2eccebad522] manual merge of mm/pkeys
git bisect bad 656a61d4d9cbb8dfc2d007281190b2eccebad522
# good: [16f7379f2da43f29d9faa2f474745e2705a3f510] Merge branch 'efi/core'
git bisect good 16f7379f2da43f29d9faa2f474745e2705a3f510
# bad: [a7fb9a8169be9a55e0cfb98346aece1b51c016fa] Merge branch 'locking/core'
git bisect bad a7fb9a8169be9a55e0cfb98346aece1b51c016fa
# good: [2a07870511829977d02609dac6450017b0419ea9] irqchip/mips-gic: Use gic_vpes instead of NR_CPUS
git bisect good 2a07870511829977d02609dac6450017b0419ea9
# good: [eaff0e7003cca6c2748b67ead2d4b1a8ad858fc7] locking/pvqspinlock: Move lock stealing count tracking code into pv_queued_spin_steal_lock()
git bisect good eaff0e7003cca6c2748b67ead2d4b1a8ad858fc7
# good: [013e379a3094ff2898f8d33cfbff1573d471ee14] tools/lib/lockdep: Fix link creation warning
git bisect good 013e379a3094ff2898f8d33cfbff1573d471ee14
# bad: [7eb8c99db26cc6499bfb1eba72dffc4730570752] MIPS: Delete smp-gic.c
git bisect bad 7eb8c99db26cc6499bfb1eba72dffc4730570752
# good: [fbde2d7d8290d8c642d591a471356abda2446874] MIPS: Add generic SMP IPI support
git bisect good fbde2d7d8290d8c642d591a471356abda2446874
# bad: [bb11cff327e54179c13446c4022ed4ed7d4871c7] MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
git bisect bad bb11cff327e54179c13446c4022ed4ed7d4871c7
# first bad commit: [bb11cff327e54179c13446c4022ed4ed7d4871c7] MIPS: Make smp CMP, CPS and MT use the new generic IPI functions
