Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 20:04:06 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:34617 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011545AbaJPSEE47vQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 20:04:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id A994B19BE89;
        Thu, 16 Oct 2014 21:04:02 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id v7xrB17efIX4; Thu, 16 Oct 2014 21:03:56 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 0C8C95BC005;
        Thu, 16 Oct 2014 21:03:56 +0300 (EEST)
Date:   Thu, 16 Oct 2014 21:03:55 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for
 Loongson1B (UPDATED)
Message-ID: <20141016180355.GA14194@drone.musicnaut.iki.fi>
References: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43310
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

On Wed, Oct 15, 2014 at 03:23:32PM +0800, Kelvin Cheung wrote:
> This patch adds cpufreq driver for Loongson1B which
> is capable of changing the CPU frequency dynamically.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

[...]

>  obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
> +obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o

Why it's called "ls1x-cpufreq" instead of "loongson1_cpufreq"?

A.
