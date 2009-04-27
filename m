Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 14:17:07 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:34524 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20023160AbZD0NRB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Apr 2009 14:17:01 +0100
Received: from [192.168.11.226] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id EAF043ECA; Mon, 27 Apr 2009 06:16:56 -0700 (PDT)
Message-ID: <49F5B090.4030801@ru.mvista.com>
Date:	Mon, 27 Apr 2009 17:18:08 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
References: <E1LyQQX-00047N-6E@localhost> <20090427130952.GA30817@linux-mips.org>
In-Reply-To: <20090427130952.GA30817@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ralf Baechle wrote:

>>There have been a number of compile problems with the msp71xx
>>configuration ever since it was included in the linux-mips.org
>>repository.  This patch resolves these problems:
>> - proper files are included when using a squashfs rootfs
>> - resetting the board no longer uses non-existent GPIO routines
>> - create the required plat_timer_setup function

    get_c0_compare_int(), you mean?

>>This patch has been compile-tested against the current HEAD.

>>Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>

>>diff --git a/arch/mips/pmc-sierra/msp71xx/msp_setup.c b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>index c936756..a54e85b 100644
>>--- a/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>+++ b/arch/mips/pmc-sierra/msp71xx/msp_setup.c
>>@@ -21,7 +21,6 @@
>> 
>> #if defined(CONFIG_PMC_MSP7120_GW)
>> #include <msp_regops.h>
>>-#include <msp_gpio.h>
>> #define MSP_BOARD_RESET_GPIO	9
>> #endif
>> 
>>@@ -88,11 +87,8 @@ void msp7120_reset(void)
>> 	 * as GPIO char driver may not be enabled and it would look up
>> 	 * data inRAM!
>> 	 */
>>-	set_value_reg32(GPIO_CFG3_REG,
>>-			basic_mode_mask(MSP_BOARD_RESET_GPIO),
>>-			basic_mode(MSP_GPIO_OUTPUT, MSP_BOARD_RESET_GPIO));
>>-	set_reg32(GPIO_DATA3_REG,
>>-			basic_data_mask(MSP_BOARD_RESET_GPIO));
>>+	set_value_reg32(GPIO_CFG3_REG, 0xf000, 0x8000);
>>+	set_reg32(GPIO_DATA3_REG, 8);
>> 
>> 	/*
>> 	 * In case GPIO9 doesn't reset the board (jumper configurable!)
>>diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>index 7cfeda5..cca64e1 100644
>>--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
>>@@ -81,10 +81,7 @@ void __init plat_time_init(void)
>> 	mips_hpt_frequency = cpu_rate/2;
>> }
>> 
>>-void __init plat_timer_setup(struct irqaction *irq)
>>+unsigned int __init get_c0_compare_int(void)
>> {
>>-#ifdef CONFIG_IRQ_MSP_CIC
>>-	/* we are using the vpe0 counter for timer interrupts */
>>-	setup_irq(MSP_INT_VPE0_TIMER, irq);
>>-#endif
>>+	return MSP_INT_VPE0_TIMER;
>> }

> The rest seems ok.  Can you fix the issue above and send a new patch?

    Better yet 3 patches as the 3 issues seem totally unrelated.

> Thanks!

>   Ralf

WBR, Sergei
