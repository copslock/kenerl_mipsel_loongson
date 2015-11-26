Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2015 08:04:39 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:54786 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006508AbbKZHEhZjpjG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Nov 2015 08:04:37 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id A377228BC6F;
        Thu, 26 Nov 2015 08:04:33 +0100 (CET)
Received: from Dicker-Alter.lan (p548C9109.dip0.t-ipconnect.de [84.140.145.9])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 26 Nov 2015 08:04:33 +0100 (CET)
Subject: Re: [PATCH v2 4/4] pinctrl/lantiq: fix up pinmux
To:     Martin Schiller <mschiller@tdt.de>, Jonas Gorski <jogo@openwrt.org>
References: <1448446739-5541-1-git-send-email-mschiller@tdt.de>
 <1448446739-5541-4-git-send-email-mschiller@tdt.de>
 <CAOiHx=moeuw-qWdq0YVzVD3dv0Zq+3rxb2tAKV1Hiz35y4+7DQ@mail.gmail.com>
 <c9edbc5eafed4639983f8bcefe8e872e@TDT-MS.TDTNET.local>
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
Message-ID: <5656AF01.3050700@openwrt.org>
Date:   Thu, 26 Nov 2015 08:04:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <c9edbc5eafed4639983f8bcefe8e872e@TDT-MS.TDTNET.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50131
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



On 26/11/2015 07:40, Martin Schiller wrote:
> On 11/25/2015 at 11:40 AM, Jonas Gorski wrote:
>> Hi
>>
>> On Wed, Nov 25, 2015 at 11:18 AM, Martin Schiller <mschiller@tdt.de>
>> wrote:
>>> From: John Crispin <blogic@openwrt.org>
>>>
>>> This patch is included in the openwrt patchset for several years now
>> and needs
>>> to go upstream as well. It includes the following changes:
>>> 1. Fix up inline function call to xway_mux_apply
>>
>> This really needs an explanation what is being fixed here.
> 
> I hope John - as the original author of this patch - can explain
> why this change is necessary.

what change? why am I in Cc: and not To: if an action is required ?

	John

> 
>>
>>> 2. Fix GPIO Setup of GPIO Port3
>>
>> This change looks fine.
>>
>>> 3. Implement gpio_chip.to_irq
>>
>> These are three different changes (two fixes, one new feature) and
>> therefore should be split up into three patches.
> 
> As I'm not the author of this patch, I decided to leave it as it is.
> But per se you are right, it would be better to split it up.
> 
>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>> Signed-off-by: Martin Schiller <mschiller@tdt.de>
>>> ---
>>
>> Also please provide a changelog for your patches here.
> 
> OK.
> 
>>
>>>  drivers/pinctrl/pinctrl-xway.c | 28 ++++++++++++++++++++++++++--
>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>
>>
>>
>> Jonas
> 
> Martin
> 
> 
