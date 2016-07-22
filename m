Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2016 04:28:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57772 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992659AbcGVC1zBVMgh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2016 04:27:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u6M2Rm1Q010743;
        Fri, 22 Jul 2016 04:27:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u6M2RjJD010742;
        Fri, 22 Jul 2016 04:27:45 +0200
Date:   Fri, 22 Jul 2016 04:27:45 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: Don't register r4k sched clock when CPUFREQ
 enabled
Message-ID: <20160722022007.GC25689@linux-mips.org>
References: <1469082471-4936-1-git-send-email-chenhc@lemote.com>
 <1469082471-4936-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1469082471-4936-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54354
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

On Thu, Jul 21, 2016 at 02:27:50PM +0800, Huacai Chen wrote:

> Don't register r4k sched clock when CPUFREQ enabled because sched clock
> need a constant frequency.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/kernel/csrc-r4k.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index 1f91056..5131b98 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -82,7 +82,9 @@ int __init init_r4k_clocksource(void)
>  
>  	clocksource_register_hz(&clocksource_mips, mips_hpt_frequency);
>  
> +#ifndef CONFIG_CPUFREQ
>  	sched_clock_register(r4k_read_sched_clock, 32, mips_hpt_frequency);
> +#endif

There is no config symbol CONFIG_CPUFREQ and I think if the clock may
change, we shouldn't register it as csrc or cevt.

  Ralf
