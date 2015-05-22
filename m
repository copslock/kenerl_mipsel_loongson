Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 20:12:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58802 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006684AbbEVSMGKm92D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 20:12:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 97C9E93833A08;
        Fri, 22 May 2015 19:11:59 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 19:12:02 +0100
Received: from [10.100.200.196] (10.100.200.196) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 19:12:01 +0100
Message-ID: <555F70AD.7060307@imgtec.com>
Date:   Fri, 22 May 2015 15:08:45 -0300
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     James Hartley <James.Hartley@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Damien Horsley" <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Subject: Re: [PATCH 7/7] mips: pistachio: Allow to enable the external timer
 based clocksource
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>      <1432244618-15548-1-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaG=LeQtSS_0w_=hXMNfG2dqTomL5hgifFXV-x1Jy9P1rw@mail.gmail.com> <72BC0C8BD7BB6F45988A99382E5FBAE5445286D0@hhmail02.hh.imgtec.org>
In-Reply-To: <72BC0C8BD7BB6F45988A99382E5FBAE5445286D0@hhmail02.hh.imgtec.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.196]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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



On 05/22/2015 01:58 PM, James Hartley wrote:
> 
> 
>> -----Original Message-----
>> From: abrestic@google.com [mailto:abrestic@google.com] On Behalf Of
>> Andrew Bresticker
>> Sent: 22 May 2015 17:50
>> To: Ezequiel Garcia
>> Cc: linux-kernel@vger.kernel.org; Linux-MIPS; Daniel Lezcano;
>> devicetree@vger.kernel.org; James Hartley; James Hogan; Thomas Gleixner;
>> Damien Horsley; Govindraj Raja
>> Subject: Re: [PATCH 7/7] mips: pistachio: Allow to enable the external timer
>> based clocksource
>>
>> On Thu, May 21, 2015 at 2:43 PM, Ezequiel Garcia
>> <ezequiel.garcia@imgtec.com> wrote:
>>> This commit introduces a new config, so the user can choose to enable
>>> the General Purpose Timer based clocksource. This option is required
>>> to have CPUFreq support.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>> ---
>>>  arch/mips/Kconfig           |  1 +
>>>  arch/mips/pistachio/Kconfig | 13 +++++++++++++
>>>  2 files changed, 14 insertions(+)
>>>  create mode 100644 arch/mips/pistachio/Kconfig
>>>
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig index
>>> f501665..91f6ca0 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -934,6 +934,7 @@ source "arch/mips/jazz/Kconfig"
>>>  source "arch/mips/jz4740/Kconfig"
>>>  source "arch/mips/lantiq/Kconfig"
>>>  source "arch/mips/lasat/Kconfig"
>>> +source "arch/mips/pistachio/Kconfig"
>>>  source "arch/mips/pmcs-msp71xx/Kconfig"
>>>  source "arch/mips/ralink/Kconfig"
>>>  source "arch/mips/sgi-ip27/Kconfig"
>>> diff --git a/arch/mips/pistachio/Kconfig b/arch/mips/pistachio/Kconfig
>>> new file mode 100644 index 0000000..97731ea
>>> --- /dev/null
>>> +++ b/arch/mips/pistachio/Kconfig
>>> @@ -0,0 +1,13 @@
>>> +config PISTACHIO_GPTIMER_CLKSRC
>>> +       bool "Enable General Purpose Timer based clocksource"
>>> +       depends on MACH_PISTACHIO
>>> +       select CLKSRC_PISTACHIO
>>> +       select MIPS_EXTERNAL_TIMER
>>
>> Why not just select these in the MACH_PISTACHIO Kconfig entry?  Is there any
>> harm in always having the Pistachio GPT enabled?
> 
> It does mean that there are less GPT's available for other users, and whilst I'm not aware of any use cases that currently require all 4, perhaps having the flexibility is worth it.
> 

And also, this is only useful if the user wants CPUFreq. Otherwise we
have MIPS GIC and R4K for clockevents and clocksource. Not sure why we'd
want another one.

-- 
Ezequiel
