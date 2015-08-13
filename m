Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 02:08:44 +0200 (CEST)
Received: from regular1.263xmail.com ([211.150.99.140]:59374 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011549AbbHMAImJk20W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Aug 2015 02:08:42 +0200
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.139])
        by regular1.263xmail.com (Postfix) with SMTP id 1072F4B0F;
        Thu, 13 Aug 2015 08:08:27 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-ADDR-CHECKED: 0
Received: from [172.16.12.109] (localhost.localdomain [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTP id 265C8407;
        Thu, 13 Aug 2015 08:08:23 +0800 (CST)
X-RL-SENDER: shawn.lin@rock-chips.com
X-FST-TO: devicetree@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-UNIQUE-TAG: <d3eb01aa38cd344f3aca3c63a1b00a11>
X-ATTACHMENT-NUM: 0
X-SENDER: lintao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.109] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 30810CUHLFU;
        Thu, 13 Aug 2015 08:08:25 +0800 (CST)
Subject: Re: [RFC PATCH v4 3/9] mips: pistachio_defconfig: remove
 CONFIG_MMC_DW_IDMAC
To:     Ralf Baechle <ralf@linux-mips.org>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843515-23935-1-git-send-email-shawn.lin@rock-chips.com>
 <20150812220500.GD11636@linux-mips.org>
Cc:     shawn.lin@rock-chips.com, jh80.chung@samsung.com,
        ulf.hansson@linaro.org, heiko@sntech.de, dianders@chromium.org,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Jun Nie <jun.nie@linaro.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <55CBDFF6.9090900@rock-chips.com>
Date:   Thu, 13 Aug 2015 08:08:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20150812220500.GD11636@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <shawn.lin@rock-chips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48829
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

在 2015/8/13 6:05, Ralf Baechle 写道:
> On Thu, Aug 06, 2015 at 02:45:15PM +0800, Shawn Lin wrote:
>
>> DesignWare MMC Controller's transfer mode should be decided
>> at runtime instead of compile-time. So we remove this config
>> option and read dw_mmc's register to select DMA master.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   arch/mips/configs/pistachio_defconfig | 1 -
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
> Please feel free to merge this patch with the remainder
> of the series.
>

Thanks, Ralf. :)

v5 is coming which will be rebased on 
"https://github.com/jh80chung/dw-mmc.git tags/dw-mmc-for-ulf-v4.2" for 
the next merge window
that make Jeahoon do it easier. Also define new macro for reading
HCON register suggested by Joachim.


>    Ralf
>
>
>


-- 
Shawn Lin
