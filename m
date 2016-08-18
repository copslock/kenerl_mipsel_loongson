Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 23:18:34 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35863 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992481AbcHRVS05NuVU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 23:18:26 +0200
Received: by mail-pa0-f45.google.com with SMTP id pp5so9446028pac.3
        for <linux-mips@linux-mips.org>; Thu, 18 Aug 2016 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JSC39spS3GfYP2w8ZFsZYV+KyyIwp/rmJV3SrpKA2n8=;
        b=Yiq0n/2I6fIhP71Khp37jaNmJVR2w+O7faj/++CkUD7CSlYdfjoTAWPpnqTOGl16gn
         VN/W7OrBVjT+grIvPUODMp1ExFo5F7atBqfhUU5IXCpMuyscbtzq9kKWvBzYh5h90Ji2
         T5+Z+JQAzrUUBY5E9Vw2/LZIPcyC2+f9HLtUK4v9QW99UM7D9K5iPZ6jALCub/zNZtp+
         u9gFqZhCWxLBItUOAfc6Uh6C5p0l5rOR76byfVmGKM8MzHbFSxuL80B5IiZ6oW0RpkWE
         C6Rrf1u8tbYqn2jPUE7vre12hn0GeJ3a4I3LuTafV6CSq/CnsyxxxULnnPP3d2Zfn6Uz
         OYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JSC39spS3GfYP2w8ZFsZYV+KyyIwp/rmJV3SrpKA2n8=;
        b=KQxJ1mH+aXWeWQu+4prTI13ie3tGL9vIW5DEbBH+nlpARYdn8T1y0H4Wswhro4Y4yK
         hPLuPsvWCmZsokHlSyf4L1nqHmQLDwRE513Cf4VIbmSo55gAS6fU9OgfsPnkFRtrjUJ4
         XyBSBKOGA0waC5SZAuN5KyBrdLI+Lb+KGv9HOPXc3kDWDosouZd9U6SnJmepQD3GgkFj
         yuHW1Ym6c/k9qRZa5cHnstLYK5zuJsB8SHbkXiiuGjVJ8/IDUcnwopyMWHFa6c/W0SVW
         bvCffQgk8qt2FPoL8yZqJSeeZcCR/BcVABzzYF07wRV3REo9ghmx8VGZ+ppMWGVwqzJ9
         x8lg==
X-Gm-Message-State: AEkoousqeAJPuFZme8URE6odpRcD5nhv/ZGXt0DDZRgiz6S3uvLJVI8/aYpQYEmWocJRaK3u
X-Received: by 10.67.16.42 with SMTP id ft10mr7547038pad.133.1471555100551;
        Thu, 18 Aug 2016 14:18:20 -0700 (PDT)
Received: from ?IPv6:2001:470:b8f6:1b:e80f:cfd9:9e8:c3f1? ([2001:470:b8f6:1b:e80f:cfd9:9e8:c3f1])
        by smtp.gmail.com with ESMTPSA id m78sm936932pfj.66.2016.08.18.14.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 14:18:19 -0700 (PDT)
Subject: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
To:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>, Ralf Baechle <ralf@linux-mips.org>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
Cc:     x86@kernel.org, David Daney <david.daney@cavium.com>,
        Xunlei Pang <xpang@redhat.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        linux-mips@linux-mips.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        xen-devel@lists.xenproject.org, Daniel Walker <dwalker@fifo99.com>,
        Vivek Goyal <vgoyal@redhat.com>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <bdfd7136-6b0e-3820-dbac-d72529a4f058@mvista.com>
Date:   Thu, 18 Aug 2016 16:18:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <cminyard@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cminyard@mvista.com
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

Sorry this took so long, but I have finally tested this, it seems to 
work fine:

Tested-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>

