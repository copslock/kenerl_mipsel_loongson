Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 11:12:22 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.130]:59266 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011077AbbHEJMUOu67u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 11:12:20 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.172])
        by lucky1.263xmail.com (Postfix) with SMTP id CB78F1E3294;
        Wed,  5 Aug 2015 17:12:03 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 9B39D47F;
        Wed,  5 Aug 2015 17:11:47 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: srinivas.kandagatla@linaro.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <08d5ef7ec68483989ffc7b93a8ae30d6>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 7783BGT14P;
        Wed, 05 Aug 2015 17:12:00 +0800 (CST)
Subject: Re: [RFC PATCH v3 1/5] mmc: dw_mmc: Add external dma interface
 support
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762648-22202-1-git-send-email-shawn.lin@rock-chips.com>
 <8177347.dLpRuMxaEU@diego>
Cc:     shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Seungwon Jeon <tgih.jun@samsung.com>, dianders@chromium.org,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Stefan Agner <stefan@agner.ch>,
        Zhou Wang <wangzhou.bry@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Wang Long <long.wanglong@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Jun Nie <jun.nie@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hao <haokexin@gmail.com>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vin eet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Jean Delvare <jdelvare@suse.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C1D356.5030302@rock-chips.com>
Date:   Wed, 5 Aug 2015 17:11:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <8177347.dLpRuMxaEU@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shawn.lin@rock-chips.com
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

在 2015/8/5 16:49, Heiko Stübner 写道:
> Am Mittwoch, 5. August 2015, 16:17:28 schrieb Shawn Lin:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
> [...]
>
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 5be9767..6c1c7ea 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -16,6 +16,7 @@
>>
>>   #include <linux/scatterlist.h>
>>   #include <linux/mmc/core.h>
>> +#include <linux/dmaengine.h>
>>
>>   #define MAX_MCI_SLOTS	2
>>
>> @@ -40,6 +41,17 @@ enum {
>>
>>   struct mmc_data;
>>
>> +enum {
>> +	TRANS_MODE_PIO = 0,
>> +	TRANS_MODE_IDMAC,
>> +	TRANS_MODE_EDMAC
>> +};
>> +
>> +struct dw_mci_dma_slave {
>> +	struct dma_chan *ch;
>> +	enum dma_transfer_direction direction;
>> +};
>> +
>>   /**
>>    * struct dw_mci - MMC controller state shared between all slots
>>    * @lock: Spinlock protecting the queue and associated data.
>> @@ -147,17 +159,23 @@ struct dw_mci {
>>
>>   	/* DMA interface members*/
>>   	int			use_dma;
>> +	int			trans_mode;
> you're introducing this new trans_mode, but we have "use_dma" already.
>
> So you could just define
>
> enum {
> 	TRANS_DMA_PIO = 0,
> 	TRANS_DMA_IDMAC,
> 	TRANS_DMA_EDMAC
> };
>
> and fill use_dma appropriately. "0" is meaning PIO already, which I also did fix
> up some days ago in "[PATCH] mmc: dw_mmc: fix pio mode when internal dmac is
> enabled" [0].
    I  agree.  "trans_mode" is redundant here since it does the same 
work as "use_dma" to some degree.
    Thanks.
>
> Heiko
>
> [0] https://lkml.org/lkml/2015/8/3/407
>
>
>


-- 
Shawn Lin
