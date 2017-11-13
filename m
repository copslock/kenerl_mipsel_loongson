Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 17:06:45 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:60390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990425AbdKMQGi5ktSu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 17:06:38 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38B1BAAC1;
        Mon, 13 Nov 2017 16:06:38 +0000 (UTC)
Date:   Mon, 13 Nov 2017 17:06:37 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: linux-next: Tree for Nov 7
Message-ID: <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
References: <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

[Sorry for spamming, this one is the last attempt hopefully]

On Mon 13-11-17 16:49:39, Michal Hocko wrote:
> On Mon 13-11-17 16:16:41, Michal Hocko wrote:
> > On Mon 13-11-17 13:00:57, Michal Hocko wrote:
> > [...]
> > > Yes, I have mentioned that in the previous email but the amount of code
> > > would be even larger. Basically every arch which reimplements
> > > arch_get_unmapped_area would have to special case new MAP_FIXED flag to
> > > do vma lookup.
> > 
> > It turned out that this might be much more easier than I thought after
> > all. It seems we can really handle that in the common code. This would
> > mean that we are exposing a new functionality to the userspace though.
> > Myabe this would be useful on its own though. Just a quick draft (not
> > even compile tested) whether this makes sense in general. I would be
> > worried about unexpected behavior when somebody set other bit without a
> > good reason and we might fail with ENOMEM for such a call now.
> 
> Hmm, the bigger problem would be the backward compatibility actually. We
> would get silent corruptions which is exactly what the flag is trying
> fix. mmap flags handling really sucks. So I guess we would have to make
> the flag internal only :/

OK, so this one should take care of the backward compatibility while
still not touching the arch code
---
commit 39ff9bf8597e79a032da0954aea1f0d77d137765
Author: Michal Hocko <mhocko@suse.com>
Date:   Mon Nov 13 17:06:24 2017 +0100

    mm: introduce MAP_FIXED_SAFE
    
    MAP_FIXED is used quite often but it is inherently dangerous because it
    unmaps an existing mapping covered by the requested range. While this
    might be might be really desidered behavior in many cases there are
    others which would rather see a failure than a silent memory corruption.
    Introduce a new MAP_FIXED_SAFE flag for mmap to achive this behavior.
    It is a MAP_FIXED extension with a single exception that it fails with
    ENOMEM if the requested address is already covered by an existing
    mapping. We still do rely on get_unmaped_area to handle all the arch
    specific MAP_FIXED treatment and check for a conflicting vma after it
    returns.
    
    Signed-off-by: Michal Hocko <mhocko@suse.com>

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 3b26cc62dadb..767bcb8a4c28 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -31,6 +31,8 @@
 #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
 
+#define MAP_FIXED_SAFE 0x2000000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
 #define MS_INVALIDATE	4		/* invalidate the caches */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index da3216007fe0..c2311eb7219b 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -49,6 +49,8 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 
+#define MAP_FIXED_SAFE 0x2000000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
 /*
  * Flags for msync
  */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index cc9ba1d34779..b06fd830bc6f 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -25,6 +25,8 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 
+#define MAP_FIXED_SAFE 0x2000000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
 #define MS_INVALIDATE	4		/* invalidate the caches */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index b15b278aa314..f4b291bca764 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -62,6 +62,8 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
+#define MAP_FIXED_SAFE 0x2000000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
 /*
  * Flags for msync
  */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 203268f9231e..03c518777f83 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -25,6 +25,8 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
+#define MAP_FIXED_SAFE 0x2000000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
 /*
  * Flags for mlock
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 680506faceae..aad8d37f0205 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1358,6 +1358,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/* force arch specific MAP_FIXED handling in get_unmapped_area */
+	if (flags & MAP_FIXED_SAFE)
+		flags |= MAP_FIXED;
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
@@ -1365,6 +1369,13 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (offset_in_page(addr))
 		return addr;
 
+	if (flags & MAP_FIXED_SAFE) {
+		struct vm_area_struct *vma = find_vma(mm, addr);
+
+		if (vma && vma->vm_start <= addr)
+			return -ENOMEM;
+	}
+
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(mm);
 		if (pkey < 0)

-- 
Michal Hocko
SUSE Labs
