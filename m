Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 06:01:26 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:58589 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006153AbbKZFBXiiHCc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 06:01:23 +0100
Received: from [127.0.0.1] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 25 Nov 2015
 22:01:16 -0700
Subject: Re: [PATCH 01/14] DEVICETREE: Add bindings for PIC32 interrupt
 controller
To:     Rob Herring <robh@kernel.org>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
 <20151122211453.GA13180@rob-hp-laptop>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <5656921A.7000109@microchip.com>
Date:   Wed, 25 Nov 2015 22:01:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151122211453.GA13180@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50127
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

Hi Rob,

On 11/22/2015 2:14 PM, Rob Herring wrote:
> On Fri, Nov 20, 2015 at 05:17:13PM -0700, Joshua Henderson wrote:
>> From: Cristian Birsan <cristian.birsan@microchip.com>
>>
>> Document the devicetree bindings for the interrupt controller on Microchip
>> PIC32 class devices. This also adds a header defining associated interrupts
>> and related settings.
>>
>> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> ---
>>  .../microchip,pic32mz-evic.txt                     |   65 ++++++
>>  .../interrupt-controller/microchip,pic32mz-evic.h  |  238 ++++++++++++++++++++
>>  2 files changed, 303 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
>>  create mode 100644 include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt b/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
>> new file mode 100644
>> index 0000000..12fb91f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,pic32mz-evic.txt
>> @@ -0,0 +1,65 @@
>> +Microchip PIC32MZ Interrupt Controller
>> +======================================
>> +
>> +The Microchip PIC32MZ SOC contains an Enhanced Vectored Interrupt Controller
>> +(EVIC) version 2. It handles internal and external interrupts and provides
>> +support for priority, sub-priority, irq type and polarity.
>> +
>> +Required properties
>> +-------------------
>> +
>> +- compatible: Should be "microchip,evic-v2"
> 
> This should be more specific like "microchip,pic32mz-evic". You can keep 
> this one in addition if you like for matching.
> 
> Rob
> 

Agreed.  Due to feedback, we are settling on microchip,pic32mzda-evic and similar for all compatible properties in this patch series.  I don't see a need to keep a more abstract name around here if you don't.

Josh
