Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 17:51:30 +0100 (CET)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35839 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007391AbbCKQv2RLj9q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 17:51:28 +0100
Received: by igqa13 with SMTP id a13so41750691igq.0;
        Wed, 11 Mar 2015 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AzYYW7m1QUYFbVXi1dq5An8IEWn5CxlCG4AqVR+lMCg=;
        b=Gelf31wZUSk6wXUtubs9BL433nDVCt6Z9xDU3dnL0GYrwI+71EQUSYW0thTRv2780w
         lQ5NR4P08Jdt/Y0r740DvjpqSTsYhd4TB0D51bKMG5xfii4I8lBp68QBEn+B+3XsZXup
         UQB0PEI8moYPFRNL+vScO+OxQFNNEv0aq4Im60yuIMAhUC2RjS5GQzNZ+qGdAOIotlN0
         HauQhtiPjg6HQJWyhDFULH+QX4kkbx0uv9JCRknkbt0G7M6EAxby+UyBO71tAQWV7FQq
         A0UPg/aej4/mQ43SkAcmKaprlneA6yQaJyqDFKybCr5SzDKg+Hsj2Gk0xeAgk57kL3IT
         JAqA==
X-Received: by 10.107.131.159 with SMTP id n31mr32547185ioi.66.1426092683059;
        Wed, 11 Mar 2015 09:51:23 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id l64sm2744451iod.19.2015.03.11.09.51.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 11 Mar 2015 09:51:22 -0700 (PDT)
Message-ID: <55007288.20008@gmail.com>
Date:   Wed, 11 Mar 2015 09:51:20 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <Markos.Chandras@imgtec.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] Revert "MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction"
References: <1424731974-27926-1-git-send-email-ddaney.cavm@gmail.com> <54FFFCC7.5090707@imgtec.com>
In-Reply-To: <54FFFCC7.5090707@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 03/11/2015 01:28 AM, Markos Chandras wrote:
> On 02/23/2015 10:52 PM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> This reverts commit 77f3ee59ee7cfe19e0ee48d9a990c7967fbfcbed.
>>
>> There are two problems:
>>
>> 1) It breaks OCTEON, which will now crash in early boot with:
>>
>>    Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)
>>
>> 2) The logic is broken.
>>
>> The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction
>> is required.  The offending patch attempts (and fails) to change the
>> meaning to be that EHB is part of the ISA.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
> Hi,
>
> First of all sorry about the octeon breakage.
>
> However, whilst this patch will fix Octeon it will break R6
>

But breaking R6 is not a regression, breaking OCTEON is.  For new code, 
there is this bit of asymmetry.

> Can we please consider another patch that will simply use
> cpu_has_mips_r2_r6 instead of cpu_has_mips_r2 so both will work in 4.0?
>

If you have a patch that fixes the problem properly, please post it for 
consideration.

Thanks,
David Daney
