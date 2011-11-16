Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 23:09:28 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:58015 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903875Ab1KPWJV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 23:09:21 +0100
Received: by iapp10 with SMTP id p10so1433793iap.36
        for <multiple recipients>; Wed, 16 Nov 2011 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xBWuxsEGLH+emo1Jo3MQwkEdicuv1Arl5KifMFUU4sY=;
        b=VHLA/HtWZuK4YKNiJxBJF+3aMQXZrq0bWHKsPVNU0mrrGJgU/2uSa5wSRAFz+QeFxm
         R1j33Rg3NOVivBX88pwPDtvRG+ffWKz8TGxXFoCP83IRG05XulgaT5dUTP8tvxOJ3NER
         DfWEBjelK+0pziGJqCnGqRrU9Z1iiLeHChXd8=
Received: by 10.43.52.136 with SMTP id vm8mr35506460icb.26.1321481354860;
        Wed, 16 Nov 2011 14:09:14 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id eb23sm49304694ibb.2.2011.11.16.14.09.13
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 14:09:14 -0800 (PST)
Message-ID: <4EC43488.3070400@gmail.com>
Date:   Wed, 16 Nov 2011 14:09:12 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Rientjes <rientjes@google.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        William Irwin <wli@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] hugetlb: Provide a default HPAGE_SHIFT if !CONFIG_HUGETLB_PAGE
References: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com> <alpine.DEB.2.00.1111161327180.16596@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.00.1111161327180.16596@chino.kir.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13883

On 11/16/2011 01:32 PM, David Rientjes wrote:
> On Wed, 16 Nov 2011, David Daney wrote:
>
>> From: David Daney<david.daney@cavium.com>
>>
>> This is required now to get MIPS kernels to compile with
>> !CONFIG_HUGETLB_PAGE.
>>
>
> Why?

I should have been more specific.  The failure is in Ralf's 
mips-for-linux-next branch.

>  Apparently there's some config option you've enabled that is causing
> it to fail but I can't find it.  defconfig works fine on my mips
> crosscompiler and allyesconfig is borked already in other ways.

Please look in the mips-for-linux-next branch.

>
> This is definitely the wrong fix, anyway, and it would require a change to
> arch/mips/include/asm/page.h instead since it's localized to mips,

No, all we are doing is supplying a dummy definition for HPAGE_SHIFT as 
we currently have for HPAGE_SIZE and HPAGE_MASK.


> so nack.
>
>> Signed-off-by: David Daney<david.daney@cavium.com>
>> ---
>>   include/linux/hugetlb.h |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 19644e0..746d543 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -113,6 +113,7 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
>>   #ifndef HPAGE_MASK
>>   #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
>>   #define HPAGE_SIZE	PAGE_SIZE

Why didn't you NACK the addition of these two lines too?

Following your logic, we should remove these and patch up all the 
architecture specific files instead.

David Daney

>> +#define HPAGE_SHIFT	PAGE_SHIFT
>>   #endif
>>
>>   #endif /* !CONFIG_HUGETLB_PAGE */
>
