Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2011 00:44:33 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:43587 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903878Ab1KPXoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Nov 2011 00:44:25 +0100
Received: by iapp10 with SMTP id p10so1553833iap.36
        for <multiple recipients>; Wed, 16 Nov 2011 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pTY0v1lQzHO22A6TgcBbdCsf/ZZPcW9t/T8sSpy75MU=;
        b=a2ZTh23oASVll+fV0+FgFHE+wSEGu/uuvAd1JdT6QWh7duGOQKRkkFOtf7v1VbLoLn
         B+8j9aS4ZFucrwcPPzUx2xtjvsulqpxnaLB15xXyT0RAotBbcLyHCwtbO/Pnd1ncfE2K
         J75gXmaiUVSC1Fmlst+6BfDmm6lQI9R104UDk=
Received: by 10.43.43.130 with SMTP id uc2mr35790823icb.35.1321487058878;
        Wed, 16 Nov 2011 15:44:18 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id jm11sm50197026ibb.1.2011.11.16.15.44.17
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 15:44:18 -0800 (PST)
Message-ID: <4EC44AD0.5070800@gmail.com>
Date:   Wed, 16 Nov 2011 15:44:16 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Rientjes <rientjes@google.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] hugetlb: Provide a default HPAGE_SHIFT if !CONFIG_HUGETLB_PAGE
References: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111161327180.16596@chino.kir.corp.google.com> <4EC43488.3070400@gmail.com> <alpine.DEB.2.00.1111161512371.16596@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1111161512371.16596@chino.kir.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 31710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13976

On 11/16/2011 03:18 PM, David Rientjes wrote:
> On Wed, 16 Nov 2011, David Daney wrote:
>
>>>> This is required now to get MIPS kernels to compile with
>>>> !CONFIG_HUGETLB_PAGE.
>>>>
>>>
>>> Why?
>>
>> I should have been more specific.  The failure is in Ralf's
>> mips-for-linux-next branch.
>>
>
> I can't find that branch (it's not in Ralf's tree at git.kernel.org), so
> I'm looking at next-20111116.  It doesn't compile for mips for other
> reasons related to arch/mips/sgi-ip22/ip22-gio.c.

Ralf's various trees are accessible via linux-mips.org

>
>>> This is definitely the wrong fix, anyway, and it would require a change to
>>> arch/mips/include/asm/page.h instead since it's localized to mips,
>>
>> No, all we are doing is supplying a dummy definition for HPAGE_SHIFT as we
>> currently have for HPAGE_SIZE and HPAGE_MASK.
>>
>
> Which is wrong.  MIPS code should not be using HPAGE_SHIFT without
> CONFIG_HUGETLB_PAGE and in fact defines it itself for such a configuration
> in arch/mips/include/asm/page.h.  The only generic uses are in
> page_alloc.c where we need CONFIG_HUGETLB_PAGE_SIZE_VARIABLE, which isn't
> available on mips, and in mm/hugetlb.c which requires CONFIG_HUGETLB_PAGE
> by way of CONFIG_HUGETLBFS.
>
> So feel free to show the actual compile error this time and I'll suggest a
> mips fix for it.

arch/mips/mm/tlb-r4k.c: In function ‘local_flush_tlb_range’:
arch/mips/mm/tlb-r4k.c:129:28: error: ‘HPAGE_SHIFT’ undeclared (first 
use in this function)


However, I call B.S. on your reasoning.

It is a well established kernel idiom to supply dummy values for symbols 
that are required to be defined in order to form a syntactically correct 
C program, but that are known by the programmer to be used only on dead 
code paths.

This is exactly what we are doing here.

To do otherwise requires that code be cluttered with #ifdefery.

David Daney



>>> so nack.
>>>
>>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>>> ---
>>>>    include/linux/hugetlb.h |    1 +
>>>>    1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index 19644e0..746d543 100644
>>>> --- a/include/linux/hugetlb.h
>>>> +++ b/include/linux/hugetlb.h
>>>> @@ -113,6 +113,7 @@ static inline void copy_huge_page(struct page *dst,
>>>> struct page *src)
>>>>    #ifndef HPAGE_MASK
>>>>    #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler
>>>> happy */
>>>>    #define HPAGE_SIZE	PAGE_SIZE
>>
>> Why didn't you NACK the addition of these two lines too?
>>
>> Following your logic, we should remove these and patch up all the architecture
>> specific files instead.
>>
>
> I think it's a worthwhile goal to remove these as well, yes.
>
