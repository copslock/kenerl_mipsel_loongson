Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 11:50:05 +0200 (CEST)
Received: from m50-132.163.com ([123.125.50.132]:60100 "EHLO m50-132.163.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027714AbcEFJuDZi5Hq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 May 2016 11:50:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=x/fD3aA2lg6tY/aDqM
        GwCGwEnbE/ilW9XNFRsHDtHmA=; b=g1/DVyas0Ud4n/MHcj61nLN7SEW/dj2Uc0
        Mgt7LvI/AdO+1ttkZhN/6QnI6xGIpc94u3fuxUZzX4mrc74CnA4SMjbYrtb/Kjjg
        Wu77NF6TKN37Ae1BRz6n5i3AYC/RVdI2dIrwkvHeRXEZM1uq6NBiEnj+RnGDWPHe
        MvbgWEje4=
Received: from zhaoxiuzeng-VirtualBox.spreadtrum.com (unknown [112.95.225.98])
        by smtp2 (Coremail) with SMTP id DNGowADXQf6OZyxXUA2ECg--.15271S2;
        Fri, 06 May 2016 17:44:54 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     akpm@linux-foundation.org, linux@horizon.com, peterz@infradead.org,
        jjuran@gmail.com, James.Bottomley@HansenPartnership.com,
        geert@linux-m68k.org, dalias@libc.org, sam@ravnborg.org,
        davem@davemloft.net
Cc:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@arm.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, nios2-dev@lists.rocketboards.org,
        linux@lists.openrisc.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [patch V4] lib: GCD: Use binary GCD algorithm instead of Euclidean
Date:   Fri,  6 May 2016 17:42:42 +0800
Message-Id: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DNGowADXQf6OZyxXUA2ECg--.15271S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZF4kXryxGF1rGw1rtrW3GFg_yoW8Aw43Co
        Z7K3ZI9r4rA39xWw1rZF15G3yrXryjkr48ZryruwsxtFnxXF1agryjkFyDtryrJF1rKFn3
        CFs3Wr47tF4xAF97n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc75rUUUUU
X-Originating-IP: [112.95.225.98]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/xtbBDRZhgFaDm00YUwAAsy
Return-Path: <zengzhaoxiu@163.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zengzhaoxiu@163.com
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

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

The binary GCD algorithm is based on the following facts:
	1. If a and b are all evens, then gcd(a,b) = 2 * gcd(a/2, b/2)
	2. If a is even and b is odd, then gcd(a,b) = gcd(a/2, b)
	3. If a and b are all odds, then gcd(a,b) = gcd((a-b)/2, b) = gcd((a+b)/2, b)

Even on x86 machines with reasonable division hardware, the binary
algorithm runs about 25% faster (80% the execution time) than the
division-based Euclidian algorithm.

On platforms like Alpha and ARMv6 where division is a function call to
emulation code, it's even more significant.

There are two variants of the code here, depending on whether a
fast __ffs (find least significant set bit) instruction is available.
This allows the unpredictable branches in the bit-at-a-time shifting
loop to be eliminated.

If fast __ffs is not available, the "even/odd" GCD variant is used.

I use the following code to benchmark:

	#include <stdio.h>
	#include <stdlib.h>
	#include <stdint.h>
	#include <string.h>
	#include <time.h>
	#include <unistd.h>

	#define swap(a, b) \
		do { \
			a ^= b; \
			b ^= a; \
			a ^= b; \
		} while (0)

	unsigned long gcd0(unsigned long a, unsigned long b)
	{
		unsigned long r;

		if (a < b) {
			swap(a, b);
		}

		if (b == 0)
			return a;

		while ((r = a % b) != 0) {
			a = b;
			b = r;
		}

		return b;
	}

	unsigned long gcd1(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		b >>= __builtin_ctzl(b);

		for (;;) {
			a >>= __builtin_ctzl(a);
			if (a == b)
				return a << __builtin_ctzl(r);

			if (a < b)
				swap(a, b);
			a -= b;
		}
	}

	unsigned long gcd2(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		r &= -r;

		while (!(b & r))
			b >>= 1;

		for (;;) {
			while (!(a & r))
				a >>= 1;
			if (a == b)
				return a;

			if (a < b)
				swap(a, b);
			a -= b;
			a >>= 1;
			if (a & r)
				a += b;
			a >>= 1;
		}
	}

	unsigned long gcd3(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		b >>= __builtin_ctzl(b);
		if (b == 1)
			return r & -r;

		for (;;) {
			a >>= __builtin_ctzl(a);
			if (a == 1)
				return r & -r;
			if (a == b)
				return a << __builtin_ctzl(r);

			if (a < b)
				swap(a, b);
			a -= b;
		}
	}

	unsigned long gcd4(unsigned long a, unsigned long b)
	{
		unsigned long r = a | b;

		if (!a || !b)
			return r;

		r &= -r;

		while (!(b & r))
			b >>= 1;
		if (b == r)
			return r;

		for (;;) {
			while (!(a & r))
				a >>= 1;
			if (a == r)
				return r;
			if (a == b)
				return a;

			if (a < b)
				swap(a, b);
			a -= b;
			a >>= 1;
			if (a & r)
				a += b;
			a >>= 1;
		}
	}

	static unsigned long (*gcd_func[])(unsigned long a, unsigned long b) = {
		gcd0, gcd1, gcd2, gcd3, gcd4,
	};

	#define TEST_ENTRIES (sizeof(gcd_func) / sizeof(gcd_func[0]))

	#if defined(__x86_64__)

	#define rdtscll(val) do { \
		unsigned long __a,__d; \
		__asm__ __volatile__("rdtsc" : "=a" (__a), "=d" (__d)); \
		(val) = ((unsigned long long)__a) | (((unsigned long long)__d)<<32); \
	} while(0)

	static unsigned long long benchmark_gcd_func(unsigned long (*gcd)(unsigned long, unsigned long),
								unsigned long a, unsigned long b, unsigned long *res)
	{
		unsigned long long start, end;
		unsigned long long ret;
		unsigned long gcd_res;

		rdtscll(start);
		gcd_res = gcd(a, b);
		rdtscll(end);

		if (end >= start)
			ret = end - start;
		else
			ret = ~0ULL - start + 1 + end;

		*res = gcd_res;
		return ret;
	}

	#else

	static inline struct timespec read_time(void)
	{
		struct timespec time;
		clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time);
		return time;
	}

	static inline unsigned long long diff_time(struct timespec start, struct timespec end)
	{
		struct timespec temp;

		if ((end.tv_nsec - start.tv_nsec) < 0) {
			temp.tv_sec = end.tv_sec - start.tv_sec - 1;
			temp.tv_nsec = 1000000000ULL + end.tv_nsec - start.tv_nsec;
		} else {
			temp.tv_sec = end.tv_sec - start.tv_sec;
			temp.tv_nsec = end.tv_nsec - start.tv_nsec;
		}

		return temp.tv_sec * 1000000000ULL + temp.tv_nsec;
	}

	static unsigned long long benchmark_gcd_func(unsigned long (*gcd)(unsigned long, unsigned long),
								unsigned long a, unsigned long b, unsigned long *res)
	{
		struct timespec start, end;
		unsigned long gcd_res;

		start = read_time();
		gcd_res = gcd(a, b);
		end = read_time();

		*res = gcd_res;
		return diff_time(start, end);
	}

	#endif

	static inline unsigned long get_rand()
	{
		if (sizeof(long) == 8)
			return (unsigned long)rand() << 32 | rand();
		else
			return rand();
	}

	int main(int argc, char **argv)
	{
		unsigned int seed = time(0);
		int loops = 100;
		int repeats = 1000;
		unsigned long (*res)[TEST_ENTRIES];
		unsigned long long elapsed[TEST_ENTRIES];
		int i, j, k;

		for (;;) {
			int opt = getopt(argc, argv, "n:r:s:");
			/* End condition always first */
			if (opt == -1)
				break;

			switch (opt) {
			case 'n':
				loops = atoi(optarg);
				break;
			case 'r':
				repeats = atoi(optarg);
				break;
			case 's':
				seed = strtoul(optarg, NULL, 10);
				break;
			default:
				/* You won't actually get here. */
				break;
			}
		}

		res = malloc(sizeof(unsigned long) * TEST_ENTRIES * loops);
		memset(elapsed, 0, sizeof(elapsed));

		srand(seed);
		for (j = 0; j < loops; j++) {
			unsigned long a = get_rand();
			/* Do we have args? */
			unsigned long b = argc > optind ? strtoul(argv[optind], NULL, 10) : get_rand();
			unsigned long long min_elapsed[TEST_ENTRIES];
			for (k = 0; k < repeats; k++) {
				for (i = 0; i < TEST_ENTRIES; i++) {
					unsigned long long tmp = benchmark_gcd_func(gcd_func[i], a, b, &res[j][i]);
					if (k == 0 || min_elapsed[i] > tmp)
						min_elapsed[i] = tmp;
				}
			}
			for (i = 0; i < TEST_ENTRIES; i++)
				elapsed[i] += min_elapsed[i];
		}

		for (i = 0; i < TEST_ENTRIES; i++)
			printf("gcd%d: elapsed %llu\n", i, elapsed[i]);

		k = 0;
		srand(seed);
		for (j = 0; j < loops; j++) {
			unsigned long a = get_rand();
			unsigned long b = argc > optind ? strtoul(argv[optind], NULL, 10) : get_rand();
			for (i = 1; i < TEST_ENTRIES; i++) {
				if (res[j][i] != res[j][0])
					break;
			}
			if (i < TEST_ENTRIES) {
				if (k == 0) {
					k = 1;
					fprintf(stderr, "Error:\n");
				}
				fprintf(stderr, "gcd(%lu, %lu): ", a, b);
				for (i = 0; i < TEST_ENTRIES; i++)
					fprintf(stderr, "%ld%s", res[j][i], i < TEST_ENTRIES - 1 ? ", " : "\n");
			}
		}

		if (k == 0)
			fprintf(stderr, "PASS\n");

		free(res);

		return 0;
	}

