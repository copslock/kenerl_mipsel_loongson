Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2011 09:48:36 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:55436 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab1JZHsc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2011 09:48:32 +0200
Received: by bkbc12 with SMTP id c12so1681919bkb.36
        for <multiple recipients>; Wed, 26 Oct 2011 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AmiDq+Q/+EQBRUlF7xyhnJ4bUh4gOsy8iukLOAsEgyQ=;
        b=AHUGsV863k0Wbw9bDipqLSBEMO9JY9xmkeQmonH+WrxQoJnqfg8gqe1WNYhXRNL7ey
         f4BFCAWR3kC0nhdrjxMFhqbN9AkbMR/vpge3Omd+abB4D0CWYaMWFW6lfleHcLeRw3NQ
         pVQ5Mt7cU9ksoCfQewtzBO5QuH2VXWxefvfJM=
MIME-Version: 1.0
Received: by 10.204.4.147 with SMTP id 19mr12877675bkr.9.1319615306816; Wed,
 26 Oct 2011 00:48:26 -0700 (PDT)
Received: by 10.204.78.134 with HTTP; Wed, 26 Oct 2011 00:48:26 -0700 (PDT)
In-Reply-To: <4EA7B4D7.9000101@st.com>
References: <1319192888-21465-1-git-send-email-keguang.zhang@gmail.com>
        <1319192888-21465-2-git-send-email-keguang.zhang@gmail.com>
        <CAD+V5YKBkW52_md9rBeVZ1RXq2FGEXt=Ergsw+z8txMreZdNsA@mail.gmail.com>
        <4EA5117C.3000402@st.com>
        <CAJhJPsVSzXXmBOwLaGNtOsxhVEyC0fAJtiBvEWzcKcSDC8NEcA@mail.gmail.com>
        <4EA557B2.4020504@st.com>
        <CAJhJPsXxUAuF9HdivLd66MQC45mz-iYAuF1SdGdU=-duxJJ5bQ@mail.gmail.com>
        <4EA585B5.5030405@st.com>
        <CAJhJPsVu7hahhmUvPQ=s=AqvXGhU-05x=GqQ29Mo6PZ8cTtefA@mail.gmail.com>
        <4EA660C0.1020901@st.com>
        <4EA6716A.80307@st.com>
        <CAJhJPsU3KMNuGcKaKf3H4pUCeu1+vnEz4DgO_jbm+wDQb1G4OA@mail.gmail.com>
        <4EA7B4D7.9000101@st.com>
Date:   Wed, 26 Oct 2011 15:48:26 +0800
Message-ID: <CAJhJPsUfk9PbQoTnBnxv7n+aWY0qFPqWpy23nVw6S_v9=S2Q6A@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] MIPS: Add board support for Loongson1B
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        r0bertz@gentoo.org, netdev@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18731

It's perfect now.
Please add me to CC list when you send the new patch.

Thanks a lot for your help.

