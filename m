Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2011 09:10:03 +0200 (CEST)
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:48132 "EHLO
        eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab1JYHJz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2011 09:09:55 +0200
Received: from beta.dmz-eu.st.com ([164.129.1.35]) (using TLSv1) by eu1sys200aob101.postini.com ([207.126.147.11]) with SMTP;
        Tue, 25 Oct 2011 07:09:55 UTC
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62FF1FF;
        Tue, 25 Oct 2011 07:09:41 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF43E168C;
        Tue, 25 Oct 2011 07:09:40 +0000 (GMT)
Received: from [10.52.139.57] (ctn000522.ctn.st.com [10.52.139.57])
        by mail7.sgp.st.com (MOS 4.1.8-GA)
        with ESMTP id AKG16657 (AUTH cavagiu);
        Tue, 25 Oct 2011 09:09:39 +0200
Message-ID: <4EA660C0.1020901@st.com>
Date:   Tue, 25 Oct 2011 09:09:52 +0200
From:   Giuseppe CAVALLARO <peppe.cavallaro@st.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, netdev@vger.kernel.org
Subject: Re: [PATCH V2 2/4] MIPS: Add board support for Loongson1B
References: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com> <1319192888-21465-2-git-send-email-keguang.zhang@gmail.com> <CAD+V5YKBkW52_md9rBeVZ1RXq2FGEXt=Ergsw+z8txMreZdNsA@mail.gmail.com> <4EA5117C.3000402@st.com> <CAJhJPsVSzXXmBOwLaGNtOsxhVEyC0fAJtiBvEWzcKcSDC8NEcA@mail.gmail.com> <4EA557B2.4020504@st.com> <CAJhJPsXxUAuF9HdivLd66MQC45mz-iYAuF1SdGdU=-duxJJ5bQ@mail.gmail.com> <4EA585B5.5030405@st.com> <CAJhJPsVu7hahhmUvPQ=s=AqvXGhU-05x=GqQ29Mo6PZ8cTtefA@mail.gmail.com>
In-Reply-To: <CAJhJPsVu7hahhmUvPQ=s=AqvXGhU-05x=GqQ29Mo6PZ8cTtefA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peppe.cavallaro@st.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17859

On 10/25/2011 4:12 AM, Kelvin Cheung wrote:
> 2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
>> On 10/24/2011 4:05 PM, Kelvin Cheung wrote:
>>> 2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
>>>> Hello Kelvin.
>>>>
>>>> On 10/24/2011 12:36 PM, Kelvin Cheung wrote:
>>>>
>>>> [snip]
>>>>
>>>>> According to datasheet of Loongson 1B, the buffer size in RX/TX
>>>>> descriptor is only 2KB. So the Loongson1B's GMAC could not handle
>>>>> jumbo frames. And the second buffer is useless in this case. Am I
>>>>> right? Is there a better way than ifdef CONFIG_MACH_LOONGSON1 to
>>>>> avoid duplicate code?
>>>>
>>>> Sorry for my misunderstanding.
>>>>
>>>> I think you have to use the normal descriptor and remove the enh_desc
>>>> from the platform w/o modifying the driver at all.
>>>>
>>>> The driver will be able to select/configure all automatically (also
>>>> jumbo).
>>>>
>>>> Let me know.
>>>
>>> That's the problem.
>>> The bitfield definition of Loongson1B is also different from normal
>>> descriptor.
>>
>> The problem is not in the Loongson1B gmac.
> 
> I found that the bit checksum_insertion is not existed in normal descriptor.
> 
>> The normal descriptor fields in the stmmac refer to an old synopsys
>> databook.
> 
> Could you send me the new databook of Synopsys GMAC?
> 
>> New chips have the same structure you have added; so we should fix this
>> in the driver w/o breaking the compatibility for old chips.
> 
> Agree.
> 
>> I kindly ask you to confirm if the currently normal descriptor structure
>> (w/o your changes) doesn't work on your platform.
>> Did you test it?
> 
> Well, the normal descriptor works on my platform except TX checksum offload.

ok! I suspected that.


>>> Moreover, I want to enable the TX checksum offload function which is
>>> not supported in normal descriptor.
>>> Any suggestions?
>>
>> It is supported but you have to pass from the platform: tx_coe = 1.
> 
> I noticed that the flag csum_insertion is passed to
> ndesc_prepare_tx_desc() in stmmac_xmit(). But ndesc_prepare_tx_desc()
> just ignores it.
> In other words, the TX checksum offload function is disabled in normal
> descriptor currently.
> 
> Should we fix this problem for normal descriptor?

Yes, we should. If you agree, I'll update the normal descriptor
structure to yours. This is the normal descriptor used in newer GMAC.
Tx csum will be done for normal descriptors in case of these GMAC
devices and not for old MAC10/100. For the MAC10/100 some bits for
normal descriptors are reserved and won't be used at all.

I'll also verify that the patch doesn't break the back-compatibility
with old MAC10/100. I have the HW where doing the tests.

After that, I'll prepare the patch for net-next and for your kernel.

> 
>> Peppe
>>>
>>>> Note:
>>>> IIRC, there is a bit difference in case of normal descriptors for
>>>> Synopsys databook newer than the 1.91 (I used for testing this mode).
>>>> In any case, I remember that, on some platforms, the normal descriptors
>>>> have been used w/o problems also on these new chip generations.
>>>>
>>>> Peppe
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 