Compiled with "-O2", on "VirtualBox 4.4.0-22-generic #38-Ubuntu x86_64" got:

zhaoxiuzeng@zhaoxiuzeng-VirtualBox:~/develop$ ./gcd -r 500000 -n 10
gcd0: elapsed 10174
gcd1: elapsed 2120
gcd2: elapsed 2902
gcd3: elapsed 2039
gcd4: elapsed 2812
PASS
zhaoxiuzeng@zhaoxiuzeng-VirtualBox:~/develop$ ./gcd -r 500000 -n 10
gcd0: elapsed 9309
gcd1: elapsed 2280
gcd2: elapsed 2822
gcd3: elapsed 2217
gcd4: elapsed 2710
PASS
zhaoxiuzeng@zhaoxiuzeng-VirtualBox:~/develop$ ./gcd -r 500000 -n 10
gcd0: elapsed 9589
gcd1: elapsed 2098
gcd2: elapsed 2815
gcd3: elapsed 2030
gcd4: elapsed 2718
PASS
zhaoxiuzeng@zhaoxiuzeng-VirtualBox:~/develop$ ./gcd -r 500000 -n 10
gcd0: elapsed 9914
gcd1: elapsed 2309
gcd2: elapsed 2779
gcd3: elapsed 2228
gcd4: elapsed 2709
PASS

