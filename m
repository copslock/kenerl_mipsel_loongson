Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 07:56:53 +0100 (CET)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:56537
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27008859AbbJZG4vavlET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 07:56:51 +0100
Subject: Re: [PATCH] MIPS: lantiq: add clk_round_rate()
To:     linux-mips@linux-mips.org
References: <1445811702-27936-1-git-send-email-hauke@hauke-m.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <562DCEB2.1070304@phrozen.org>
Date:   Mon, 26 Oct 2015 07:56:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445811702-27936-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 25/10/2015 23:21, Hauke Mehrtens wrote:
> This adds a basic implementation of clk_round_rate()
> The clk_round_rate() function is called by multiple drivers and
> subsystems now and the lantiq clk driver is supposed to export this,
> but doesn't do so, this causes linking problems like this one:
> ERROR: "clk_round_rate" [drivers/media/v4l2-core/videodev.ko] undefined!
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: <stable@vger.kernel.org> # 4.1+

Acked-by: John Crispin <blogic@openwrt.org>




> ---
>  arch/mips/lantiq/clk.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
> index 3fc2e6d..a0706fd 100644
> --- a/arch/mips/lantiq/clk.c
> +++ b/arch/mips/lantiq/clk.c
> @@ -99,6 +99,23 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>  }
>  EXPORT_SYMBOL(clk_set_rate);
>  
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	if (unlikely(!clk_good(clk)))
> +		return 0;
> +	if (clk->rates && *clk->rates) {
> +		unsigned long *r = clk->rates;
> +
> +		while (*r && (*r != rate))
> +			r++;
> +		if (!*r) {
> +			return clk->rate;
> +		}
> +	}
> +	return rate;
> +}
> +EXPORT_SYMBOL(clk_round_rate);
> +
>  int clk_enable(struct clk *clk)
>  {
>  	if (unlikely(!clk_good(clk)))
> 
