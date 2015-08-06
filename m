Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 05:16:01 +0200 (CEST)
Received: from irl-smtp01.263.net ([54.76.167.174]:39659 "EHLO
        irl-smtp01.263.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006810AbbHFDP6ibRYs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 05:15:58 +0200
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by irl-smtp01.263.net (Postfix) with ESMTP id A788D7F8B9;
        Thu,  6 Aug 2015 11:14:08 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: cpgs@samsung.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <96e885a40f323c1babc89f48466bf4e5>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by irl-smtp01.263.net (Postfix) whith ESMTP id 24785ESHPLP;
        Thu, 06 Aug 2015 11:14:07 +0800 (CST)
Subject: Re: [RFC PATCH v3 2/5] Documentation: synopsys-dw-mshc: add bindings
 for idmac and edmac
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@chromium.org>
References: <1438762614-22154-1-git-send-email-shawn.lin@rock-chips.com>
 <1438762672-22243-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=Wv1FLHGyK=yL_P-WbRZwnK2K-rMEaXHjsZf+4iHfucjw@mail.gmail.com>
 <55C2C453.3000005@samsung.com>
Cc:     shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Seungwon Jeon <tgih.jun@samsung.com>,
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
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vineet Gupta <vgupta@synopsys.com>,
        Scott Branden <sbranden@broadcom.com>,
        Anand Moon <linux.amoon@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Tushar Behera <trblinux@gmail.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mischa Jonker <mjonker@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Vincent Yang <vincent.yang.fujitsu@gmail.com>,
        Stephen Warren <swarren@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>,
        Joachim Eastwood <manabian@gmail.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        Weijun Yang <Weijun.Yang@csr.com>,
        Peter Griffin <peter.griffin@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        addy ke <addy.ke@rock-chips.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Kevin Hilman <khilman@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Andreas Faerber <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        CPGS <cpgs@samsung.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55C2D0F3.8000300@rock-chips.com>
Date:   Thu, 6 Aug 2015 11:13:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <55C2C453.3000005@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <lintao@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48649
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

在 2015/8/6 10:20, Jaehoon Chung 写道:
> On 08/06/2015 11:16 AM, Doug Anderson wrote:
>> Shawn,
>>
>> On Wed, Aug 5, 2015 at 1:17 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> synopsys-dw-mshc supports three types of transfer mode. We add bindings
>>> and description for how to use them at runtime. Without idmac and edmac
>>> property, pio is the default transfer mode. Make sure that Idmac and emdac
>>> should not be used simultaneously.
>> Can't you just read the HCON register?
>>
>> [17:16]: DMA_INTERFACE
>>   00: none
>>   01: DW_DMA
>>   10: GENERIC_DMA
>>   11: NON-DW-DMA
> If read it and get the exactly information. I think we can use that information.

  It's helpful really, but the description is ambiguous. ：(
  So I make a big big mistake when I read it for the firest time .
  I was just wondering the "mismatch" value from HCON and my databook.

Here I get details from our ASIC team guy :

// Name:         DMA_INTERFACE
// Default:      None
// Values:       None (0), DW-DMA (1), Generic-DMA (2), NON-DW-DMA (3)
// Enabled:      INTERNAL_DMAC==0
//
// Configures the type for DMA interface. In addition to AMBA host 
interface,
//  the data FIFO can be accesses by the optional DMA interface. The DMA 
type
//  could be either DW-DMA, which provides hand shake signals to 
DW_ahb_dmac
//  controller, or a generic DMA interface which provides a simpler
//  request/acknowledgement protocol and dedicated DMA data-bus, or
//  no DMA interface.
`define DMA_INTERFACE 1

   if we use idmac, DMA_INTERFACE should be "0", and we get 2b'00 from 
HCON[17:16]
   if we use edmac, DMA_INTERFACE should be "1", "2" and we get 2b'01 ,2b'10
   from HCON[17:16] respectively .
   But if only support PIO mode,   DMA_INTERFACE should be "3", and we 
get 2b'11 from
   HCON[17:16].

   So, "none" means IDMAC, "DW_DMA"/"GENERIC_DMA" refer to two types of 
external dma and "NON-DW-DMA" means pio from databook . It's a little 
difficult to understand it.

  This makes my work easy!

  Thanks, Doug and Jeahoon.

> Best Regards,
> Jaehoon Chung
>
>
>
>


-- 
Shawn Lin
