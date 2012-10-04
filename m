Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 20:49:31 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57149 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817521Ab2JDStXkJcaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 20:49:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 57B4DD19;
        Thu,  4 Oct 2012 20:49:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id jOGO7jvwWUh1; Thu,  4 Oct 2012 20:49:16 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-153-53.dynamic.mnet-online.de [188.174.153.53])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 7FEC3D16;
        Thu,  4 Oct 2012 20:48:34 +0200 (CEST)
Message-ID: <506DDA16.8070604@metafoo.de>
Date:   Thu, 04 Oct 2012 20:48:54 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120724 Icedove/3.0.11
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@linaro.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <bryan.wu@canonical.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de> <506DA487.9070400@metafoo.de> <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 10/04/2012 08:29 PM, Thierry Reding wrote:
> On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
>> On 10/04/2012 08:06 AM, Thierry Reding wrote:
>>> [...]
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>> index 331d574..b38f23d 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -219,7 +219,8 @@ config MACH_JZ4740
>>>  	select GENERIC_GPIO
>>>  	select ARCH_REQUIRE_GPIOLIB
>>>  	select SYS_HAS_EARLY_PRINTK
>>> -	select HAVE_PWM
>>> +	select PWM
>>> +	select PWM_JZ4740
>>>  	select HAVE_CLK
>>>  	select GENERIC_IRQ_CHIP
>>
>> I'm not sure if this is such a good idea, not all jz4740 based board
>> necessarily require PWM.
> 
> This really only restores previous behaviour. But I agree that this is
> potentially not what we want. Maybe we should just not select this for
> any boards but rather leave it up to some default configuration. If so
> the patch can be made simpler by just removing the HAVE_PWM entries.

At least for JZ4740 I think that is the better solution.

Thanks,
- Lars
