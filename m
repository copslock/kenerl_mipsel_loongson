Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 13:17:38 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:33879 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991129AbdBCMR2ePuA0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Feb 2017 13:17:28 +0100
Received: from [172.16.138.247] (unknown [46.183.103.17])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 13A1810001D;
        Fri,  3 Feb 2017 13:17:25 +0100 (CET)
Subject: Re: [PATCH] MIPS: lantiq: set physical_memsize
To:     ralf@linux-mips.org
References: <20161227153143.8601-1-hauke@hauke-m.de>
Cc:     paul.gortmaker@windriver.com, linux-mips@linux-mips.org,
        john@phrozen.org, lkp@intel.com
From:   Hauke Mehrtens <hauke@hauke-m.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <c9dbd450-f1e6-ffd8-ec98-4727e5a418be@hauke-m.de>
Date:   Fri, 3 Feb 2017 13:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20161227153143.8601-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56624
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

Hi Ralf,

Kernel-CI is complaining about this build error:
https://kernelci.org/build/id/5893cc9d59b5145e1b3daa9a/logs/
and I also get mails from kbuild test robot about this problem.

Can we get this patch in the mips tree somehow or revert the patch that
activated VPE support in the defconfig, see
https://patchwork.linux-mips.org/patch/14628/

Hauke

On 12/27/2016 04:31 PM, Hauke Mehrtens wrote:
> physical_memsize is needed by the vpe loader code and the platform
> specific code has to define it. This value will be given to the
> firmware loaded with the VPE loader. I am not aware of any standard
> interface or better value to provide here.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/lantiq/prom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 4cbb000e778e..96773bed8a8a 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -26,6 +26,12 @@ DEFINE_SPINLOCK(ebu_lock);
>  EXPORT_SYMBOL_GPL(ebu_lock);
>  
>  /*
> + * This is needed by the VPE loader code, just set it to 0 and assume
> + * that the firmware hardcodes this value to something useful.
> + */
> +unsigned long physical_memsize = 0L;
> +
> +/*
>   * this struct is filled by the soc specific detection code and holds
>   * information about the specific soc type, revision and name
>   */
> 
