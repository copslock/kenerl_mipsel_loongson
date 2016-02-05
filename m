Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 06:10:07 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:45085 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007196AbcBEFKBfy4Zv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 06:10:01 +0100
Received: from [10.41.20.11] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Thu, 4 Feb 2016
 22:09:53 -0700
Subject: Re: [PATCH 1/2] dt/bindings: Add bindings for the PIC32 SPI
 peripheral
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        <linux-kernel@vger.kernel.org>
References: <1454366701-10847-1-git-send-email-joshua.henderson@microchip.com>
 <56B08EEB.3050808@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
Message-ID: <56B42E4C.8040201@microchip.com>
Date:   Fri, 5 Feb 2016 10:38:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <56B08EEB.3050808@cogentembedded.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

On 02/02/2016 04:41 PM, Sergei Shtylyov wrote:

> Hello.
> On 2/2/2016 1:44 AM, Joshua Henderson wrote:
>> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Document the devicetree bindings for the SPI peripheral found
>> on Microchip PIC32 class devices.
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> ---
>>   .../bindings/spi/microchip,spi-pic32.txt           |   44 ++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>> diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>> new file mode 100644
>> index 0000000..a555618
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
>> @@ -0,0 +1,44 @@
>> +* Microchip PIC32 SPI device
>> +
>> +Required properties:
>> +- compatible: Should be "microchip,pic32mzda-spi".
>> +- reg: Address and length of the register set for the device
>> +- interrupts: Should contain all three spi interrupts in sequence
>> +              of <fault-irq>, <receive-irq>, <transmit-irq>.
>> +- interrupt-names: Should be "fault","rx","tx" in order.
>>
> Please insert spaces after commas.

ack.

>> +- clocks: phandles of baud generation clocks. Maximum two possible clocks
>>
> Baud in the SPI context?

Yes, clock for generating spi clock (SCK). Will update the comment.

>> +      can be provided (&PBCLK2, &REFCLKO1).
>>
> Please align.

ack.

>> +          See: Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +- clock-names: Should be "mck0","mck1".
>>
> Please insert space after comma.

ack.

> [...]
>> +Example:
>> +
>> +    spi1:spi@0x1f821000 {
> Please insert spaces after colon.

ack

> [...]
> MBR, Sergei
>
