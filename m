Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 May 2013 11:02:29 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:42830 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816354Ab3EJJCUTd4JB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 May 2013 11:02:20 +0200
Message-ID: <518CB681.4030709@phrozen.org>
Date:   Fri, 10 May 2013 10:57:37 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [RFC 40/42] arch/mips/lantiq/xway: don't check resource with
 devm_ioremap_resource
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de> <1368173847-5661-41-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1368173847-5661-41-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36376
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

On 10/05/13 10:17, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang<wsa@the-dreams.de>

Acked-by: John Crispin <blogic@openwrt.org>

> ---
>   arch/mips/lantiq/xway/gptu.c |    7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
> index 9861c86..26226f0 100644
> --- a/arch/mips/lantiq/xway/gptu.c
> +++ b/arch/mips/lantiq/xway/gptu.c
> @@ -143,13 +143,8 @@ static int gptu_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Failed to get resource\n");
> -		return -ENOMEM;
> -	}
> -
>   	/* remap gptu register range */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	gptu_membase = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(gptu_membase))
>   		return PTR_ERR(gptu_membase);