On 08/10/2016 03:09 AM, Hidehiro Kawai wrote:
> Daniel Walker reported problems which happens when
> crash_kexec_post_notifiers kernel option is enabled
> (https://lkml.org/lkml/2015/6/24/44).
>
> In that case, smp_send_stop() is called before entering kdump routines
> which assume other CPUs are still online.  As the result, kdump
> routines fail to save other CPUs' registers.  Additionally for MIPS
> OCTEON, it misses to stop the watchdog timer.
>
> To fix this problem, call a new kdump friendly function,
> crash_smp_send_stop(), instead of the smp_send_stop() when
> crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
> weak function, and it just call smp_send_stop().  Architecture
> codes should override it so that kdump can work appropriately.
> This patch provides MIPS version.
>
> Reported-by: Daniel Walker <dwalker@fifo99.com>
> Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: "Steven J. Hill" <steven.hill@cavium.com>
> Cc: Corey Minyard <cminyard@mvista.com>
>
> ---
> I'm not familiar with MIPS, and I don't have a test environment and
> just did build tests only.  Please don't apply this patch until
> someone does enough tests, otherwise simply drop this patch.
> ---
>   arch/mips/cavium-octeon/setup.c  |   14 ++++++++++++++
>   arch/mips/include/asm/kexec.h    |    1 +
>   arch/mips/kernel/crash.c         |   18 +++++++++++++++++-
>   arch/mips/kernel/machine_kexec.c |    1 +
>   4 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index cb16fcc..5537f95 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -267,6 +267,17 @@ static void octeon_crash_shutdown(struct pt_regs *regs)
>   	default_machine_crash_shutdown(regs);
>   }
>   
> +#ifdef CONFIG_SMP
> +void octeon_crash_smp_send_stop(void)
> +{
> +	int cpu;
> +
> +	/* disable watchdogs */
> +	for_each_online_cpu(cpu)
> +		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
> +}
> +#endif
> +
>   #endif /* CONFIG_KEXEC */
>   
>   #ifdef CONFIG_CAVIUM_RESERVE32
> @@ -911,6 +922,9 @@ void __init prom_init(void)
>   	_machine_kexec_shutdown = octeon_shutdown;
>   	_machine_crash_shutdown = octeon_crash_shutdown;
>   	_machine_kexec_prepare = octeon_kexec_prepare;
> +#ifdef CONFIG_SMP
> +	_crash_smp_send_stop = octeon_crash_smp_send_stop;
> +#endif
>   #endif
>   
>   	octeon_user_io_init();
> diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
> index ee25ebb..493a3cc 100644
> --- a/arch/mips/include/asm/kexec.h
> +++ b/arch/mips/include/asm/kexec.h
> @@ -45,6 +45,7 @@ extern const unsigned char kexec_smp_wait[];
>   extern unsigned long secondary_kexec_args[4];
>   extern void (*relocated_kexec_smp_wait) (void *);
>   extern atomic_t kexec_ready_to_reboot;
> +extern void (*_crash_smp_send_stop)(void);
>   #endif
>   #endif
>   
> diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
> index 610f0f3..1723b17 100644
> --- a/arch/mips/kernel/crash.c
> +++ b/arch/mips/kernel/crash.c
> @@ -47,9 +47,14 @@ static void crash_shutdown_secondary(void *passed_regs)
>   
>   static void crash_kexec_prepare_cpus(void)
>   {
> +	static int cpus_stopped;
>   	unsigned int msecs;
> +	unsigned int ncpus;
>   
> -	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> +	if (cpus_stopped)
> +		return;
> +
> +	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
>   
>   	dump_send_ipi(crash_shutdown_secondary);
>   	smp_wmb();
> @@ -64,6 +69,17 @@ static void crash_kexec_prepare_cpus(void)
>   		cpu_relax();
>   		mdelay(1);
>   	}
> +
> +	cpus_stopped = 1;
> +}
> +
> +/* Override the weak function in kernel/panic.c */
> +void crash_smp_send_stop(void)
> +{
> +	if (_crash_smp_send_stop)
> +		_crash_smp_send_stop();
> +
> +	crash_kexec_prepare_cpus();
>   }
>   
>   #else /* !defined(CONFIG_SMP)  */
> diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
> index 50980bf3..5972520 100644
> --- a/arch/mips/kernel/machine_kexec.c
> +++ b/arch/mips/kernel/machine_kexec.c
> @@ -25,6 +25,7 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
>   #ifdef CONFIG_SMP
>   void (*relocated_kexec_smp_wait) (void *);
>   atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
> +void (*_crash_smp_send_stop)(void) = NULL;
>   #endif
>   
>   int
>
>
