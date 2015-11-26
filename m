Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 06:37:08 +0100 (CET)
Received: from exsmtp01.microchip.com ([198.175.253.37]:37690 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006153AbbKZFhFqld6w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2015 06:37:05 +0100
Received: from [127.0.0.1] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Wed, 25 Nov 2015
 22:36:57 -0700
Subject: Re: [PATCH 03/14] DEVICETREE: Add PIC32 clock binding documentation
To:     Rob Herring <robh@kernel.org>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
 <20151122213110.GA16187@rob-hp-laptop>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <56569A77.8010800@microchip.com>
Date:   Wed, 25 Nov 2015 22:36:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20151122213110.GA16187@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50129
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

On 11/22/2015 2:31 PM, Rob Herring wrote:
> On Fri, Nov 20, 2015 at 05:17:15PM -0700, Joshua Henderson wrote:
>> From: Purna Chandra Mandal <purna.mandal@microchip.com>
>>
>> Document the devicetree bindings for the clock driver found on Microchip
>> PIC32 class devices.
>>
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> ---
>>  .../devicetree/bindings/clock/microchip,pic32.txt  |  263 ++++++++++++++++++++
>>  1 file changed, 263 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
>> new file mode 100644
>> index 0000000..4cef72d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
>> @@ -0,0 +1,263 @@
>> +Binding for a Clock hardware block found on
>> +certain Microchip PIC32 MCU devices.
>> +
>> +Microchip SoC clocks-node consists of few oscillators, PLL, multiplexer
>> +and few divider nodes.
> 
> [...]
> 
>> +Required properties:
>> +- compatible : should have "microchip,pic32-clk".
>> +- reg : A Base address and length of the register set.
>> +- interrupts : source of interrupt.
>> +
>> +Optional properties (for subnodes):
>> +- #clock-cells: From common clock binding, should be 0.
>> +
>> +- microchip,clock-indices: in multiplexer node clock sources always aren't linear
>> +    and contiguous. This property helps define clock-sources with respect to
>> +    the mux clock node.
>> +
>> +- microchip,ignore-unused : ignore gate request even if the gated clock is unused.
> 
> There is some discussion about this upstream with "critical-clocks" 
> binding. Can you use and wait for that?
> 

The way this is going, we might not have to wait. :)  Is there a patch available yet to try it out?  

>> +- microchip,status-bit-mask: bitmask for status check. This will be used to confirm
>> +    particular operation by clock sub-node is completed. It is dependent sub-node.
>> +- microchip,bit-mask: enable mask, similar to microchip,status-bit-mask.
> 
> We've generally decided not to describe clocks at this level of detail 
> in DT. It's fine though for simple clock trees. This one seems to be 
> borderline IMO.
> 

The binding example is the entire clock tree.  These masks are right from the datasheet.  For reference, do you have an example of a better alternative?

>> +- microchip,slew-step: enable frequency slewing(stepping) during rate change;
>> +    applicable only to sys-clock subnode.
> 

Thanks,
Josh
