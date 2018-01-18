Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 18:15:00 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:45446 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990425AbeARROsYukOy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 18:14:48 +0100
Date:   Thu, 18 Jan 2018 18:14:30 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v7 11/14] MIPS: ingenic: Initial JZ4770 support
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Message-Id: <1516295670.1423.0@smtp.crapouillou.net>
In-Reply-To: <20180117212853.GC27409@jhogan-linux.mipstec.com>
References: <20180105182513.16248-2-paul@crapouillou.net>
        <20180116154804.21150-1-paul@crapouillou.net>
        <20180116154804.21150-12-paul@crapouillou.net>
        <20180117212853.GC27409@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1516295683; bh=CHKX9tM6Q5uiVsvfE4XvKxlKuM63tE/8RB19Vn6qhbs=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding; b=szTZbmvuH/+i2pqoZ6LSk8ZcB1FoWYuy+Updi2lsXUFbLSQdPjL8kbfsMPwSkh7A/oyI70426YshqnFvC8jAGPuGdgfLh+znQjvKylrR+OF1DFqgM16BH/9kl3chmVFB3I9O2ncgwjhiqbEZ4C2/il/4fi95epWTZ2qHuVmTO+g=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Hi James,

Le mer. 17 janv. 2018 à 22:28, James Hogan <james.hogan@mips.com> a 
écrit :
> On Tue, Jan 16, 2018 at 04:48:01PM +0100, Paul Cercueil wrote:
>>  Provide just enough bits (clocks, clocksource, uart) to allow a 
>> kernel
>>  to boot on the JZ4770 SoC to a initramfs userspace.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> 
>>  diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
>>  index bb1ad5119da4..2ca9160f642a 100644
>>  --- a/arch/mips/jz4740/time.c
>>  +++ b/arch/mips/jz4740/time.c
>>  @@ -113,7 +113,7 @@ static struct clock_event_device 
>> jz4740_clockevent = {
>>   #ifdef CONFIG_MACH_JZ4740
>>   	.irq = JZ4740_IRQ_TCU0,
>>   #endif
>>  -#ifdef CONFIG_MACH_JZ4780
>>  +#if defined(CONFIG_MACH_JZ4770) || defined(CONFIG_MACH_JZ4780)
>>   	.irq = JZ4780_IRQ_TCU2,
>>   #endif
>>   };
>>  --
>>  2.11.0
>> 
> 
> MACH_INGENIC selects SYS_SUPPORTS_ZBOOT_UART16550, so I wonder whether
> arch/mips/boot/compressed/uart-16550.c needs updating for JZ4770 like
> commit ba9e72c2290f ("MIPS: Fix build with DEBUG_ZBOOT and 
> MACH_JZ4780")
> does for JZ4780.
> 
> Otherwise the non-DT bits look reasonable (I've not really looked
> properly at the DT):
> Reviewed-by: James Hogan <jhogan@kernel.org>
> 
> Cheers
> James

I will fix it in a separate patch, if you don't mind.

-Paul
