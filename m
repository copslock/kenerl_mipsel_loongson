Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 13:03:47 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:42596 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826363AbaANMDpG6NFW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jan 2014 13:03:45 +0100
Message-ID: <52D52796.3030509@phrozen.org>
Date:   Tue, 14 Jan 2014 13:03:34 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] arch/mips/lantiq/xway: don't check resource with
 devm_ioremap_resource
References: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38975
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

Hi Wolfgang,

should we take 1/7 and 6/7 via the mips tree ?

    John


On 14/01/2014 12:58, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: John Crispin <blogic@openwrt.org>
> ---
>
> Should go via subsystem tree
>
>  arch/mips/lantiq/xway/dma.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
> index 08f7ebd..78a91fa 100644
> --- a/arch/mips/lantiq/xway/dma.c
> +++ b/arch/mips/lantiq/xway/dma.c
> @@ -220,10 +220,6 @@ ltq_dma_init(struct platform_device *pdev)
>  	int i;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		panic("Failed to get dma resource");
> -
> -	/* remap dma register range */
>  	ltq_dma_membase = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(ltq_dma_membase))
>  		panic("Failed to remap dma resource");
