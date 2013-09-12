Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 11:39:28 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:61816 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817237Ab3ILJjZwAcR4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Sep 2013 11:39:25 +0200
Message-ID: <52318BC6.7030903@imgtec.com>
Date:   Thu, 12 Sep 2013 10:39:18 +0100
From:   Paul Burton <paul.burton@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130806 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2013_09_12_10_39_19
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Could you expand on that please? What is errata E16, what are "some 
problems" and how does this fix those problems? The commit message is 
somewhat lacking...

Paul

On 11/09/13 21:01, Steven J. Hill wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Fixes errata E16 for some problems on 1074K cores.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/mm/c-r4k.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index f749f68..8d3ed32 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -786,12 +786,12 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
>   	 * aliases. In this case it is better to treat the cache as always
>   	 * having aliases.
>   	 */
> -	if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> -		c->dcache.flags |= MIPS_CACHE_VTAG;
> -	if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> -		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> -	if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
> -	    ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
> +	if ((c->processor_id & 0xff00) != PRID_IMP_1074K) {
> +		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> +			c->dcache.flags |= MIPS_CACHE_VTAG;
> +		if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> +			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +	} else if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0)) {
>   		c->dcache.flags |= MIPS_CACHE_VTAG;
>   		write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
>   	}
