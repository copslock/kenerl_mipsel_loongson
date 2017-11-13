Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 10:42:14 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:33711 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990404AbdKMJmGrjxCK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 10:42:06 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79F81AAA3;
        Mon, 13 Nov 2017 09:42:04 +0000 (UTC)
Date:   Mon, 13 Nov 2017 10:42:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Message-ID: <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60845
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

On Mon 13-11-17 10:20:06, Michal Hocko wrote:
> [Cc arm and ppc maintainers]

Hmm, it turned out to be a problem on other architectures as well.
CCing more maintainers. For your reference, we are talking about
http://lkml.kernel.org/r/20171023082608.6167-1-mhocko@kernel.org
which has broken architectures which do apply aligning on the mmap
address hint without MAP_FIXED applied. See below my proposed way
around this issue because I belive that the above patch is quite
valuable on its own to be dropped for all archs.

> Thanks a lot for testing!
> 
> On Sun 12-11-17 11:38:02, Joel Stanley wrote:
> > On Fri, Nov 10, 2017 at 11:00 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > Hi Joel,
> > >
> > > On Wed 08-11-17 15:20:50, Michal Hocko wrote:
> > > [...]
> > >> > There are a lot of messages on the way up that look like this:
> > >> >
> > >> > [    2.527460] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> > [    2.540160] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> > [    2.546153] Uhuuh, elf segement at 000d9000 requested but the
> > >> > memory is mapped already
> > >> >
> > >> > And then trying to run userspace looks like this:
> > >>
> > >> Could you please run with debugging patch posted
> > >> http://lkml.kernel.org/r/20171107102854.vylrtaodla63kc57@dhcp22.suse.cz
> > >
> > > Did you have chance to test with this debugging patch, please?
> > 
> > Lots of this:
> > 
> > [    1.177266] Uhuuh, elf segement at 000d9000 requested but the  memory is mapped already, got 000dd000
> > [    1.177555] Clashing vma [dd000, de000] flags:100873 name:(null)
> 
> This smells like the problem I've expected that mmap with hint doesn't
> respect the hint even though there is no clashing mapping. The above
> basically says that we didn't map at 0xd9000 but it has placed it at
> 0xdd000. The nearest (clashing) vma is at 0xdd000 so this is our new
> mapping. find_vma returns the closest vma (with addr < vm_end) for the
> given address 0xd9000 so this address cannot be mapped by any other vma.
> 
> Now that I am looking at arm's arch_get_unmapped_area it does perform
> aligning for shared vmas. We do not do that for MAP_FIXED.  Powepc,
> reported earlier [1] seems to suffer from the similar problem.
> slice_get_unmapped_area alignes to slices, whatever that means.
> 
> I can see two possible ways around that. Either we explicitly request
> non-aligned mappings via a special MAP_$FOO (e.g. MAP_FIXED_SAFE) or
> simply opt out from the MAP_FIXED protection via ifdefs. The first
> option sounds more generic to me but also more tricky to not introduce
> other user visible effects. The later is quite straightforward. What do
> you think about the following on top of the previous patch?
> 
> It is rather terse and disables the MAP_FIXED protection for arm
> comletely because I couldn't find a way to make it conditional on
> CACHEID_VIPT_ALIASING. But this can be always handled later. I find the
> protection for other archtectures useful enough to have this working for
> most architectures now and handle others specially.
> 
> [1] http://lkml.kernel.org/r/1510048229.12079.7.camel@abdul.in.ibm.com
> ---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 61a0cb15067e..018d041a30e6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -99,6 +99,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select ARCH_ALIGNED_MMAPS
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 48d91d5be4e9..eca59d27e9f1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -72,6 +72,7 @@ config MIPS
 	select RTC_LIB if !MACH_LOONGSON64
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
+	select ARCH_ALIGNED_MMAPS
 
 menu "Machine selection"
 
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 22f27ec8c117..8376d16e0a4a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -40,6 +40,7 @@ config PARISC
 	select GENERIC_CLOCKEVENTS
 	select ARCH_NO_COHERENT_DMA_MMAP
 	select CPU_NO_EFFICIENT_FFS
+	select ARCH_ALIGNED_MMAPS
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 2f629e0551e9..156f69c09c7f 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -368,6 +368,7 @@ config PPC_MM_SLICES
 	bool
 	default y if PPC_STD_MMU_64
 	default n
+	select ARCH_ALIGNED_MMAPS
 
 config PPC_HAVE_PMU_SUPPORT
        bool
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 640a85925060..ac1d4637a728 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -49,6 +49,7 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select ARCH_ALIGNED_MMAPS
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 0be3828752e5..c265dcda3d28 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -45,6 +45,7 @@ config SPARC
 	select CPU_NO_EFFICIENT_FFS
 	select LOCKDEP_SMALL if LOCKDEP
 	select ARCH_WANT_RELAX_ORDER
+	select ARCH_ALIGNED_MMAPS if SPARC64
 
 config SPARC32
 	def_bool !64BIT
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 7ad6d77b2f22..a5cf535034d1 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -30,6 +30,7 @@ config XTENSA
 	select NO_BOOTMEM
 	select PERF_USE_VMALLOC
 	select VIRT_TO_BUS
+	select ARCH_ALIGNED_MMAPS if MMU
 	help
 	  Xtensa processors are 32-bit RISC machines designed by Tensilica
 	  primarily for embedded systems.  These processors are both
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index a22718de42db..d23eb89f31c0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -345,13 +345,19 @@ static unsigned long elf_vm_mmap(struct file *filep, unsigned long addr,
 		unsigned long size, int prot, int type, unsigned long off)
 {
 	unsigned long map_addr;
+	unsigned long map_type = type;
 
 	/*
 	 * If caller requests the mapping at a specific place, make sure we fail
 	 * rather than potentially clobber an existing mapping which can have
-	 * security consequences (e.g. smash over the stack area).
+	 * security consequences (e.g. smash over the stack area). Be careful
+	 * about architectures which do not respect the address hint due to
+	 * aligning restrictions for !fixed mappings.
 	 */
-	map_addr = vm_mmap(filep, addr, size, prot, type & ~MAP_FIXED, off);
+	if (!IS_ENABLED(ARCH_ALIGNED_MMAPS))
+		map_type &= ~MAP_FIXED;
+
+	map_addr = vm_mmap(filep, addr, size, prot, map_type, off);
 	if (BAD_ADDR(map_addr))
 		return map_addr;
 
-- 
Michal Hocko
SUSE Labs
