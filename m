Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2016 23:36:53 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:51723 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011475AbcAYWgviIebU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jan 2016 23:36:51 +0100
Received: from [192.168.178.24] (p508B6B55.dip0.t-ipconnect.de [80.139.107.85])
        by hauke-m.de (Postfix) with ESMTPSA id E9B1B1003CD;
        Mon, 25 Jan 2016 23:36:50 +0100 (CET)
Subject: Re: [PATCH v3 3/3] MIPS: VDSO: Add implementations of gettimeofday()
 and clock_gettime()
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
References: <1444645496-32046-1-git-send-email-markos.chandras@imgtec.com>
 <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
Cc:     Alex Smith <alex.smith@imgtec.com>, linux-kernel@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <56A6A380.70708@hauke-m.de>
Date:   Mon, 25 Jan 2016 23:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
MIME-Version: 1.0
In-Reply-To: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 10/21/2015 10:57 AM, Markos Chandras wrote:
> From: Alex Smith <alex.smith@imgtec.com>
> 
> Add user-mode implementations of gettimeofday() and clock_gettime() to
> the VDSO. This is currently usable with 2 clocksources: the CP0 count
> register, which is accessible to user-mode via RDHWR on R2 and later
> cores, or the MIPS Global Interrupt Controller (GIC) timer, which
> provides a "user-mode visible" section containing a mirror of its
> counter registers. This section must be mapped into user memory, which
> is done below the VDSO data page.
> 
> When a supported clocksource is not in use, the VDSO functions will
> return -ENOSYS, which causes libc to fall back on the standard syscall
> path.
> 
> When support for neither of these clocksources is compiled into the
> kernel at all, the VDSO still provides clock_gettime(), as the coarse
> realtime/monotonic clocks can still be implemented. However,
> gettimeofday() is not provided in this case as nothing can be done
> without a suitable clocksource. This causes the symbol lookup to fail
> in libc and it will then always use the standard syscall path.
> 
> This patch includes a workaround for a bug in QEMU which results in
> RDHWR on the CP0 count register always returning a constant (incorrect)
> value. A fix for this has been submitted, and the workaround can be
> removed after the fix has been in stable releases for a reasonable
> amount of time.
> 
> A simple performance test which calls gettimeofday() 1000 times in a
> loop and calculates the average execution time gives the following
> results on a Malta + I6400 (running at 20MHz):
> 
>  - Syscall:    ~31000 ns
>  - VDSO (GIC): ~15000 ns
>  - VDSO (CP0): ~9500 ns
> 
> [markos.chandras@imgtec.com:
> - Minor code re-arrangements in order for mappings to be made
> in the order they appear to the process' address space.
> - Move do_{monotonic, realtime} outside of the MIPS_CLOCK_VSYSCALL ifdef
> - Use gic_get_usm_range so we can do the GIC mapping in the
> arch/mips/kernel/vdso instead of the GIC irqchip driver]
> 
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> Changes since v2:
> - Do not export VDSO symbols if the toolchain does not have proper support
> for the VDSO.
> 
> Changes since v1:
> - Use gic_get_usm_range so we can do the GIC mapping in the
> arch/mips/kernel/vdso instead of the GIC irqchip driver
> ---
>  arch/mips/Kconfig                    |   5 +
>  arch/mips/include/asm/clocksource.h  |  29 +++++
>  arch/mips/include/asm/vdso.h         |  68 +++++++++-
>  arch/mips/kernel/csrc-r4k.c          |  44 +++++++
>  arch/mips/kernel/vdso.c              |  71 ++++++++++-
>  arch/mips/vdso/gettimeofday.c        | 232 +++++++++++++++++++++++++++++++++++
>  arch/mips/vdso/vdso.h                |   9 ++
>  arch/mips/vdso/vdso.lds.S            |   5 +
>  drivers/clocksource/mips-gic-timer.c |   7 +-
>  9 files changed, 460 insertions(+), 10 deletions(-)
>  create mode 100644 arch/mips/include/asm/clocksource.h
>  create mode 100644 arch/mips/vdso/gettimeofday.c
> 

....

> +
> +int __vdso_clock_gettime(clockid_t clkid, struct timespec *ts)
> +{
> +	const union mips_vdso_data *data = get_vdso_data();
> +	int ret;
> +
> +	switch (clkid) {
> +	case CLOCK_REALTIME_COARSE:
> +		ret = do_realtime_coarse(ts, data);
> +		break;
> +	case CLOCK_MONOTONIC_COARSE:
> +		ret = do_monotonic_coarse(ts, data);
> +		break;
> +	case CLOCK_REALTIME:
> +		ret = do_realtime(ts, data);
> +		break;
> +	case CLOCK_MONOTONIC:
> +		ret = do_monotonic(ts, data);
> +		break;
> +	default:
> +		ret = -ENOSYS;
> +		break;
> +	}
> +
> +	/* If we return -ENOSYS libc should fall back to a syscall. */

This comment is important.

The other architectures (checked arm64, tile, x86) are calling the
original syscall instead of returning -ENOSYS here. This will confuse
people trying to use this feature like me.

When the libc does not call the normal syscall this will cause problems.

> +	return ret;
> +}

Hauke
