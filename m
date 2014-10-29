Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 18:24:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38254 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012131AbaJ2RYHKbCKe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 18:24:07 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 93BBAB671CA7E;
        Wed, 29 Oct 2014 17:23:57 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 29 Oct
 2014 17:24:00 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 29 Oct 2014 17:24:00 +0000
Received: from [192.168.154.94] (192.168.154.94) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 29 Oct
 2014 17:23:59 +0000
Message-ID: <545122AF.303@imgtec.com>
Date:   Wed, 29 Oct 2014 17:23:59 +0000
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
References: <1414541562-10076-1-git-send-email-abrestic@chromium.org>   <1414541562-10076-3-git-send-email-abrestic@chromium.org>       <5450CAF9.3040902@imgtec.com> <CAL1qeaHEE43n6V-y6XECicPaoEAfTBpyfg8bYJZK0e-pSMAJjw@mail.gmail.com>
In-Reply-To: <CAL1qeaHEE43n6V-y6XECicPaoEAfTBpyfg8bYJZK0e-pSMAJjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43713
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

On 10/29/2014 05:08 PM, Andrew Bresticker wrote:
> On Wed, Oct 29, 2014 at 4:09 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
>> On 10/29/2014 12:12 AM, Andrew Bresticker wrote:
>>> +- reg : Base address and length of the GIC registers.
>>>
>> Also except for sead3, the base address should be properly reported by the
>> hardware. The size is fixed (for a specific version of GIC at least - which
>> is also reported by the hardware). So it would be nice to make this
>> optional.
> Even though this is usually probable, I'd prefer to leave this as
> required, or at least "optional, but recommended".  I don't have a
> very strong opinion on it though, but perhaps the device-tree folks
> do?
The biggest advantage I can think of is that it can potentially make GIC 
DT definition more shareable across for instance multiple revisions of 
an SoC that might have the GIC at different base addresses.

I won't insist too much though.
