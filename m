Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 08:21:15 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57053 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006508AbbKZHVMqEJyG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2015 08:21:12 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0F1C928BF12;
        Thu, 26 Nov 2015 08:20:33 +0100 (CET)
Received: from Dicker-Alter.lan (p548C9109.dip0.t-ipconnect.de [84.140.145.9])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 26 Nov 2015 08:20:32 +0100 (CET)
Subject: Re: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
To:     Martin Schiller <mschiller@tdt.de>, Jonas Gorski <jogo@openwrt.org>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
 <1448446739-5541-4-git-send-email-mschiller@tdt.de>
 <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
 <c9edbc5eafed4639983f8bcefe8e872e@TDT-MS.TDTNET.local>
 <5656AF01.3050700@openwrt.org>
 <39cc8cd2e53f492f88c45dd256a46b22@TDT-MS.TDTNET.local>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "daniel.schwierzeck@gmail.com" <daniel.schwierzeck@gmail.com>
From:   John Crispin <blogic@openwrt.org>
Message-ID: <5656B2C0.6010701@openwrt.org>
Date:   Thu, 26 Nov 2015 08:20:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <39cc8cd2e53f492f88c45dd256a46b22@TDT-MS.TDTNET.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50133
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



On 26/11/2015 08:15, Martin Schiller wrote:
> On 11/26/2015 at 8:04 AM, John Crispin wrote:
>>
>>
>> On 26/11/2015 07:40, Martin Schiller wrote:
>>> On 11/25/2015 at 11:40 AM, Jonas Gorski wrote:
>>>> Hi
>>>>
>>>> On Wed, Nov 25, 2015 at 11:18 AM, Martin Schiller <mschiller@tdt.de>
>>>> wrote:
>>>>> From: John Crispin <blogic@openwrt.org>
>>>>>
>>>>> This patch is included in the openwrt patchset for several years
>> now
>>>> and needs
>>>>> to go upstream as well. It includes the following changes:
>>>>> 1. Fix up inline function call to xway_mux_apply
>>>>
>>>> This really needs an explanation what is being fixed here.
>>>
>>> I hope John - as the original author of this patch - can explain
>>> why this change is necessary.
>>
>> what change? why am I in Cc: and not To: if an action is required ?
>>
>> John
> 
> That change is meant:
> ########################################################################
>> diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-
>> xway.c
>> index a064962..f0b1b48 100644
>> --- a/drivers/pinctrl/pinctrl-xway.c
>> +++ b/drivers/pinctrl/pinctrl-xway.c
>> @@ -1496,10 +1496,9 @@ static struct pinctrl_desc xway_pctrl_desc = {
>>  .confops= &xway_pinconf_ops,
>>  };
>>
>> -static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
>> +static int mux_apply(struct ltq_pinmux_info *info,
>>  int pin, int mux)
>>  {
>> -struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
>>  int port = PORT(pin);
>>  u32 alt1_reg = GPIO_ALT1(pin);
>>
>> @@ -1519,6 +1518,14 @@ static inline int xway_mux_apply(struct
>> pinctrl_dev *pctrldev,
>>  return 0;
>>  }
>>
>> +static inline int xway_mux_apply(struct pinctrl_dev *pctrldev,
>> +int pin, int mux)
>> +{
>> +struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
>> +
>> +return mux_apply(info, pin, mux);
>> +}
>> +
>>  static const struct ltq_cfg_param xway_cfg_params[] = {
>>  {"lantiq,pull",LTQ_PINCONF_PARAM_PULL},
>>  {"lantiq,open-drain",LTQ_PINCONF_PARAM_OPEN_DRAIN},
> #######################################################################
> 

ok so you picked up a patch and sent it upstream without looking at what
it really does. the patch is simply not ready for upstream. the problem
here is copy & paste inconsistency.

however if we want to resolve this we should either keep the inlines and
just stick to the current code pattern used or we could just assume that
the compiler will be smart enough to to know when to inline and remove
all of them.

i'll leave it up to you to decide and propose your solution as a patch
with an explanation.

	John


>>
>>>
>>>>
>>>>> 2. Fix GPIO Setup of GPIO Port3
>>>>
>>>> This change looks fine.
>>>>
>>>>> 3. Implement gpio_chip.to_irq
>>>>
>>>> These are three different changes (two fixes, one new feature) and
>>>> therefore should be split up into three patches.
>>>
>>> As I'm not the author of this patch, I decided to leave it as it is.
>>> But per se you are right, it would be better to split it up.
>>>
>>>>
>>>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>>>> Signed-off-by: Martin Schiller <mschiller@tdt.de>
>>>>> ---
>>>>
>>>> Also please provide a changelog for your patches here.
>>>
>>> OK.
>>>
>>>>
>>>>>  drivers/pinctrl/pinctrl-xway.c | 28 ++++++++++++++++++++++++++--
>>>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>>
>>>> Jonas
>>>
>>> Martin
>>>
>>>
> 
> 
