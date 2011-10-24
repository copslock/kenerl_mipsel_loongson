Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2011 17:35:39 +0200 (CEST)
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:37496 "EHLO
        eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491071Ab1JXPfb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2011 17:35:31 +0200
Received: from beta.dmz-eu.st.com ([164.129.1.35]) (using TLSv1) by eu1sys200aob120.postini.com ([207.126.147.11]) with SMTP;
        Mon, 24 Oct 2011 15:35:31 UTC
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53D02129;
        Mon, 24 Oct 2011 15:35:20 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9F9D110E;
        Mon, 24 Oct 2011 15:35:19 +0000 (GMT)
Received: from [10.52.139.57] (ctn000522.ctn.st.com [10.52.139.57])
        by mail7.sgp.st.com (MOS 4.1.8-GA)
        with ESMTP id AKG07205 (AUTH cavagiu);
        Mon, 24 Oct 2011 17:35:18 +0200
Message-ID: <4EA585B5.5030405@st.com>
Date:   Mon, 24 Oct 2011 17:35:17 +0200
From:   Giuseppe CAVALLARO <peppe.cavallaro@st.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/4] MIPS: Add board support for Loongson1B
References: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com> <1319192888-21465-2-git-send-email-keguang.zhang@gmail.com> <CAD+V5YKBkW52_md9rBeVZ1RXq2FGEXt=Ergsw+z8txMreZdNsA@mail.gmail.com> <4EA5117C.3000402@st.com> <CAJhJPsVSzXXmBOwLaGNtOsxhVEyC0fAJtiBvEWzcKcSDC8NEcA@mail.gmail.com> <4EA557B2.4020504@st.com> <CAJhJPsXxUAuF9HdivLd66MQC45mz-iYAuF1SdGdU=-duxJJ5bQ@mail.gmail.com>
In-Reply-To: <CAJhJPsXxUAuF9HdivLd66MQC45mz-iYAuF1SdGdU=-duxJJ5bQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peppe.cavallaro@st.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17365

On 10/24/2011 4:05 PM, Kelvin Cheung wrote:
> 2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
>> Hello Kelvin.
>>
>> On 10/24/2011 12:36 PM, Kelvin Cheung wrote:
>>
>> [snip]
>>
>>> According to datasheet of Loongson 1B, the buffer size in RX/TX
>>> descriptor is only 2KB. So the Loongson1B's GMAC could not handle
>>> jumbo frames. And the second buffer is useless in this case. Am I
>>> right? Is there a better way than ifdef CONFIG_MACH_LOONGSON1 to
>>> avoid duplicate code?
>>
>> Sorry for my misunderstanding.
>>
>> I think you have to use the normal descriptor and remove the enh_desc
>> from the platform w/o modifying the driver at all.
>>
>> The driver will be able to select/configure all automatically (also jumbo).
>>
>> Let me know.
> 
> That's the problem.
> The bitfield definition of Loongson1B is also different from normal descriptor.

The problem is not in the Loongson1B gmac.

The normal descriptor fields in the stmmac refer to an old synopsys
databook.
New chips have the same structure you have added; so we should fix this
in the driver w/o breaking the compatibility for old chips.
I kindly ask you to confirm if the currently normal descriptor structure
(w/o your changes) doesn't work on your platform.
Did you test it?

> Moreover, I want to enable the TX checksum offload function which is
> not supported in normal descriptor.
> Any suggestions?

It is supported but you have to pass from the platform: tx_coe = 1.

Peppe
> 
>> Note:
>> IIRC, there is a bit difference in case of normal descriptors for
>> Synopsys databook newer than the 1.91 (I used for testing this mode).
>> In any case, I remember that, on some platforms, the normal descriptors
>> have been used w/o problems also on these new chip generations.
>>
>> Peppe
>>
>>
> 
> 
