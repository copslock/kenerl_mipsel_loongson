Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 10:32:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59866 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993021AbcHBIclYmJUO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2016 10:32:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u728Wc9Q016506;
        Tue, 2 Aug 2016 10:32:38 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u728Wccx016505;
        Tue, 2 Aug 2016 10:32:38 +0200
Date:   Tue, 2 Aug 2016 10:32:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Chunbo Cui <cuichboo@163.com>, Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH RESEND v4 1/9] MIPS: Loongson: Add basic Loongson-1A CPU
 support
Message-ID: <20160802083237.GB15910@linux-mips.org>
References: <1463621912-9883-1-git-send-email-zhoubb@lemote.com>
 <1463621912-9883-2-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463621912-9883-2-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54390
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

On Thu, May 19, 2016 at 09:38:26AM +0800, Binbin Zhou wrote:

> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -1497,8 +1497,12 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  		c->cputype = CPU_LOONGSON1;
>  
>  		switch (c->processor_id & PRID_REV_MASK) {
> -		case PRID_REV_LOONGSON1B:
> +		case PRID_REV_LOONGSON1A_1B:
> +#ifdef CONFIG_CPU_LOONGSON1A
> +			__cpu_name[cpu] = "Loongson 1A";
> +#else
>  			__cpu_name[cpu] = "Loongson 1B";
> +#endif

Is there no way to distinguish between Loongson 1A and 1B at runtime for
example by looking at the version number or similar?

> --- a/arch/mips/loongson32/common/setup.c
> +++ b/arch/mips/loongson32/common/setup.c
> @@ -21,8 +21,12 @@ const char *get_system_type(void)
>  	unsigned int processor_id = (&current_cpu_data)->processor_id;
>  
>  	switch (processor_id & PRID_REV_MASK) {
> -	case PRID_REV_LOONGSON1B:
> +	case PRID_REV_LOONGSON1A_1B:
> +#ifdef CONFIG_CPU_LOONGSON1A
> +		return "LOONGSON LS1A";
> +#else
>  		return "LOONGSON LS1B";
> +#endif
>  	default:
>  		return "LOONGSON (unknown)";
>  	}

Ditto.

  Ralf
