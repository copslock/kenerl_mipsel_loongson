Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 18:05:24 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47969 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012115AbaJ2RFVkp1LD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 18:05:21 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CD3AF9F5D2596;
        Wed, 29 Oct 2014 17:05:11 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 29 Oct 2014 17:05:14 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 29 Oct
 2014 17:05:13 +0000
Message-ID: <54511E49.6090907@imgtec.com>
Date:   Wed, 29 Oct 2014 17:05:13 +0000
From:   Qais Yousef <qais.yousef@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 2/4] of: Add binding document for MIPS GIC
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>   <1414541562-10076-3-git-send-email-abrestic@chromium.org>       <5450C915.9030600@imgtec.com> <CAL1qeaGm1Ma=B-gJV2ovnLNYFooq6bv12rODq4d8cGtKLeNy-g@mail.gmail.com>
In-Reply-To: <CAL1qeaGm1Ma=B-gJV2ovnLNYFooq6bv12rODq4d8cGtKLeNy-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

On 10/29/2014 04:56 PM, Andrew Bresticker wrote:
> On Wed, Oct 29, 2014 at 4:01 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
>> On 10/29/2014 12:12 AM, Andrew Bresticker wrote:
>>> +- mti,available-cpu-vectors : Specifies the list of CPU interrupt vectors
>>> +  to which the GIC may route interrupts.  May contain up to 6 entries,
>>> one
>>> +  for each of the CPU's hardware interrupt vectors.  Valid values are 2 -
>>> 7.
>>> +  This property is ignored if the CPU is started in EIC mode.
>>> +
>>
>> Wouldn't it be better to have this in the reversed sense ie:
>> mti,nonavailable-cpu-vectors? I think the assumption that by default they're
>> all available unless something else is connected to them which is unlikely
>> in most cases. It can be made optional property then.
>>
>> I don't have a strong opinion about it though.
> Actually, I think I like the reversed sense as well.  Perhaps
> "mti,reserved-cpu-vectors"?

Yep that's a better wording for sure :)
