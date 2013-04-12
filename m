Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 10:44:10 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:57642 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835051Ab3DLI1EpcNl0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 10:27:04 +0200
Message-ID: <5167C40D.2040908@openwrt.org>
Date:   Fri, 12 Apr 2013 10:21:33 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 02/16] MIPS: ralink: fix RT305x clock setup
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-2-git-send-email-blogic@openwrt.org> <5167C439.4090300@openwrt.org>
In-Reply-To: <5167C439.4090300@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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


>>   	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
>>
>>   	if (soc_is_rt305x() || soc_is_rt3350()) {
>> @@ -176,11 +177,21 @@ void __init ralink_clk_init(void)
>>   		BUG();
>>   	}
>>
>> +	if (soc_is_rt3352() || soc_is_rt5350()) {
>> +		u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);
>> +
>> +		if (!(val&  RT3352_CLKCFG0_XTAL_SEL))
> Given the fact that the definition of RT3352_SYSC_REG_SYSCFG0 and
> RT3352_CLKCFG0_XTAL_SEL is added in a later patch, this code causes a build error?


i'll reoder the patches to fix this


>> +			wmac_rate = 20000000;
>> +	}
>> +
>>   	ralink_clk_add("cpu", cpu_rate);
>>   	ralink_clk_add("10000b00.spi", sys_rate);
>>   	ralink_clk_add("10000100.timer", wdt_rate);
>> +	ralink_clk_add("10000120.watchdog", wdt_rate);
>>   	ralink_clk_add("10000500.uart", uart_rate);
>>   	ralink_clk_add("10000c00.uartlite", uart_rate);
>> +	ralink_clk_add("10100000.ethernet", sys_rate);
>> +	ralink_clk_add("wmac@10180000", wmac_rate);
> Should not this be "10180000.wmac"?
>
>
yes, correct
