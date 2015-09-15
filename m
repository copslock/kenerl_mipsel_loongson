Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2015 10:10:52 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:40841 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007750AbbIOIKuLyyFT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Sep 2015 10:10:50 +0200
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NUP01Q4KLDU2JD0@mailout3.samsung.com>; Tue,
 15 Sep 2015 17:10:42 +0900 (KST)
Received: from epcpsbgm2new.samsung.com ( [172.20.52.116])
        by epcpsbgr3.samsung.com (EPCPMTA) with SMTP id E1.70.24422.282D7F55; Tue,
 15 Sep 2015 17:10:42 +0900 (KST)
X-AuditID: cbfee68f-f793b6d000005f66-5b-55f7d28210c2
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2new.samsung.com (EPCPMTA)
 with SMTP id 98.3F.18629.182D7F55; Tue, 15 Sep 2015 17:10:42 +0900 (KST)
Received: from [10.252.81.186] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NUP00KWKLDT9NB0@mmp2.samsung.com>; Tue,
 15 Sep 2015 17:10:41 +0900 (KST)
Message-id: <55F7D281.6080103@samsung.com>
Date:   Tue, 15 Sep 2015 17:10:41 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
MIME-version: 1.0
To:     Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
Cc:     Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de,
        dianders@chromium.org, linux-samsung-soc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        CPGS <cpgs@samsung.com>
Subject: Re: [RFC PATCH v7 02/10] mmc: dw_mmc: use macro for HCON register
 operations
References: <1440379479-24308-1-git-send-email-shawn.lin@rock-chips.com>
 <1440379554-24444-1-git-send-email-shawn.lin@rock-chips.com>
In-reply-to: <1440379554-24444-1-git-send-email-shawn.lin@rock-chips.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOztmk5XE6e5MusLJIak6n9nZFPwRHiAhEDSly2vGujU2l
        PpS3wi7iygvI1HQooeayZqlLSZ2aocu7ZunMvGWpH8zyUqTtOCK//d6H3/s8/wceHibUcp14
        kXHxjDJOHiMmbPBKB4/4I6l9K/7SzAkRShucJtGfrDck+mo8hIpau7jo3eNmAq1Oj+FoY2KO
        i0qnPpNobtYNqSfnMKSfHOKi/lcFBHqQm0Wi1g01QN/HNzCU1/2ag0b6Baj+fRdAfQ370ehU
        FRe16wJRyjcdhqbacjD0obKH9Ib0rbQMgv79KwvQ+cm9OG3QmEl6svA5SWcYTIDWV9wl6NGh
        BoJuK9dx6OrSJPqPphGnM19UALp26BFGv2hcAvSSfs952yCbk1eYmMhERul6Otgm4uOQiVAM
        2F+bLxkhkoHZ9h7g8yDlAdcffgFWdoQ9Y1UEy0KqDMBB081/Tn3nIucesLHUNQCaX64B62Mc
        wLmC+xzWElAucFw3j7OMU86wSPeWZJmgDsPa5fZNR0QFQFPeHdzq28HV7DEL83gOlDfUFzmw
        ZYya5cKWuiiW7alAuKgr41pnpQP4LLUKsD6f8oU5P0kWMUoCP/W6WL/uhdWVCxirQyqbD5+Y
        czFrHAouZxs3R0FqN9Q3Yda9dsLmsmH8AXDUbAmk+d9Vs6VrMcAqgIhRhCpUIeFKmUQlj1Ul
        xIVLQq/G6oHlcjrXZ9R1wNx0wggoHhBvE1xIX/EXcuWJquuxRuBpCfEQcxKFXrUcW1z8ZTeZ
        lzvy9PCUuR895iXeIdA6rfkJqXB5PBPNMApGeVmZEMOojIDD4zslg5aTYBcOtR0tRwLyAtMl
        5sJjp4s69oVkhOm89TO3B8MGpTIp36egJMWgJX/4HTAwYluxz/zZVb+k5PHu4xebZQv5TzVA
        rzyjdh1R1wRFXwq+ITpY07o2TJ/SLvneb5799rXziqlNISw2/DIumpylsVFJ50rtqneXk5nb
        BwIFYlwVIXdzwZQq+V+y/gM/NAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsVy+t9jQd2mS99DDVb/47JovvqU3eLvpGPs
        Fi8PaVrMP3KO1eLssoNsFj+e3mOx+P/oNavFkicP2S1evzC06H/8mtli0+NrrBaXd81hs5gw
        dRK7xZH//YwWnx78Z7aYcX4fk8Xty7wWu6+fY7S4tEfF4s6T9awWx9eGWzS+Wsts8eToFGaL
        m2susDtIeLQ097B5/P41idFjdsNFFo+ds+6yezyeu5Hdo2fnGUaPTas62TzuXNvD5nF05Vom
        j81L6j3+ztrP4tG3ZRWjx/Zr85g9tuz/zOjxeZNcAH9UA6NNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDjAglBTKEnNKgUIBicXFSvp2mCaEhrjpWsA0
        Ruj6hgTB9RgZoIGENYwZt66dYSu4IlzxZvFttgbGu/xdjJwcEgImErtPf2SCsMUkLtxbz9bF
        yMUhJDCLUeLu1p+MEM4DRonXc7rBqngFtCQerH3DAmKzCKhKzF97gh3EZhPQkdj+7ThYjahA
        mMSZGR0sEPWCEj8m3wOyOThEBBwkNs0XAQkzC7xglTi8IwvEFhYIl/i4dgUrxK52RokNTesZ
        Qeo5BTwlpnxlBzGZBfQk7l/UgmiVl9i85i3zBEagIxEWzEKomoWkagEj8ypGidSC5ILipPRc
        o7zUcr3ixNzi0rx0veT83E2M4MT2THoH4+Fd7ocYBTgYlXh4I9q/hwqxJpYVV+YeYpTgYFYS
        4Z2/GyjEm5JYWZValB9fVJqTWnyI0RQYAhOZpUST84FJN68k3tDYxMzI0sjc0MLI2FxJnFd2
        5bNQIYH0xJLU7NTUgtQimD4mDk6pBsY5M3kWJous2qW5+dCn94sYzr35zs/DfNTqz/qNs7Jr
        vpWWztvKWztzzpItHyT23bzB4Cz2SJj9auOKx5/uTsgo8nvp4twQlZgdW9yrX5QtZVnnqCA+
        fQODF6+WTJrCorsiDtZ3Gf+H1HZ5ey+sn/8rQCvnynbP3wpe/rdlJz4wYlDZ/HXtqQ9KLMUZ
        iYZazEXFiQAEsgDOggMAAA==
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jh80.chung@samsung.com
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

