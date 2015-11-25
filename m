Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 19:22:25 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:35932 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012318AbbKYSWXJY6CC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 19:22:23 +0100
Received: from [127.0.0.1] (10.10.76.4) by chn-sv-exch03.mchp-main.com
 (10.10.76.49) with Microsoft SMTP Server id 14.3.181.6; Wed, 25 Nov 2015
 11:22:14 -0700
Subject: Re: [PATCH 01/14] DEVICETREE: Add bindings for PIC32 interrupt
 controller
To:     Arnd Bergmann <arnd@arndb.de>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-2-git-send-email-joshua.henderson@microchip.com>
 <7036408.cJ9oZKCcQe@wuerfel>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, <devicetree@vger.kernel.org>
From:   Joshua Henderson <joshua.henderson@microchip.com>
Message-ID: <5655FC54.8080906@microchip.com>
Date:   Wed, 25 Nov 2015 11:22:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <7036408.cJ9oZKCcQe@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Joshua.Henderson@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50111
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

On 11/21/2015 1:47 PM, Arnd Bergmann wrote:
> On Friday 20 November 2015 17:17:13 Joshua Henderson wrote:
> 
>> +Example
>> +-------
>> +
>> +evic: interrupt-controller@1f810000 {
>> +        compatible = "microchip,evic-v2";
>> +        interrupt-controller;
>> +        #interrupt-cells = <3>;
>> +        reg = <0x1f810000 0x1000>;
>> +        device_type="evic-v2";
>> +};
> 
> This is not a correct use of device_type. Just drop that property.

Ack.

> 
>> diff --git a/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h b/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
>> new file mode 100644
>> index 0000000..2c466b8
>> --- /dev/null
>> +++ b/include/dt-bindings/interrupt-controller/microchip,pic32mz-evic.h
>> @@ -0,0 +1,238 @@
>> +/*
>> + * This header provides constants for the MICROCHIP PIC32 EVIC.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H
>> +#define _DT_BINDINGS_INTERRUPT_CONTROLLER_MICROCHIP_EVIC_H
>> +
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/* Hardware interrupt number */
>> +#define CORE_TIMER_INTERRUPT 0
>> +#define CORE_SOFTWARE_INTERRUPT_0 1
>> +#define CORE_SOFTWARE_INTERRUPT_1 2
>> +#define EXTERNAL_INTERRUPT_0 3
>> +#define TIMER1 4
> 
> A header file like this is just going to make everyone's life
> miserable. Try to remove as much as possible here: normally
> you can just use the numbers from the data sheet that match
> the actual hardware registers, and put them into the dts file.
> 

Agreed.  Removing these defines along with removing the priorities from the bindings as suggested makes sense.  With doing that, this header file becomes pointless and it will be dropped.

>> +/* Interrupt priority bits */
>> +#define PRI_0	0	/* Note:This priority disables the interrupt! */
>> +#define PRI_1	1
>> +#define PRI_2	2
>> +#define PRI_3	3
>> +#define PRI_4	4
>> +#define PRI_5	5
>> +#define PRI_6	6
>> +#define PRI_7	7
> 
>> +/* Interrupt subpriority bits */
>> +#define SUB_PRI_0	0
>> +#define SUB_PRI_1	1
>> +#define SUB_PRI_2	2
>> +#define SUB_PRI_3	3
> 
> These are obviously silly and should be removed/
> 

Ack.

>> +#define PRI_MASK	0x7	/* 3 bit priority mask */
>> +#define SUBPRI_MASK	0x3	/* 2 bit subpriority mask */
>> +#define INT_MASK	0x1F	/* 5 bit pri and subpri mask */
>> +#define NR_EXT_IRQS	5	/* 5 external interrupts sources */
>> +
>> +#define MICROCHIP_EVIC_MIN_PRIORITY 0
>> +#define MICROCHIP_EVIC_MAX_PRIORITY INT_MASK
>> +
>> +#define INT_PRI(pri, subpri)	\
>> +	(((pri & PRI_MASK) << 2) | (subpri & SUBPRI_MASK))
>> +
>> +#define DEFINE_INT(irq, pri) { irq, pri }
>> +
>> +#define DEFAULT_INT_PRI INT_PRI(2, 0)
> 
> Is it required to have a specific priority configured for each line?
> If these are software selectable, it's probably better to not put
> them into DT in the first place.
> 
> If you absolutely need them, I would suggest using two separate cells
> for pri and subpri so you can avoid the macro.
> 

These priorities are hardware priorities that arbitrate pending interrupts to the CPU.  These are indeed software configurable and we can agree that DT is probably not the best place to put this configuration in light of this.  We'll default to something sane instead.  They will be removed from the binding.

Josh