Changes to V3:
- Fix build error
- Select CPU_NO_EFFICIENT_FFS if CONFIG_ARC && CONFIG_ISA_ARCOMPACT
- Select CPU_NO_EFFICIENT_FFS if CONFIG_S390 && !CONFIG_HAVE_MARCH_Z9_109_FEATURES
- Do new brnchmark
- Return immediately if one number becomes a power of 2
- Add comments written by George Spelvin

Changes to V2:
- Add a new Kconfig variable CPU_NO_EFFICIENT_FFS
- Separate into two versions by CPU_NO_EFFICIENT_FFS
- Return directly from the loop, rather than using break().
- Use "r &= -r" mostly because it's clearer.

Changes to V1:
- Don't touch Kconfig, remove the Euclidean algorithm implementation
- Don't use the "even-odd" variant
- Use __ffs if the CPU has efficient __ffs

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Signed-off-by: George Spelvin <linux@horizon.com>
---
 arch/Kconfig                         |  3 ++
 arch/alpha/Kconfig                   |  1 +
 arch/arc/Kconfig                     |  1 +
 arch/arm/mm/Kconfig                  |  3 ++
 arch/h8300/Kconfig                   |  1 +
 arch/m32r/Kconfig                    |  1 +
 arch/m68k/Kconfig.cpu                | 11 ++++++
 arch/metag/Kconfig                   |  1 +
 arch/microblaze/Kconfig              |  1 +
 arch/mips/include/asm/cpu-features.h | 10 +++++
 arch/nios2/Kconfig                   |  1 +
 arch/openrisc/Kconfig                |  1 +
 arch/parisc/Kconfig                  |  1 +
 arch/s390/Kconfig                    |  2 +-
 arch/score/Kconfig                   |  1 +
 arch/sh/Kconfig                      |  1 +
 arch/sparc/Kconfig                   |  1 +
 lib/gcd.c                            | 77 +++++++++++++++++++++++++++++++-----
 18 files changed, 107 insertions(+), 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 81869a5..275f17d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -638,4 +638,7 @@ config COMPAT_OLD_SIGACTION
 config ARCH_NO_COHERENT_DMA_MMAP
 	bool
 
