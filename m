Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Aug 2015 09:38:54 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:50319 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010085AbbHUHiwAcr3V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Aug 2015 09:38:52 +0200
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NTF020GM98IQNE0@mailout4.samsung.com>; Fri,
 21 Aug 2015 16:38:42 +0900 (KST)
Received: from epcpsbgm1new.samsung.com ( [172.20.52.114])
        by epcpsbgr4.samsung.com (EPCPMTA) with SMTP id 02.45.20564.185D6D55; Fri,
 21 Aug 2015 16:38:42 +0900 (KST)
X-AuditID: cbfee690-f796f6d000005054-22-55d6d5811018
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm1new.samsung.com (EPCPMTA) with SMTP id 8B.2D.23663.185D6D55; Fri,
 21 Aug 2015 16:38:41 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
Received: from [10.252.81.186] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NTF0020D98HEA60@mmp1.samsung.com>; Fri,
 21 Aug 2015 16:38:41 +0900 (KST)
Message-id: <55D6D581.3050509@samsung.com>
Date:   Fri, 21 Aug 2015 16:38:41 +0900
From:   Jaehoon Chung <jh80.chung@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101
 Thunderbird/31.7.0
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
Subject: Re: [RFC PATCH v6 1/9] mmc: dw_mmc: Add external dma interface support
References: <1440060204-26203-1-git-send-email-shawn.lin@rock-chips.com>
 <1440060233-26244-1-git-send-email-shawn.lin@rock-chips.com>
 <55D6C4D4.8010005@samsung.com> <55D6C57D.4070402@rock-chips.com>
 <55D6C6B6.3060706@samsung.com> <55D6D2EF.7010501@rock-chips.com>
In-reply-to: <55D6D2EF.7010501@rock-chips.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURzGOXvfvZuj4ZvNPC1SkMLSvE89dsNvnT6EhS1JAl32ppbOtanl
        l1xZdKGL6YK5bkZu6JpYS3KapJu3LmZecmXqsNSwRiO7SFa23N4gvz3n4f885/+DP5/ws3DF
        /Bx5AaOUy3KDKQFpEkmU4SeG7NKo0WJUOjTFQ/PlXTz0wbYO3ezo5aLnBiuFfkw5SOR+5+Si
        6sm3POScjkaXJpwEMk/YuWiw+RqFyq6U81CH+xJAX8bdBNK+eMRBI4NC9PBVL0ADLavR6GQ9
        F3XXpaLjH+sINNmpIdCwqY+XBPHJ0vMU/vWzHOCr6n4SN+nGeHji+j0ePt/UA7DZeJbCo/YW
        CnfW1nHw/eoSPK9rJfHFBiPAjfYbBG5o/QrwV3PgDt80wab9TG5OEaOM3JIhyNZbTpOKFslR
        /alHhBrcCjkHfPiQlkCjqYpg9XLY56inzgEB34+uAfBT5YOFB987VO/azPp6AK+o5ziegJBe
        Cn9UOEjPDEGHQI0mz2MTtAg+Nhi4rA6DhltOgs2OAzg+O0ew2VCodQ3wPJqk18CZX7WUR1P0
        etg42+3t96d3wx7tGW+/iE6C5psitnOaC9stBz32MjoZWktz2foLHFhu6vDW+NARcLryt5cF
        0hU+0Gx0k+xfNJytsJEs1ypobvvHvgJaa16TZSBAt4hM959Mt4hMt4isCpBG4M8oMhWqfVlK
        SYRKlqcqlGdFZObnmcHCQT37877MAhxtG22A5oPgJcLKPXapH1dWpCrOs4G4hYUuE2L/zPyF
        G5QXpEfHxsegOElcbExCYnxwgNApnkvxo7NkBcwhhlEwynRlYS6jsgEO30esBkd6fFNCRdaf
        G1duWntn9QFzWObadHKVPOh74pmobV3i4nYX1nyez+hL6E/Z7apMfDpjXbZrpscQERgWK+w7
        9q0uu3tnwt6S9tQnZG1zWn/Sy4/SDb7J1eGHBZ+bgkoiC7okliqH1Lm1KWgkWjimv7d++12p
        tup31PTw7ZI3eKa3MJhUZcuiQwmlSvYXgpZViksDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsVy+t9jAd3Gq9dCDS7dNrFovvqU3eLvpGPs
        Fi8PaVrMP3KO1eLssoNsFj+e3mOx+P/oNavFkicP2S1evzC06H/8mtli0+NrrBaXd81hs5gw
        dRK7xZH//YwWnx78Z7aYcX4fk8Xty7wWu6+fY7S4tEfF4s6T9awWx9eGWzS+Wsts8eToFGaL
        m2susDtIeLQ097B5/P41idFjdsNFFo+ds+6yezyeu5Hdo2fnGUaPTas62TzuXNvD5nF05Vom
        j81L6j3+ztrP4tG3ZRWjx/Zr85g9tuz/zOjxeZNcAH9UA6NNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDjAglBTKEnNKgUIBicXFSvp2mCaEhrjpWsA0
        Ruj6hgTB9RgZoIGENYwZh541sxUcMK7Y+7KHrYFxqVoXIweHhICJxPp3tl2MnECmmMSFe+vZ
        uhi5OIQEljJKTG34yQSS4BUQlPgx+R4LSD2zgLzEkUvZEKa6xJQpuRDlDxglHnz7yQxRriUx
        490ldhCbRUBV4uPvlWwgNpuAjsT2b8fBRooKhEmcmdEBNlJEwEFi03wRkDCzwAtWicM7skDC
        wgL+EgebcyDG9zJJTFpzBGwMp4CexIuZf9gmMArMQnLcLITjZiEct4CReRWjRGpBckFxUnqu
        YV5quV5xYm5xaV66XnJ+7iZGcEp7JrWD8eAu90OMAhyMSjy8MyKvhQqxJpYVV+YeYpTgYFYS
        4d2/BijEm5JYWZValB9fVJqTWnyI0RTou4nMUqLJ+cB0m1cSb2hsYmZkaWRuaGFkbK4kziu7
        YXOokEB6YklqdmpqQWoRTB8TB6dUA+O++c7em99N3TOFSXZmrdClTeLHgrw0q1dMdHTIz1Ca
        bpCx8pD28dPzdb60Xf9f9ufGoVQtw4NH2yqS50vt5t2p1ps6kefon7wJDDWVbGbHV679NvHX
        r002j7dKLN6SPrn11yGjHaX1rG1tPa/05M5duNYrk/6t1PphsqKMW6KfdXLMyb8JM32UWIoz
        Eg21mIuKEwH+fjcXfwMAAA==
