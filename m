Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 05:40:35 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:52631 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006153AbbKZEkdU890c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 05:40:33 +0100
Received: from [127.0.0.1] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Wed, 25 Nov 2015
 21:40:25 -0700
Subject: Re: [PATCH 12/14] DEVICETREE: Add bindings for PIC32 SDHC host
 controller
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-kernel@vger.kernel.org>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-13-git-send-email-joshua.henderson@microchip.com>
 <56508B72.8070701@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>,
        Andrei Pistirica <andrei.pistirica@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56568D37.7030406@microchip.com>
Date:   Wed, 25 Nov 2015 21:40:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56508B72.8070701@cogentembedded.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joshua.henderson@microchip.com
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

Hi Sergei,

On 11/21/2015 8:19 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 11/21/2015 3:17 AM, Joshua Henderson wrote:
> 
>> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>>
>> Document the devicetree bindings for the SDHC peripheral found on
>> Microchip PIC32 class devices.
>>
>> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> ---
>>   .../devicetree/bindings/mmc/sdhci-pic32.txt        |   24 ++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
>> new file mode 100644
>> index 0000000..f16388c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pic32.txt
>> @@ -0,0 +1,24 @@
>> +* Microchip PIC32 SDHCI Controller
>> +
>> +This file documents differences between the core properties in mmc.txt
>> +and the properties used by the sdhci-pic32 driver.
>> +
>> +Required properties:
>> +- compatible: Should be "microchip,pic32-sdhci"
>> +- reg: Should contain registers location and length
>> +- interrupts: Should contain interrupt
>> +- pinctrl: Should contain pinctrl for data and command lines
> 
>    This is a required prop, yet the example doesn't contain it?
> 

Ack.  Both the required properties and example need to contain pinctrl-names and pinctrl-0, not pinctrl.

>> +
>> +Optional properties:
>> +- no-1-8-v: 1.8V voltage selection not supported
>> +- piomode: disable DMA support
>> +
>> +Example:
>> +
>> +    sdhci@1f8ec000 {
>> +        compatible = "microchip,pic32-sdhci";
>> +        reg = <0x1f8ec000 0x100>;
>> +        interrupts = <SDHC_EVENT DEFAULT_INT_PRI IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&REFCLKO4>, <&PBCLK5>;
>> +        clock-names = "base_clk", "sys_clk";
> 
>    The "clocks" and "clock-names" props are not documented.
> 
> [...]
> 
> MBR, Sergei
> 

Ack.

Thanks for the feedback,
Josh