+config CPU_NO_EFFICIENT_FFS
+	def_bool n
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 9d8a858..44e6f05 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -27,6 +27,7 @@ config ALPHA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
+	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ec4791e..f41eb4c 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -101,6 +101,7 @@ choice
 
 config ISA_ARCOMPACT
 	bool "ARCompact ISA"
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The original ARC ISA of ARC600/700 cores
 
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5534766..cb569b6 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -421,18 +421,21 @@ config CPU_32v3
 	select CPU_USE_DOMAINS if MMU
 	select NEED_KUSER_HELPERS
 	select TLS_REG_EMUL if SMP || !MMU
+	select CPU_NO_EFFICIENT_FFS
 
 config CPU_32v4
 	bool
 	select CPU_USE_DOMAINS if MMU
 	select NEED_KUSER_HELPERS
 	select TLS_REG_EMUL if SMP || !MMU
+	select CPU_NO_EFFICIENT_FFS
 
 config CPU_32v4T
 	bool
 	select CPU_USE_DOMAINS if MMU
 	select NEED_KUSER_HELPERS
 	select TLS_REG_EMUL if SMP || !MMU
+	select CPU_NO_EFFICIENT_FFS
 
 config CPU_32v5
 	bool
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 986ea84..aa232de 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -20,6 +20,7 @@ config H8300
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_ARCH_KGDB
+	select CPU_NO_EFFICIENT_FFS
 
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index c82b292..3cc8498 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -17,6 +17,7 @@ config M32R
 	select ARCH_USES_GETTIMEOFFSET
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
+	select CPU_NO_EFFICIENT_FFS
 
 config SBUS
 	bool
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index 0dfcf12..0b6efe8 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -40,6 +40,7 @@ config M68000
 	select CPU_HAS_NO_MULDIV64
 	select CPU_HAS_NO_UNALIGNED
 	select GENERIC_CSUM
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The Freescale (was Motorola) 68000 CPU is the first generation of
 	  the well known M68K family of processors. The CPU core as well as
@@ -51,6 +52,7 @@ config MCPU32
 	bool
 	select CPU_HAS_NO_BITFIELDS
 	select CPU_HAS_NO_UNALIGNED
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The Freescale (was then Motorola) CPU32 is a CPU core that is
 	  based on the 68020 processor. For the most part it is used in
@@ -130,6 +132,7 @@ config M5206
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5206 processor support.
 
@@ -138,6 +141,7 @@ config M5206e
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5206e processor support.
 
@@ -163,6 +167,7 @@ config M5249
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5249 processor support.
 
@@ -171,6 +176,7 @@ config M525x
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Freescale (Motorola) Coldfire 5251/5253 processor support.
 
@@ -189,6 +195,7 @@ config M5272
 	depends on !MMU
 	select COLDFIRE_SW_A7
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5272 processor support.
 
@@ -217,6 +224,7 @@ config M5307
 	select COLDFIRE_SW_A7
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5307 processor support.
 
@@ -242,6 +250,7 @@ config M5407
 	select COLDFIRE_SW_A7
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Motorola ColdFire 5407 processor support.
 
@@ -251,6 +260,7 @@ config M547x
 	select MMU_COLDFIRE if MMU
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Freescale ColdFire 5470/5471/5472/5473/5474/5475 processor support.
 
@@ -260,6 +270,7 @@ config M548x
 	select M54xx
 	select HAVE_CACHE_CB
 	select HAVE_MBAR
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  Freescale ColdFire 5480/5481/5482/5483/5484/5485 processor support.
 
diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
index a0fa88d..2ac2de6 100644
--- a/arch/metag/Kconfig
+++ b/arch/metag/Kconfig
@@ -29,6 +29,7 @@ config METAG
 	select OF
 	select OF_EARLY_FLATTREE
 	select SPARSE_IRQ
+	select CPU_NO_EFFICIENT_FFS
 
 config STACKTRACE_SUPPORT
 	def_bool y
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 3d793b5..f17c3a4 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -32,6 +32,7 @@ config MICROBLAZE
 	select OF_EARLY_FLATTREE
 	select TRACING_SUPPORT
 	select VIRT_TO_BUS
+	select CPU_NO_EFFICIENT_FFS
 
 config SWAP
 	def_bool n
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index eeec8c8..e20e100 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -180,6 +180,16 @@
 #endif
 #endif
 
