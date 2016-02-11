Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 09:24:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46409 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012402AbcBKIYawCPPS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 09:24:30 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 77F1F70ABBD07;
        Thu, 11 Feb 2016 08:24:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 11 Feb 2016 08:24:24 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 11 Feb
 2016 08:24:24 +0000
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
To:     David Daney <ddaney@caviumnetworks.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <CAPDyKFrMgt9snP2NLbQ6EQ5X7gjQLA+e+TEfqgjzLYTuH+G1OA@mail.gmail.com>
 <56BB9877.9000305@caviumnetworks.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        <Zubair.Kakakhel@imgtec.com>,
        Aleksey Makarov <aleksey.makarov@caviumnetworks.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Aaron Williams <aaron.williams@cavium.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56BC4538.20207@imgtec.com>
Date:   Thu, 11 Feb 2016 08:24:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <56BB9877.9000305@caviumnetworks.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi,
I will split the DT binding document into a separate patch, and move the 
legacy FDT patch-up code to
arch/mips/cavium-octeon/octeon-platform.c as suggested by Florian.

Ulf, your objections to the structure of the DT and driver were the only 
driver for the changes v4->v5.
I changed the DT binding and the structure of the driver to more closely 
resemble the atmel-mci driver, which has the same concept of one 
controller, multiple slots.

Thanks,
Matt

On 10/02/16 20:07, David Daney wrote:
> On 02/10/2016 11:01 AM, Ulf Hansson wrote:
>> On 10 February 2016 at 18:36, Matt Redfearn 
>> <matt.redfearn@imgtec.com> wrote:
>>> From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>
>>>
>>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>>> devices.  Device parameters are configured from device tree data.
>>>
>>> eMMC, MMC and SD devices are supported.
>>>
>>> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
>>> Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
>>> Signed-off-by: Peter Swain <pswain@cavium.com>
>>> Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> ---
>>> v5:
>>> Incoroprate comments from review
>>> http://patchwork.linux-mips.org/patch/9558/
>>> - Use standard <bus-width> property instead of <cavium,bus-max-width>.
>>> - Use standard <max-frequency> property instead of <spi-max-frequency>.
>>> - Add octeon_mmc_of_parse_legacy function to deal with the above
>>>    properties, since many devices have shipped with those properties
>>>    embedded in firmware.
>>> - Allow the <vmmc-supply> binding in addition to the legacy
>>>    <gpios-power>.
>>> - Remove the secondary driver for each slot.
>>> - Use core gpio cd/wp handling
>>
>> Seems like you decided to ignore most comments realted to the DT
>> bindings from the earlier version.
>> Although, let's discuss this one more time.
>
> I think you may have misread the patch.  The DT bindings have been
> changed based on the feedback we received on v4.
>
>>
>> Therefore I recomend you to split this patch. DT documentation should
>> be a separate patch preceeding the actual mmc driver patch.
>
> You may have missed it the first time it was posted, but the legacy DT
> bindings have been around for a while.
>
> See:
>
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-May/015482.html 
>
>
>
>> The DT patch needs to be acked by the DT maintainers.
>
> The legacy DT has been deployed in firmware for several years now.  We
> are adding more "modern" bindings, and the DT maintainers are
> encouraged to review that portion, but the legacy is what it is and it
> isn't changing.
>
>>
>> Until we somewhat agreed on the DT parts, I am going to defer the
>> in-depth review of the driver code as I have limited bandwidth.
>>
>
> As I stated above, the legacy DT bindings are not changing and must be
> supported.  Waiting for legacy DT bindings to change is equivalent to
> infinite deferral.
>
>> Does that make sense to you?
>>
>
> I understand why you would say this.  However, I think it doesn't
> fully take into account the need to support devices that have already
> been deployed.
>
> That said, Matt really needs to get the DT maintainers reviewing the 
> new DT bindings.
>
>
> David Daney
