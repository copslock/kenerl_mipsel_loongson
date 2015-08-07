Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 01:38:23 +0200 (CEST)
Received: from lucky1.263xmail.com ([211.157.147.132]:34147 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012768AbbHGXiTRmXPV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2015 01:38:19 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.131])
        by lucky1.263xmail.com (Postfix) with SMTP id B383C56203;
        Sat,  8 Aug 2015 07:38:02 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [192.168.1.101] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id F11093F1;
        Sat,  8 Aug 2015 07:37:58 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: devicetree@vger.kernel.org
X-SENDER-IP: 220.200.5.85
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <1f5e89bb24f2a987bef396515e21db8a>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [192.168.1.101] (unknown [220.200.5.85])
        by smtp.263.net (Postfix) whith ESMTP id 20840ZYJPVX;
        Sat, 08 Aug 2015 07:38:01 +0800 (CST)
Subject: Re: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface
 support
To:     Joachim Eastwood <manabian@gmail.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
 <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
Cc:     lintao@rock-chips.com, jh80.chung@samsung.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C54153.2070709@rock-chips.com>
Date:   Sat, 8 Aug 2015 07:37:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48729
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

在 2015/8/8 5:32, Joachim Eastwood 写道:
> Hi Shawn,
>
> On 6 August 2015 at 08:44, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>> @@ -2256,26 +2373,30 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>
>>          }
>>
>> -#ifdef CONFIG_MMC_DW_IDMAC
>> -       /* Handle DMA interrupts */
>> -       if (host->dma_64bit_address == 1) {
>> -               pending = mci_readl(host, IDSTS64);
>> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
>> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
>> -                                                       SDMMC_IDMAC_INT_RI);
>> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
>> -                       host->dma_ops->complete(host);
>> -               }
>> -       } else {
>> -               pending = mci_readl(host, IDSTS);
>> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
>> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
>> -                                                       SDMMC_IDMAC_INT_RI);
>> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>> -                       host->dma_ops->complete(host);
>> +       if (host->use_dma == TRANS_MODE_IDMAC) {
>
> Doing:
> if (host->use_dma != TRANS_MODE_IDMAC)
>      return IRQ_HANDLED;
>

Okay.

> Could save you the extra level of identation you add below.
>
>> +               /* Handle DMA interrupts */
>> +               if (host->dma_64bit_address == 1) {
>> +                       pending = mci_readl(host, IDSTS64);
>> +                       if (pending & (SDMMC_IDMAC_INT_TI |
>> +                                      SDMMC_IDMAC_INT_RI)) {
>> +                               mci_writel(host, IDSTS64,
>> +                                          SDMMC_IDMAC_INT_TI |
>> +                                          SDMMC_IDMAC_INT_RI);
>> +                               mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
>> +                               host->dma_ops->complete((void *)host);
>> +                       }
>> +               } else {
>> +                       pending = mci_readl(host, IDSTS);
>> +                       if (pending & (SDMMC_IDMAC_INT_TI |
>> +                                      SDMMC_IDMAC_INT_RI)) {
>> +                               mci_writel(host, IDSTS,
>> +                                          SDMMC_IDMAC_INT_TI |
>> +                                          SDMMC_IDMAC_INT_RI);
>> +                               mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>> +                               host->dma_ops->complete((void *)host);
>> +                       }
>>                  }
>>          }
>> -#endif
>>
>>          return IRQ_HANDLED;
>>   }
>
>
>> @@ -2437,6 +2567,21 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>>   static void dw_mci_init_dma(struct dw_mci *host)
>>   {
>>          int addr_config;
>> +       int trans_mode;
>> +       struct device *dev = host->dev;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       /* Check tansfer mode */
>> +       trans_mode = (mci_readl(host, HCON) >> 16) & 0x3;
>
> I think it would be nice if you could add some defines for 16 and 0x03
> or add a macro like SDMMC_GET_FCNT() that is in dw_mmc.h.
>

yes, it's better to avoid magic number for register operation to make
others understand w/o checking databook for details. And might more than 
one (e.g "Check ADDR_CONFIG bit in HCON to find IDMAC address bus 
width") should be modified.

Although one patch only do one thing, I will drop by to make it in v5.

>> +       if (trans_mode == 0) {
>> +               trans_mode = TRANS_MODE_IDMAC;
>> +       } else if (trans_mode == 1 || trans_mode == 2) {
>> +               trans_mode = TRANS_MODE_EDMAC;
>> +       } else {
>> +               trans_mode = TRANS_MODE_PIO;
>> +               goto no_dma;
>> +       }
>> +
>>          /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>>          addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
>
> I'll try to get this patch tested on my lpc18xx platform soon.
> btw, the HCON reg on lpc18xx reads as 0x00e42cc1 (address 0x40004070).
>

yes, HCON[17:16] is 2b'00 means your lpc18xx use IDMAC.

>
> regard,
> Joachim Eastwood
>
>
>


-- 
Shawn Lin