+/* __builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r */
+#if !((defined(cpu_has_mips32r1) && cpu_has_mips32r1) || \
+	  (defined(cpu_has_mips32r2) && cpu_has_mips32r2) || \
+	  (defined(cpu_has_mips32r6) && cpu_has_mips32r6) || \
+	  (defined(cpu_has_mips64r1) && cpu_has_mips64r1) || \
+	  (defined(cpu_has_mips64r2) && cpu_has_mips64r2) || \
+	  (defined(cpu_has_mips64r6) && cpu_has_mips64r6))
+#define CONFIG_CPU_NO_EFFICIENT_FFS 1
+#endif
+
 #ifndef cpu_has_mips_1
 # define cpu_has_mips_1		(!cpu_has_mips_r6)
 #endif
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4375554..f10bd2c 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -16,6 +16,7 @@ config NIOS2
 	select SOC_BUS
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
+	select CPU_NO_EFFICIENT_FFS
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e118c02..142cb05 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -25,6 +25,7 @@ config OPENRISC
 	select MODULES_USE_ELF_RELA
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
+	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
 
 config MMU
 	def_bool y
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 88cfaa8..3d498a6 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -32,6 +32,7 @@ config PARISC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select CPU_NO_EFFICIENT_FFS
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf24ab1..9eb3932 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -164,7 +164,7 @@ config S390
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select VIRT_TO_BUS
-
+	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
diff --git a/arch/score/Kconfig b/arch/score/Kconfig
index 366e1b5..507d631 100644
--- a/arch/score/Kconfig
+++ b/arch/score/Kconfig
@@ -14,6 +14,7 @@ config SCORE
 	select VIRT_TO_BUS
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
+	select CPU_NO_EFFICIENT_FFS
 
 choice
 	prompt "System type"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ed20fc..56cf5e5 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -44,6 +44,7 @@ config SUPERH
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select HAVE_ARCH_AUDITSYSCALL
+	select CPU_NO_EFFICIENT_FFS
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 57ffaf2..ca675ed 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -42,6 +42,7 @@ config SPARC
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
 	select ARCH_HAS_SG_CHAIN
+	select CPU_NO_EFFICIENT_FFS
 
 config SPARC32
 	def_bool !64BIT
diff --git a/lib/gcd.c b/lib/gcd.c
index 3657f12..b9fbe73 100644
--- a/lib/gcd.c
+++ b/lib/gcd.c
@@ -2,20 +2,77 @@
 #include <linux/gcd.h>
 #include <linux/export.h>
 
-/* Greatest common divisor */
+/*
+ * This implements the binary GCD algorithm. (Often attributed to Stein,
+ * but as Knuth has noted, appears in a first-century Chinese math text.)
+ *
+ * This is faster than the division-based algorithm even on x86, which
+ * has decent hardware division.
+ */
+
+#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS)
+
+/* If __ffs is available, the even/odd algorithm benchmarks slower. */
 unsigned long gcd(unsigned long a, unsigned long b)
 {
-	unsigned long r;
+	unsigned long r = a | b;
+
+	if (!a || !b)
+		return r;
 
-	if (a < b)
-		swap(a, b);
+	b >>= __ffs(b);
+	if (b == 1)
+		return r & -r;
 
-	if (!b)
-		return a;
-	while ((r = a % b) != 0) {
-		a = b;
-		b = r;
+	for (;;) {
+		a >>= __ffs(a);
+		if (a == 1)
+			return r & -r;
+		if (a == b)
+			return a << __ffs(r);
+
+		if (a < b)
+			swap(a, b);
+		a -= b;
 	}
-	return b;
 }
+
+#else
+
+/* If normalization is done by loops, the even/odd algorithm is a win. */
+unsigned long gcd(unsigned long a, unsigned long b)
+{
+	unsigned long r = a | b;
+
+	if (!a || !b)
+		return r;
+
+	/* Isolate lsbit of r */
+	r &= -r;
+
+	while (!(b & r))
+		b >>= 1;
+	if (b == r)
+		return r;
+
+	for (;;) {
+		while (!(a & r))
+			a >>= 1;
+		if (a == r)
+			return r;
+		if (a == b)
+			return a;
+
+		if (a < b)
+			swap(a, b);
+		a -= b;
+		a >>= 1;
+		if (a & r)
+			a += b;
+		a >>= 1;
+	}
+}
+
+#endif
+
 EXPORT_SYMBOL_GPL(gcd);
-- 
2.7.4
