Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 13:49:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36875 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903669Ab2HNLtF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 13:49:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7EBn0OV018680;
        Tue, 14 Aug 2012 13:49:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7EBmu7r018672;
        Tue, 14 Aug 2012 13:48:56 +0200
Date:   Tue, 14 Aug 2012 13:48:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        Yong Zhang <yong.zhang@windriver.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: Fix poweroff failure when HOTPLUG_CPU
 configured.
Message-ID: <20120814114856.GA17040@linux-mips.org>
References: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344862344-27434-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34145
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Aug 13, 2012 at 08:52:24PM +0800, Huacai Chen wrote:

> When poweroff machine, kernel_power_off() call disable_nonboot_cpus().
> And if we have HOTPLUG_CPU configured, disable_nonboot_cpus() is not an
> empty function but attempt to actually disable the nonboot cpus. Since
> system state is SYSTEM_POWER_OFF, play_dead() won't be called and thus
> disable_nonboot_cpus() hangs. Therefore, we make this patch to avoid
> poweroff failure.

> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index e9a5fd7..69b17a9 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -72,9 +72,7 @@ void __noreturn cpu_idle(void)
>  			}
>  		}
>  #ifdef CONFIG_HOTPLUG_CPU
> -		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map) &&
> -		    (system_state == SYSTEM_RUNNING ||
> -		     system_state == SYSTEM_BOOTING))
> +		if (!cpu_online(cpu) && !cpu_isset(cpu, cpu_callin_map))

Looks good - but I'm wondering if the "!cpu_isset(cpu, cpu_callin_map)"
can be removed as well?

Also, which -stable branches is this patch applicable?

  Ralf
