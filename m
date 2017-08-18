Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 15:22:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56166 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994912AbdHRNWIGg509 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 15:22:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E04A3529F1A77;
        Fri, 18 Aug 2017 14:21:56 +0100 (IST)
Received: from [192.168.154.107] (192.168.154.107) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 14:21:59 +0100
Subject: Re: [PATCH 2/3] MIPS: dts: Add VoCore2 board
To:     Rob Herring <robh@kernel.org>
CC:     <mark.rutland@arm.com>, <ralf@linux-mips.org>, <john@phrozen.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
References: <1502814773-40842-1-git-send-email-harvey.hunt@imgtec.com>
 <1502814773-40842-2-git-send-email-harvey.hunt@imgtec.com>
 <20170817213628.nrkeuek7vu6oebfx@rob-hp-laptop>
From:   Harvey Hunt <Harvey.Hunt@imgtec.com>
Message-ID: <5b00f77c-12be-76d2-e9eb-03f8a4b6375e@imgtec.com>
Date:   Fri, 18 Aug 2017 14:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170817213628.nrkeuek7vu6oebfx@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Harvey.Hunt@imgtec.com
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

Thanks for the review.

On 17/08/17 22:36, Rob Herring wrote:
> On Tue, Aug 15, 2017 at 05:32:52PM +0100, Harvey Hunt wrote:
>> The VoCore2 board is a low cost MT7628A based board with 128MB RAM, 16MB
>> flash and multiple external peripherals.
>>
>> This initial DTS provides enough support to get to userland and use the USB
>> port.
>>
>> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-mips@linux-mips.org
>> ---
>>   MAINTAINERS                           |  6 ++++++
>>   arch/mips/boot/dts/ralink/Makefile    |  1 +
>>   arch/mips/boot/dts/ralink/vocore2.dts | 18 ++++++++++++++++++
>>   arch/mips/ralink/Kconfig              |  5 +++++
>>   4 files changed, 30 insertions(+)
>>   create mode 100644 arch/mips/boot/dts/ralink/vocore2.dts
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6f7721d..82dcc6f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14127,6 +14127,12 @@ L:	netdev@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/net/vmxnet3/
>>   
>> +VOCORE VOCORE2 BOARD
>> +M:	Harvey Hunt <harveyhuntnexus@gmail.com>
>> +L:	linux-mips@linux-mips.org
>> +S:	Maintained
>> +F:	arch/mips/boot/dts/ralink/vocore2.dts
>> +
>>   VOLTAGE AND CURRENT REGULATOR FRAMEWORK
>>   M:	Liam Girdwood <lgirdwood@gmail.com>
>>   M:	Mark Brown <broonie@kernel.org>
>> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
>> index 2a72259..a191788 100644
>> --- a/arch/mips/boot/dts/ralink/Makefile
>> +++ b/arch/mips/boot/dts/ralink/Makefile
>> @@ -2,6 +2,7 @@ dtb-$(CONFIG_DTB_RT2880_EVAL)	+= rt2880_eval.dtb
>>   dtb-$(CONFIG_DTB_RT305X_EVAL)	+= rt3052_eval.dtb
>>   dtb-$(CONFIG_DTB_RT3883_EVAL)	+= rt3883_eval.dtb
>>   dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= mt7620a_eval.dtb
>> +dtb-$(CONFIG_DTB_VOCORE2)		+= vocore2.dtb
>>   
>>   obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
>>   
>> diff --git a/arch/mips/boot/dts/ralink/vocore2.dts b/arch/mips/boot/dts/ralink/vocore2.dts
>> new file mode 100644
>> index 0000000..7591340
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/ralink/vocore2.dts
>> @@ -0,0 +1,18 @@
>> +/dts-v1/;
>> +
>> +#include "mt7628a.dtsi"
>> +
>> +/ {
>> +	compatible = "vocore,vocore2", "ralink,mt7628a-soc";
> 
> Is vocore,vocore2 documented?

It's not, do you want me to add a file in 
Documentation/devicetree/bindings/mips?

If so, shall I just create a vocore.txt file or create a "vocore" 
directory with vocore2.txt in it?

Thanks,

Harvey

> 
>> +	model = "VoCore2";
>> +
>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x8000000>;
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "console=ttyS2,115200";
>> +		stdout-path = "serial2:115200";
>> +	};
>> +};
>> diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
>> index 710b04c..c2b2c2d 100644
>> --- a/arch/mips/ralink/Kconfig
>> +++ b/arch/mips/ralink/Kconfig
>> @@ -82,6 +82,11 @@ choice
>>   		depends on SOC_MT7620
>>   		select BUILTIN_DTB
>>   
>> +	config DTB_VOCORE2
>> +		bool "VoCore2"
>> +		depends on SOC_MT7620
>> +		select BUILTIN_DTB
>> +
>>   endchoice
>>   
>>   endif
>> -- 
>> 2.7.4
>>
