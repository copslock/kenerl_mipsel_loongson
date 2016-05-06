Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2016 01:00:54 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:44202 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027984AbcEFXAufzLYF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2016 01:00:50 +0200
Received: from akpm3.mtv.corp.google.com (unknown [104.132.1.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A071307;
        Fri,  6 May 2016 23:00:42 +0000 (UTC)
Date:   Fri, 6 May 2016 16:00:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     zengzhaoxiu@163.com
Cc:     linux@horizon.com, peterz@infradead.org, jjuran@gmail.com,
        James.Bottomley@HansenPartnership.com, geert@linux-m68k.org,
        dalias@libc.org, sam@ravnborg.org, davem@davemloft.net,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
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
        uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [patch V4] lib: GCD: Use binary GCD algorithm instead of
 Euclidean
Message-Id: <20160506160041.2b5e47757329c288efaed4fb@linux-foundation.org>
In-Reply-To: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
References: <1462527763-15301-1-git-send-email-zengzhaoxiu@163.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Fri,  6 May 2016 17:42:42 +0800 zengzhaoxiu@163.com wrote:

> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> The binary GCD algorithm is based on the following facts:
> 	1. If a and b are all evens, then gcd(a,b) = 2 * gcd(a/2, b/2)
> 	2. If a is even and b is odd, then gcd(a,b) = gcd(a/2, b)
> 	3. If a and b are all odds, then gcd(a,b) = gcd((a-b)/2, b) = gcd((a+b)/2, b)
> 
> Even on x86 machines with reasonable division hardware, the binary
> algorithm runs about 25% faster (80% the execution time) than the
> division-based Euclidian algorithm.
> 
> On platforms like Alpha and ARMv6 where division is a function call to
> emulation code, it's even more significant.
> 
> There are two variants of the code here, depending on whether a
> fast __ffs (find least significant set bit) instruction is available.
> This allows the unpredictable branches in the bit-at-a-time shifting
> loop to be eliminated.
> 
> ...
>
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -27,6 +27,7 @@ config ALPHA
>  	select MODULES_USE_ELF_RELA
>  	select ODD_RT_SIGACTION
>  	select OLD_SIGSUSPEND
> +	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
>  	help

argh.  Please don't always put new items at end-of-list.  That's the
perfect way of maximizing the number of patch collisions.  Insert it at
a random position. avoiding the end (if the list isn't alpha-sorted,
which it should be).

<fixes it all up>

>
> ...
>
> --- a/arch/mips/include/asm/cpu-features.h
> +++ b/arch/mips/include/asm/cpu-features.h
> @@ -180,6 +180,16 @@
>  #endif
>  #endif
>  
> +/* __builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r */
> +#if !((defined(cpu_has_mips32r1) && cpu_has_mips32r1) || \
> +	  (defined(cpu_has_mips32r2) && cpu_has_mips32r2) || \
> +	  (defined(cpu_has_mips32r6) && cpu_has_mips32r6) || \
> +	  (defined(cpu_has_mips64r1) && cpu_has_mips64r1) || \
> +	  (defined(cpu_has_mips64r2) && cpu_has_mips64r2) || \
> +	  (defined(cpu_has_mips64r6) && cpu_has_mips64r6))
> +#define CONFIG_CPU_NO_EFFICIENT_FFS 1
> +#endif

#defining a CONFIG_ variable is pretty rude - defining these is the
role of the Kconfig system, not of header files macros.

This was easy:

--- a/arch/mips/include/asm/cpu-features.h~lib-gcd-use-binary-gcd-algorithm-instead-of-euclidean-fix
+++ a/arch/mips/include/asm/cpu-features.h
@@ -187,7 +187,7 @@
 	  (defined(cpu_has_mips64r1) && cpu_has_mips64r1) || \
 	  (defined(cpu_has_mips64r2) && cpu_has_mips64r2) || \
 	  (defined(cpu_has_mips64r6) && cpu_has_mips64r6))
-#define CONFIG_CPU_NO_EFFICIENT_FFS 1
+#define CPU_NO_EFFICIENT_FFS 1
 #endif
 
 #ifndef cpu_has_mips_1
--- a/lib/gcd.c~lib-gcd-use-binary-gcd-algorithm-instead-of-euclidean-fix
+++ a/lib/gcd.c
@@ -10,7 +10,7 @@
  * has decent hardware division.
  */
 
-#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS)
+#if !defined(CONFIG_CPU_NO_EFFICIENT_FFS) && !defined(CPU_NO_EFFICIENT_FFS)
 
 /* If __ffs is available, the even/odd algorithm benchmarks slower. */
 unsigned long gcd(unsigned long a, unsigned long b)
_
