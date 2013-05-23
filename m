Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 22:28:28 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:33076 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822972Ab3EWU2TGnxOi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 22:28:19 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 7FEBB21BA34;
        Thu, 23 May 2013 23:28:18 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id SZQybIrJYKAL; Thu, 23 May 2013 23:28:14 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 7F3295BC011;
        Thu, 23 May 2013 23:28:13 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Thu, 23 May 2013 23:28:12 +0300
Date:   Thu, 23 May 2013 23:28:12 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: Loongson2 cpu_wait function
Message-ID: <20130523202812.GJ31836@blackmetal.musicnaut.iki.fi>
References: <20130523122737.GA12530@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130523122737.GA12530@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Thu, May 23, 2013 at 02:27:37PM +0200, Ralf Baechle wrote:
> During the 3.10 merge cycle many MIPS platforms were broken by the
> generic idle loop patches.  A patch series to fix this has already been
> merged but I'm wondering if fb40bc3e94933007d3e42e96daf1ec8044821cb8
> [MIPS: Idle: Re-enable irqs at the end of r3081, au1k and loongson2
> cpu_wait.] is sufficient and correct for Loongson 2.
> 
> In particular:
> 
>  o drivers/cpufreq/loongson2_cpufreq.c protects accesses to LOONGSON_CHIPCFG0
>    in loongson2_cpu_wait with a spinlock.  This spinlock is not used anywhere
>    else in the kernel so it would appear there is still a race with other
>    accesses to LOONGSON_CHIPCFG0.
>  o It's not SMPly correct - even if cpufreq_exit restores the old value of
>    cpu_wait on a SMP system another processor might still be executing
>    loongson2_cpu_wait().

I think Loongson2 is UP-only?

>  o I'd appreciate if at least some basic power saving would be used even if
>    CONFIG_LOONGSON2_CPUFREQ was disabled, that is loongson2_cpu_wait should
>    go back to arch/mips/kernel/idle.c.
>  o Could somebody test if Loongson 2 is working?  Thanks!

It works (tested d97955625710b57f24427e403f150126078273c2), but cpufreq
seems to be broken for some reason:

[    6.136000] calling  cpufreq_init+0x0/0x8c @ 1
[    6.140000] cpufreq: Loongson-2F CPU frequency driver.
[    6.144000] initcall cpufreq_init+0x0/0x8c returned -19 after 4000 usecs

I would also like to remind that the boot is still unreliable without
this patch: http://patchwork.linux-mips.org/patch/4958/

A.
