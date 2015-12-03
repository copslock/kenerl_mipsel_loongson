Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 18:46:26 +0100 (CET)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36310 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013134AbbLCRqXZRmao (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 18:46:23 +0100
Received: by lbblt2 with SMTP id lt2so6309165lbb.3
        for <linux-mips@linux-mips.org>; Thu, 03 Dec 2015 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=ny0OPqgG146D/v2LZcPiv36ns9pfe9zlY2UE6zfhS7Q=;
        b=n3g1ASiu4eUAAoeEUqT6U+HSSmcYJrkZA2IMW8VT1Jw6Mv6VT6gDtANNe0O9qIV3qh
         sO3Sizx0onnVwPRL8DjKfRvw6+cL3aXrswsA+j3RJ0I5YxMVjmkAtlMxBTsCyOpnN5/K
         XloRvP+SZjWJJ7vac+N0RDNbzhTasqI3eu/1A8tlS5CAfAd5S6ite47S1tVj5SaFsrBt
         RcUjPxVXBZqyRSOAApljmt02oZ0ARwN98jr7f8VR/pBYFKzuzTihHYEBXnvdmod+m0Oq
         ErgRzke/XS5pfCQWkaxTLiVg8g6KdVmDPFhF7glW9rOXh5vhg8k9jLSzBYt/i3yZXck4
         P+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ny0OPqgG146D/v2LZcPiv36ns9pfe9zlY2UE6zfhS7Q=;
        b=VV+DyRLafwPOUO48a78zLzx2OE0p9xrVg4OpbTDl/xeOY6xBCX3uopkkJmftqgr+Y3
         Gn2PoPH5T7oY0dI0dyayQXAT5szDufe4skJLnmy0w57DZYH3K23F28z2R7ixriF1Msb2
         El4LR5of5PGBbmheYE0KF2ZaY54TOXUrVyjNK7lTaHm8J+RdgBMFDr+A7APcWVBy6rO5
         22NHcKktLCw4P2i6H70HYiMuH2ZZ5dBvlyWT1NgsQP5pG0Kxri8vKw8fhKvQULyZtq9A
         qBL9A4Y+dS1F9KHrZUBwBO9xJowRw5Xo/+LhTnT9cu3BdOrR5WyRrR/p2CLKwvHaW4wJ
         jS1g==
X-Gm-Message-State: ALoCoQmL2MzS3TI0vTqLt7fFcGmDaBpb0YAyNJBMBPUneQodxgEoUhn0xViYXtmZVZTIaTxzSx3u
X-Received: by 10.112.51.52 with SMTP id h20mr6213512lbo.110.1449164777096;
        Thu, 03 Dec 2015 09:46:17 -0800 (PST)
Received: from wasted.cogentembedded.com ([83.149.8.114])
        by smtp.gmail.com with ESMTPSA id ak1sm1579004lbc.2.2015.12.03.09.46.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Dec 2015 09:46:16 -0800 (PST)
Subject: Re: [PATCH 6/9] MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
To:     Matt Redfearn <matt.redfearn@imgtec.com>, linux-mips@linux-mips.org
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com>
 <56605081.5050307@cogentembedded.com> <5660577F.2020401@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <56607FE6.7040001@cogentembedded.com>
Date:   Thu, 3 Dec 2015 20:46:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5660577F.2020401@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 12/03/2015 05:53 PM, Matt Redfearn wrote:

>>> If CONFIG_RELOCATABLE is enabled, jump to relocate_kernel.
>>>
>>> This function will return the entry point of the relocated kernel if
>>> copy/relocate is sucessful or the original entry point if not. The stack
>>> pointer must then be pointed into the new image.
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> ---
>>>   arch/mips/kernel/head.S | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>>> index 4e4cc5b9a771..7dc043349d66 100644
>>> --- a/arch/mips/kernel/head.S
>>> +++ b/arch/mips/kernel/head.S
>>> @@ -132,7 +132,27 @@ not_found:
>>>       set_saved_sp    sp, t0, t1
>>>       PTR_SUBU    sp, 4 * SZREG        # init stack pointer
>>>
>>> +#ifdef CONFIG_RELOCATABLE
>>> +    /* Copy kernel and apply the relocations */
>>> +    jal        relocate_kernel
>>> +
>>> +    /* Repoint the sp into the new kernel image */
>>> +    PTR_LI        sp, _THREAD_SIZE - 32 - PT_SIZE
>>> +    PTR_ADDU    sp, $28
>>
>>    Can't you account for it in the previous PTR_LI?

> During relocate_kernel, $28, pointer to the current thread,

    Ah, it's a register! I thought it was an immediate. Nevermind then. :-)

[...]

MBR, Sergei