Hi, Shawn.

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 08/24/2015 10:25 AM, Shawn Lin wrote:
> This patch add some macros for HCON register operations
> to make code more readable.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  drivers/mmc/host/dw_mmc.h | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9c91983..0a3c63c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2678,7 +2678,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>  		* Check ADDR_CONFIG bit in HCON to find
>  		* IDMAC address bus width
>  		*/
> -		addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
> +		addr_config = SDMMC_GET_ADDR_CONFIG(mci_readl(host, HCON));
>  
>  		if (addr_config == 1) {
>  			/* host supports IDMAC in 64-bit address mode */
> @@ -3060,7 +3060,7 @@ int dw_mci_probe(struct dw_mci *host)
>  	 * Get the host data width - this assumes that HCON has been set with
>  	 * the correct values.
>  	 */
> -	i = (mci_readl(host, HCON) >> 7) & 0x7;
> +	i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
>  	if (!i) {
>  		host->push_data = dw_mci_push_data16;
>  		host->pull_data = dw_mci_pull_data16;
> @@ -3142,7 +3142,7 @@ int dw_mci_probe(struct dw_mci *host)
>  	if (host->pdata->num_slots)
>  		host->num_slots = host->pdata->num_slots;
>  	else
> -		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
> +		host->num_slots = SDMMC_GET_SLOT_NUM(mci_readl(host, HCON));
>  
>  	/*
>  	 * Enable interrupts for command done, data over, data empty,
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 811d467..f2a88d4 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -154,6 +154,9 @@
>  #define DMA_INTERFACE_GDMA		(0x2)
>  #define DMA_INTERFACE_NODMA		(0x3)
>  #define SDMMC_GET_TRANS_MODE(x)		(((x)>>16) & 0x3)
> +#define SDMMC_GET_SLOT_NUM(x)		((((x)>>1) & 0x1F) + 1)
> +#define SDMMC_GET_HDATA_WIDTH(x)	(((x)>>7) & 0x7)
> +#define SDMMC_GET_ADDR_CONFIG(x)	(((x)>>27) & 0x1)
>  /* Internal DMAC interrupt defines */
>  #define SDMMC_IDMAC_INT_AI		BIT(9)
>  #define SDMMC_IDMAC_INT_NI		BIT(8)
> 
