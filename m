Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 12:58:34 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007216AbbCFL6bqV6Fe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 12:58:31 +0100
Date:   Fri, 6 Mar 2015 11:58:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Russell King <linux@arm.linux.org.uk>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/15] MIPS: Add sched_clock support
In-Reply-To: <1425517137-26463-5-git-send-email-dengcheng.zhu@imgtec.com>
Message-ID: <alpine.LFD.2.11.1503061146430.15786@eddie.linux-mips.org>
References: <1425517137-26463-1-git-send-email-dengcheng.zhu@imgtec.com> <1425517137-26463-5-git-send-email-dengcheng.zhu@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 4 Mar 2015, Deng-Cheng Zhu wrote:

> This will provide sched_clock interface to implement individual
> read_sched_clock(). Not for CAVIUM_OCTEON_SOC as it defines its own
> sched_clock() directly (not using the sched_clock_register interface).
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 068592a..09405dc 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -43,6 +43,7 @@ config MIPS
>  	select GENERIC_SMP_IDLE_THREAD
>  	select BUILDTIME_EXTABLE_SORT
>  	select GENERIC_CLOCKEVENTS
> +	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
>  	select GENERIC_CMOS_UPDATE
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select VIRT_TO_BUS

 Why does this change add this question:

ARM Versatile (Express) reference platforms clock source (CLKSRC_VERSATILE) [N/y/?] (NEW) ?

This option enables clock source based on free running
counter available in the "System Registers" block of
ARM Versatile, RealView and Versatile Express reference
platforms.

Symbol: CLKSRC_VERSATILE [=n]
Type  : boolean
Prompt: ARM Versatile (Express) reference platforms clock source
  Location:
    -> Device Drivers
      -> Clock Source drivers
  Defined at drivers/clocksource/Kconfig:216
  Depends on: GENERIC_SCHED_CLOCK [=y] && !ARCH_USES_GETTIMEOFFSET [=n]
  Selects: CLKSRC_OF [=n]

to a MIPS configuration?  I find it silly, this appears a platform 
device to me (use reverse dependencies?).

  Maciej
