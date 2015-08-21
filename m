Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Aug 2015 09:48:43 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.135]:49247 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010085AbbHUHslqdoBV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Aug 2015 09:48:41 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.172])
        by regular1.263xmail.com (Postfix) with SMTP id 2AEE01B02B;
        Fri, 21 Aug 2015 15:48:36 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id A182148C;
        Fri, 21 Aug 2015 15:48:30 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: jun.nie@linaro.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <e56a2fc8057f0f63bafe3501038351a7>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 19030VDPVUP;
        Fri, 21 Aug 2015 15:48:33 +0800 (CST)
Subject: Re: [RFC PATCH v6 1/9] mmc: dw_mmc: Add external dma interface
 support
To:     Jaehoon Chung <jh80.chung@samsung.com>, ulf.hansson@linaro.org
References: <1440060204-26203-1-git-send-email-shawn.lin@rock-chips.com>
 <1440060233-26244-1-git-send-email-shawn.lin@rock-chips.com>
 <55D6C4D4.8010005@samsung.com> <55D6C57D.4070402@rock-chips.com>
 <55D6C6B6.3060706@samsung.com> <55D6D2EF.7010501@rock-chips.com>
 <55D6D581.3050509@samsung.com>
Cc:     shawn.lin@rock-chips.com, linux-mips@linux-mips.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        CPGS <cpgs@samsung.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vineet.Gupta1@synopsys.com,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        dianders@chromium.org, Ralf Baechle <ralf@linux-mips.org>,
        Jun Nie <jun.nie@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55D6D7D1.90105@rock-chips.com>
Date:   Fri, 21 Aug 2015 15:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <55D6D581.3050509@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48978
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

On 2015/8/21 15:38, Jaehoon Chung wrote:
> On 08/21/2015 04:27 PM, Shawn Lin wrote:
>> On 2015/8/21 14:35, Jaehoon Chung wrote:
>>> On 08/21/2015 03:30 PM, Shawn Lin wrote:
>>>> On 2015/8/21 14:27, Jaehoon Chung wrote:
>>>>> Hi, Shawn.
>>>>>
>>>>> Is this based on Ulf's repository?
>>>>
>>>>
>>>> no, it's based on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" ：）
>>>
>>> Oh..I will rebase to Ulf's next branch on this weekend.
>>> Then could you rebase this patch? And i added more comments at below.. :)
>>>
>>
>> Okay, I will rebase to Ulf's next.
>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>
>> [...]
>>
>>>>>> index ec6dbcd..7e1d13b 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>>>>> @@ -59,6 +59,8 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>>>>>>         host->pdata = pdev->dev.platform_data;
>>>>>>
>>>>>>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>> +    /* Get registers' physical base address */
>>>>>> +    host->phy_regs = (void *)(regs->start);
>>>>>>         host->regs = devm_ioremap_resource(&pdev->dev, regs);
>>>>>>         if (IS_ERR(host->regs))
>>>>>>             return PTR_ERR(host->regs);
>>>>>
>>>>> Is this board specific code? If so, separate the patch.
>>
>> It's might not board specific code.
>> dmaengine need dw_mmc's *physical* fifo address for data transfer, so I get controller physical address  here in order to calculate physical fifo address.
>>
>> regs is from dt-bindings, for instance:
>>           dwmmc0@12200000 {
>>                   compatible = "snps,dw-mshc";
>>                    clocks = <&clock 351>, <&clock 132>;
>>                   clock-names = "biu", "ciu";
>>                   reg = <0x12200000 0x1000>;
>>                   interrupts = <0 75 0>;
>>                   #address-cells = <1>;
>>                   #size-cells = <0>;
>>           };
>>
>> so, host->phy_regs will be 0x12200000 .
>>
>> [...]
>>
>>>>>> +static void dw_mci_dmac_complete_dma(void *arg)
>>>>>>     {
>>>>>> +    struct dw_mci *host = arg;
>>>>>>         struct mmc_data *data = host->data;
>>>>>>
>>>>>>         dev_vdbg(host->dev, "DMA complete\n");
>>>>>>
>>>>>> +    if (host->use_dma == TRANS_MODE_EDMAC)
>>>>>> +        if (data && (data->flags & MMC_DATA_READ))
>>>>>
>>>>> Combine one condition.
>>
>> okay.
>>
>> [...]
>>
>>>>>> +    u32 fifo_offset = host->fifo_reg - host->regs;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    /* Set external dma config: burst size, burst width */
>>>>>> +    cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
>>>>>
>>>>> host->phy_regs is not assigned?
>>
>> we got it at dw_mci_pltfm_register. See comments above. :)
>>
>> [...]
>>
>>>>>>             mmc->max_blk_count = mmc->max_req_size / 512;
>>>>>> +    } else if (host->use_dma == TRANS_MODE_EDMAC) {
>>>>>> +            mmc->max_segs = 64;
>>>>>> +            mmc->max_blk_size = 65536;
>>>>>> +            mmc->max_blk_count = 65535;
>>>>>> +            mmc->max_req_size =
>>>>>> +                    mmc->max_blk_size * mmc->max_blk_count;
>>>>>> +            mmc->max_seg_size = mmc->max_req_size;
>>>>>
>>>>> Fix the indention
>>
>> Hmm..I check it attentively but can't find the indention . Might it's because you apply it against Ulf's repo?
>>
>>>>>
>>
>> [...]
>>
>>>>>>
>>>>>> -    /* Alloc memory for sg translation */
>>>>>> -    host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
>>>>>> -                      &host->sg_dma, GFP_KERNEL);
>>>>>> -    if (!host->sg_cpu) {
>>>>>> -        dev_err(host->dev, "%s: could not alloc DMA memory\n",
>>>>>> -            __func__);
>>>>>> +    /* Check tansfer mode */
>>>>>> +    trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>>>>>> +    if (trans_mode == 0) {
>>>>>> +        trans_mode = TRANS_MODE_IDMAC;
>>>>>> +    } else if (trans_mode == 1 || trans_mode == 2) {
>>>>>> +        trans_mode = TRANS_MODE_EDMAC;
>>>>>> +    } else {
>>>>>> +        trans_mode = TRANS_MODE_PIO;
>>>>>
>>>>> what are trans_mode "0, 1, 2"?
>>>>> (00 - none) is NO-DMA interface, isn't? is it IDMAC mode?
>>>>>
>>
>> No, I guess the databook's ambiguous description confuse everybody.
>>
>> I got double comfirm from my ASCI team as well as Synoposys
>> 2b'00: NO-DMA interface -->  It support IDMAC actually
>> 2b'01 & 2b'02: DW_DMA & GENERIC_DMA --> Support 2 types of external dma.
>> 2b'02: NON-DW-DMA --> only support PIO
>
> Then Could you add the comment about this?
> Use definition instead of "0, 1, 2". Developer don't know meaning that is 0, 1, 2.
>

Okay. :)))

