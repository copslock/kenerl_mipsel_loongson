Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 16:16:55 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:57232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990426AbdKMPQrtgXVD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 16:16:47 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2C9FAAC1;
        Mon, 13 Nov 2017 15:16:43 +0000 (UTC)
Date:   Mon, 13 Nov 2017 16:16:41 +0100
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
Message-ID: <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60875
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

On Mon 13-11-17 13:00:57, Michal Hocko wrote:
[...]
> Yes, I have mentioned that in the previous email but the amount of code
> would be even larger. Basically every arch which reimplements
> arch_get_unmapped_area would have to special case new MAP_FIXED flag to
> do vma lookup.

It turned out that this might be much more easier than I thought after
all. It seems we can really handle that in the common code. This would
mean that we are exposing a new functionality to the userspace though.
Myabe this would be useful on its own though. Just a quick draft (not
even compile tested) whether this makes sense in general. I would be
worried about unexpected behavior when somebody set other bit without a
good reason and we might fail with ENOMEM for such a call now.

Elf loader would then use MAP_FIXED_SAFE rather than MAP_FIXED.
---
diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 3b26cc62dadb..d021c21f9b01 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -31,6 +31,9 @@
 #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
 
+#define MAP_KEEP_MAPPING 0x2000000
+#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */
+
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
 #define MS_INVALIDATE	4		/* invalidate the caches */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index da3216007fe0..51e3885fbfc1 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -49,6 +49,9 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 
+#define MAP_KEEP_MAPPING 0x2000000
+#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */
+
 /*
  * Flags for msync
  */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index cc9ba1d34779..5a4381484fc5 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -25,6 +25,9 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 
+#define MAP_KEEP_MAPPING 0x2000000
+#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */
+
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
 #define MS_INVALIDATE	4		/* invalidate the caches */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index b15b278aa314..5df8a81524da 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -62,6 +62,9 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
+#define MAP_KEEP_MAPPING 0x2000000
+#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */
+
 /*
  * Flags for msync
  */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 203268f9231e..22442846f5c8 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -25,6 +25,9 @@
 # define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
 #endif
 
+#define MAP_KEEP_MAPPING 0x2000000
+#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */
+
 /*
  * Flags for mlock
  */
diff --git a/mm/mmap.c b/mm/mmap.c
index 680506faceae..e53b6b15a8d9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1365,6 +1365,13 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (offset_in_page(addr))
 		return addr;
 
+	if ((flags & MAP_FIXED_SAFE) == MAP_FIXED_SAFE) {
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