DLP-Filter: Pass
X-MTR:  20000000000000000@CPGS
X-CFilter-Loop: Reflected
Return-Path: <jh80.chung@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48977
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

On 08/21/2015 04:27 PM, Shawn Lin wrote:
> On 2015/8/21 14:35, Jaehoon Chung wrote:
>> On 08/21/2015 03:30 PM, Shawn Lin wrote:
>>> On 2015/8/21 14:27, Jaehoon Chung wrote:
>>>> Hi, Shawn.
>>>>
>>>> Is this based on Ulf's repository?
>>>
>>>
>>> no, it's based on "https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" ：）
>>
>> Oh..I will rebase to Ulf's next branch on this weekend.
>> Then could you rebase this patch? And i added more comments at below.. :)
>>
> 
> Okay, I will rebase to Ulf's next.
> 
>> Best Regards,
>> Jaehoon Chung
>>
>>>
> 
> [...]
> 
>>>>> index ec6dbcd..7e1d13b 100644
>>>>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>>>>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>>>>> @@ -59,6 +59,8 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>>>>>        host->pdata = pdev->dev.platform_data;
>>>>>
>>>>>        regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +    /* Get registers' physical base address */
>>>>> +    host->phy_regs = (void *)(regs->start);
>>>>>        host->regs = devm_ioremap_resource(&pdev->dev, regs);
>>>>>        if (IS_ERR(host->regs))
>>>>>            return PTR_ERR(host->regs);
>>>>
>>>> Is this board specific code? If so, separate the patch.
> 
> It's might not board specific code.
> dmaengine need dw_mmc's *physical* fifo address for data transfer, so I get controller physical address  here in order to calculate physical fifo address.
> 
> regs is from dt-bindings, for instance:
>          dwmmc0@12200000 {
>                  compatible = "snps,dw-mshc";
>                   clocks = <&clock 351>, <&clock 132>;
>                  clock-names = "biu", "ciu";
>                  reg = <0x12200000 0x1000>;
>                  interrupts = <0 75 0>;
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>          };
> 
> so, host->phy_regs will be 0x12200000 .
> 
> [...]
> 
>>>>> +static void dw_mci_dmac_complete_dma(void *arg)
>>>>>    {
>>>>> +    struct dw_mci *host = arg;
>>>>>        struct mmc_data *data = host->data;
>>>>>
>>>>>        dev_vdbg(host->dev, "DMA complete\n");
>>>>>
>>>>> +    if (host->use_dma == TRANS_MODE_EDMAC)
>>>>> +        if (data && (data->flags & MMC_DATA_READ))
>>>>
>>>> Combine one condition.
> 
> okay.
> 
> [...]
> 
>>>>> +    u32 fifo_offset = host->fifo_reg - host->regs;
>>>>> +    int ret = 0;
>>>>> +
>>>>> +    /* Set external dma config: burst size, burst width */
>>>>> +    cfg.dst_addr = (dma_addr_t)(host->phy_regs + fifo_offset);
>>>>
>>>> host->phy_regs is not assigned?
> 
> we got it at dw_mci_pltfm_register. See comments above. :)
> 
> [...]
> 
>>>>>            mmc->max_blk_count = mmc->max_req_size / 512;
>>>>> +    } else if (host->use_dma == TRANS_MODE_EDMAC) {
>>>>> +            mmc->max_segs = 64;
>>>>> +            mmc->max_blk_size = 65536;
>>>>> +            mmc->max_blk_count = 65535;
>>>>> +            mmc->max_req_size =
>>>>> +                    mmc->max_blk_size * mmc->max_blk_count;
>>>>> +            mmc->max_seg_size = mmc->max_req_size;
>>>>
>>>> Fix the indention
> 
> Hmm..I check it attentively but can't find the indention . Might it's because you apply it against Ulf's repo?
> 
>>>>
> 
> [...]
> 
>>>>>
>>>>> -    /* Alloc memory for sg translation */
>>>>> -    host->sg_cpu = dmam_alloc_coherent(host->dev, PAGE_SIZE,
>>>>> -                      &host->sg_dma, GFP_KERNEL);
>>>>> -    if (!host->sg_cpu) {
>>>>> -        dev_err(host->dev, "%s: could not alloc DMA memory\n",
>>>>> -            __func__);
>>>>> +    /* Check tansfer mode */
>>>>> +    trans_mode = SDMMC_GET_TRANS_MODE(mci_readl(host, HCON));
>>>>> +    if (trans_mode == 0) {
>>>>> +        trans_mode = TRANS_MODE_IDMAC;
>>>>> +    } else if (trans_mode == 1 || trans_mode == 2) {
>>>>> +        trans_mode = TRANS_MODE_EDMAC;
>>>>> +    } else {
>>>>> +        trans_mode = TRANS_MODE_PIO;
>>>>
>>>> what are trans_mode "0, 1, 2"?
>>>> (00 - none) is NO-DMA interface, isn't? is it IDMAC mode?
>>>>
> 
> No, I guess the databook's ambiguous description confuse everybody.
> 
> I got double comfirm from my ASCI team as well as Synoposys
> 2b'00: NO-DMA interface -->  It support IDMAC actually
> 2b'01 & 2b'02: DW_DMA & GENERIC_DMA --> Support 2 types of external dma.
> 2b'02: NON-DW-DMA --> only support PIO

Then Could you add the comment about this?
Use definition instead of "0, 1, 2". Developer don't know meaning that is 0, 1, 2.

Best Regards,
Jaehoon Chung

> 
> refer to the description below:
> Parameter Name: DMA_INTERFACE
> Legal Values: 0-3
> Default Value: 0
> Description:
>  0- No DMA Interface
>  1- DesignWare DMA Interface
>  2- Generic DMA Interface
>  3- Non DW DMA Interface
> In DesignWare DMA mode, request/acknowledge protocol meets DW_ahb_dmac
> controller protocol. In this mode, host data bus is also used for DMA transfers.Generic DMA-type interface has simpler request/acknowledge handshake and has dedicated read/write data bus for DMA transfers. Non DW DMAC interface uses dw_dma_single interface in addition to the existing interface and uses host data bus for DMA transfers. This is configurable only if INTERNAL_DMAC=0.
> 
>>>>>            goto no_dma;
>>>>>        }
>>
>>>>> +        dev_info(host->dev, "Using external DMA controller.\n");
>>>>> +    }
>>>>>
>>>>>        if (!host->dma_ops)
>>>>>            goto no_dma;
>>>>> @@ -2562,12 +2720,12 @@ static void dw_mci_init_dma(struct dw_mci *host)
>>>>>            goto no_dma;
>>>>>        }
>>>>>
>>>>> -    host->use_dma = 1;
>>>>> +    host->use_dma = trans_mode;
>>>>
>>>> Also confuse, if trans_mode is assigned host->use_dma, can mode value be directly assigned to host->use_dma?
>>>>
> 
> Good idea, I will do it.  :)
> 
>>>> trans_mode = TRAMS_MODE_PIO;
>>>> host->use_dma = trans_mode;
>>>>
> 
> [...]
> 
>>>>>
>>>>> @@ -2890,7 +3047,7 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>         * Get the host data width - this assumes that HCON has been set with
>>>>>         * the correct values.
>>>>>         */
>>>>> -    i = (mci_readl(host, HCON) >> 7) & 0x7;
>>>>> +    i = SDMMC_GET_HDATA_WIDTH(mci_readl(host, HCON));
>>>>
>>>> This is not related with supporting external dma interface.
>>>> Separate this.
>>>>
> 
> Okay, It will be split into another one.
> 
>>>>>        if (!i) {
>>>>>            host->push_data = dw_mci_push_data16;
>>>>>            host->pull_data = dw_mci_pull_data16;
> 
> 
> 
