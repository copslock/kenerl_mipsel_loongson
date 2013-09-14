Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Sep 2013 23:48:46 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:51391 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816847Ab3INVsmvp10y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Sep 2013 23:48:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 5840421B895;
        Sun, 15 Sep 2013 00:48:40 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id 9Qh7eZrEMPI8; Sun, 15 Sep 2013 00:48:35 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with SMTP id 597495BC003;
        Sun, 15 Sep 2013 00:48:34 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Sun, 15 Sep 2013 00:48:27 +0300
Date:   Sun, 15 Sep 2013 00:48:27 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org,
        cpufreq@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 136/228] cpufreq: loongson2: use cpufreq_generic_init()
 routine
Message-ID: <20130914214827.GA30568@blackmetal.musicnaut.iki.fi>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <63ebf29a1bcc7b3a26f8bfc76a5677d2880f8534.1379063063.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ebf29a1bcc7b3a26f8bfc76a5677d2880f8534.1379063063.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37813
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

On Fri, Sep 13, 2013 at 06:31:22PM +0530, Viresh Kumar wrote:
> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here. This driver wasn't setting transition_latency and so is getting set to 0
> by default. Lets mark it explicitly by calling the generic routine with
> transition_latency as 0.
> 
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: John Crispin <blogic@openwrt.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

BTW, this is not ARM but MIPS board, so adding linux-mips to CC.

A.

> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index dd4f3e4..2c8ec8e 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -131,8 +131,7 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  		return ret;
>  	}
>  
> -	return cpufreq_table_validate_and_show(policy,
> -					    &loongson2_clockmod_table[0]);
> +	return cpufreq_generic_init(policy, &loongson2_clockmod_table[0], 0);
>  }
>  
>  static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
> -- 
> 1.7.12.rc2.18.g61b472e
> 