> Best Regards,
> Jaehoon Chung
>
>>
>> refer to the description below:
>> Parameter Name: DMA_INTERFACE
>> Legal Values: 0-3
>> Default Value: 0
>> Description:
>>   0- No DMA Interface
>>   1- DesignWare DMA Interface
>>   2- Generic DMA Interface
>>   3- Non DW DMA Interface
>> In DesignWare DMA mode, request/acknowledge protocol meets DW_ahb_dmac
>> controller protocol. In this mode, host data bus is also used for DMA transfers.Generic DMA-type interface has simpler request/acknowledge handshake and has dedicated read/write data bus for DMA transfers. Non DW DMAC interface uses dw_dma_single interface in addition to the existing interface and uses host data bus for DMA transfers. This is configurable only if INTERNAL_DMAC=0.
>>
>>>>>>             goto no_dma;
>>>>>>         }
>>>
>>>>>> +        dev_info(host->dev, "Using external DMA controller.\n");
>>>>>> +    }
>>>>>>
>>>>>>         if (!host->dma_ops)
>>>>>>             goto no_dma;
>>>>>> @@ -2562,12 +2720,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
>>>>>>             goto no_dma;
>>>>>>         }
>>>>>>
>>>>>> -    host->use_dma = 1;
>>>>>> +    host->use_dma = trans_mode;
>>>>>
>>>>> Also confuse, if trans_mode is assigned host->use_dma, can mode value be directly assigned to host->use_dma?
>>>>>
>>
>> Good idea, I will do it.  :)
>>
>>>>> trans_mode = TRAMS_MODE_PIO;
>>>>> host->use_dma = trans_mode;
>>>>>
>>
>> [...]
>>
>>>>>>
>>>>>> @@ -2890,7 +3047,7 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>>          * Get the host data width - this assumes that HCON has been set with
>>>>>>          * the correct values.
>>>>>>          */
>>>>>> -    i = (mci_readl(host, HCON) >> 7) & 0x7;
>>>>>> +    i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
>>>>>
>>>>> This is not related with supporting external dma interface.
>>>>> Separate this.
>>>>>
>>
>> Okay, It will be split into another one.
>>
>>>>>>         if (!i) {
>>>>>>             host->push_data = dw_mci_push_data16;
>>>>>>             host->pull_data = dw_mci_pull_data16;
>>
>>
>>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>


-- 
Best Regards
Shawn Lin