2011/10/26, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
> Hello Kelvin
>
> On 10/26/2011 6:27 AM, Kelvin Cheung wrote:
>> Hi Giuseppe,
>>
>> This patch works well on Loongson1B platform except one thing.
>> The rx checksum offload of normal descriptor is disabled by default.
>> So, I enabled this functon. And one minor tweak is added to your patch.
>> What about your opinion?
>
> Yes, I had not enabled the rx coe. I'm resending your patch (v3) where I
> fixed a problem. Old mac10/100 has no rx csum in HW. So I added an extra
> check.
> Let me consider it the final version. ;-)
>
> Thanks a lot for you effort.
> I'll send it for net-next now.
>
> Regards
> Peppe
>
>>
>> BTW, tx checksum insertion works now.
>>
>> 2011/10/25, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
>>> On 10/25/2011 9:09 AM, Giuseppe CAVALLARO wrote:
>>>> On 10/25/2011 4:12 AM, Kelvin Cheung wrote:
>>>>> 2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
>>>>>> On 10/24/2011 4:05 PM, Kelvin Cheung wrote:
>>>>>>> 2011/10/24, Giuseppe CAVALLARO <peppe.cavallaro@st.com>:
>>>>>>>> Hello Kelvin.
>>>>>>>>
>>>>>>>> On 10/24/2011 12:36 PM, Kelvin Cheung wrote:
>>>>>>>>
>>>>>>>> [snip]
>>>>>>>>
>>>>>>>>> According to datasheet of Loongson 1B, the buffer size in RX/TX
>>>>>>>>> descriptor is only 2KB. So the Loongson1B's GMAC could not handle
>>>>>>>>> jumbo frames. And the second buffer is useless in this case. Am I
>>>>>>>>> right? Is there a better way than ifdef CONFIG_MACH_LOONGSON1 to
>>>>>>>>> avoid duplicate code?
>>>>>>>>
>>>>>>>> Sorry for my misunderstanding.
>>>>>>>>
>>>>>>>> I think you have to use the normal descriptor and remove the
>>>>>>>> enh_desc
>>>>>>>> from the platform w/o modifying the driver at all.
>>>>>>>>
>>>>>>>> The driver will be able to select/configure all automatically (also
>>>>>>>> jumbo).
>>>>>>>>
>>>>>>>> Let me know.
>>>>>>>
>>>>>>> That's the problem.
>>>>>>> The bitfield definition of Loongson1B is also different from normal
>>>>>>> descriptor.
>>>>>>
>>>>>> The problem is not in the Loongson1B gmac.
>>>>>
>>>>> I found that the bit checksum_insertion is not existed in normal
>>>>> descriptor.
>>>>>
>>>>>> The normal descriptor fields in the stmmac refer to an old synopsys
>>>>>> databook.
>>>>>
>>>>> Could you send me the new databook of Synopsys GMAC?
>>>>>
>>>>>> New chips have the same structure you have added; so we should fix
>>>>>> this
>>>>>> in the driver w/o breaking the compatibility for old chips.
>>>>>
>>>>> Agree.
>>>>>
>>>>>> I kindly ask you to confirm if the currently normal descriptor
>>>>>> structure
>>>>>> (w/o your changes) doesn't work on your platform.
>>>>>> Did you test it?
>>>>>
>>>>> Well, the normal descriptor works on my platform except TX checksum
>>>>> offload.
>>>>
>>>> ok! I suspected that.
>>>>
>>>>
>>>>>>> Moreover, I want to enable the TX checksum offload function which is
>>>>>>> not supported in normal descriptor.
>>>>>>> Any suggestions?
>>>>>>
>>>>>> It is supported but you have to pass from the platform: tx_coe = 1.
>>>>>
>>>>> I noticed that the flag csum_insertion is passed to
>>>>> ndesc_prepare_tx_desc() in stmmac_xmit(). But ndesc_prepare_tx_desc()
>>>>> just ignores it.
>>>>> In other words, the TX checksum offload function is disabled in normal
>>>>> descriptor currently.
>>>>>
>>>>> Should we fix this problem for normal descriptor?
>>>>
>>>> Yes, we should. If you agree, I'll update the normal descriptor
>>>> structure to yours. This is the normal descriptor used in newer GMAC.
>>>> Tx csum will be done for normal descriptors in case of these GMAC
>>>> devices and not for old MAC10/100. For the MAC10/100 some bits for
>>>> normal descriptors are reserved and won't be used at all.
>>>>
>>>> I'll also verify that the patch doesn't break the back-compatibility
>>>> with old MAC10/100. I have the HW where doing the tests.
>>>>
>>>> After that, I'll prepare the patch for net-next and for your kernel.
>>>
>>> Hello Kelvin
>>>
>>> attached the patch tested on my development kernel.
>>> It runs fine on old and new mac devices.
>>>
>>> Can you try it on your side? Hmm, it is likely it won't apply fine on
>>> your tree but you know the changes ;-).
>>>
>>> If ok, I'll rework it for net-next and send it to the mailing list.
>>>
>>> Thanks
>>> Peppe
>>>
>>>>
>>>>>
>>>>>> Peppe
>>>>>>>
>>>>>>>> Note:
>>>>>>>> IIRC, there is a bit difference in case of normal descriptors for
>>>>>>>> Synopsys databook newer than the 1.91 (I used for testing this
>>>>>>>> mode).
>>>>>>>> In any case, I remember that, on some platforms, the normal
>>>>>>>> descriptors
>>>>>>>> have been used w/o problems also on these new chip generations.
>>>>>>>>
>>>>>>>> Peppe
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>>
>>
>
>


-- 
Best Regards!
Kelvin
