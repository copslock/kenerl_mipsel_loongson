Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 11:28:56 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47001 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816823Ab3EQJ2zZkI2d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 May 2013 11:28:55 +0200
Message-ID: <5195F730.6080103@phrozen.org>
Date:   Fri, 17 May 2013 11:24:00 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Libo Chen <clbchenlibo.chen@huawei.com>
CC:     ralf@linux-mips.org, grant.likely@linaro.org,
        rob.herring@calxeda.com, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH] MIPS: drivers: fix clk leak
References: <5195CC6B.1000607@huawei.com>
In-Reply-To: <5195CC6B.1000607@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36431
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

On 17/05/13 08:21, Libo Chen wrote:
>
> when gptu_r32 fail, we should put clk before return
>
> Signed-off-by: Libo Chen<libo.chen@huawei.com>

Acked-by: John Crispin <blogic@openwrt.org>



> ---
>   arch/mips/lantiq/xway/gptu.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
> index 9861c86..4fa577c 100644
> --- a/arch/mips/lantiq/xway/gptu.c
> +++ b/arch/mips/lantiq/xway/gptu.c
> @@ -169,6 +169,8 @@ static int gptu_probe(struct platform_device *pdev)
>   	if (((gptu_r32(GPTU_ID)>>  8)&  0xff) != GPTU_MAGIC) {
>   		dev_err(&pdev->dev, "Failed to find magic\n");
>   		gptu_hwexit();
> +		clk_disable(clk);
> +		clk_put(clk);
>   		return -ENAVAIL;
>   	}
>
