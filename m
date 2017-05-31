Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 18:28:52 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:35904
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdEaQ2okjz8F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 18:28:44 +0200
Received: by mail-pf0-x242.google.com with SMTP id n23so3084538pfb.3;
        Wed, 31 May 2017 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2EiErcJvubJvvXIFVptJUrHhbdAm9EzYJABFJ+JK1sM=;
        b=AC96V/nPM6ToWzfgVIQmTP+p1x6+rfzyyHEq+Uu+yfhns9ilAQ54lty9ZwbxSXB04j
         Wgg1XqXoiRoByyspDKrGWzhAjaBD7Fos4lEEj0ebNSWN2dGbvN3rBe/aDpGN4lFzT2qK
         yQJbASAMlowsBcl9fN6dmtKnia6nY0YDAZN7Qxw3oUyuUBKdxZDv3YXirfczPzFJf5ct
         vlR++1rmJgTCZdmCPE6V/hr+QJZcZpO9tQ9/6nTWfmd/myByxnYr6RyVOCNBMQKwFD7x
         1ccb6JBA06qjYhgack7ifbXCeP9eOEjhOs8pQ+247TY0FK1ODHPH2KR0lxlaPqJl8EeL
         HRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2EiErcJvubJvvXIFVptJUrHhbdAm9EzYJABFJ+JK1sM=;
        b=r68aBgirS+oE6CPgwOzMDQbWnn9bGvQMTNHJ3Jz55Rtd/6DRFHAwbnAgklhgrCsR4q
         YuGAz5PYgb4OPscOJgmFXRIVwzRBY4WZ0kqh8D3KmC0NJNO8bXpOgFxnl+um3Dn8JEHJ
         dHeDhi9mVpJyKy2aem9JlaWgVsLKTEuc3gk1jiBtyeE2KedznT+bhToLeuMAJyVDZY0Q
         VG5drydKfVs/ByZ5i9tzGmzamNQ3Kw/McaPF0CdeYsatDQCstc5IlbcmwvHEMrRQnN/h
         V2INJ2MBWPEU2yhFNFTlcKCqw0GaTogYrKuXR1xlaKhrgONHRoqAhPHIH7ELmnTgrZMh
         GYuw==
X-Gm-Message-State: AODbwcDaF14fFptBv3U3JJVWFcRifgmslrMVBIylVYDMM9Gqilx+BPSo
        b/XNo1/oZJ7D/A==
X-Received: by 10.84.139.195 with SMTP id 61mr39405773plr.152.1496248118560;
        Wed, 31 May 2017 09:28:38 -0700 (PDT)
Received: from ddl.caveonetworks.com (50-233-148-156-static.hfc.comcastbusiness.net. [50.233.148.156])
        by smtp.googlemail.com with ESMTPSA id t17sm27101903pfj.61.2017.05.31.09.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 09:28:37 -0700 (PDT)
Subject: Re: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
 <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com>
From:   David Daney <ddaney.cavm@gmail.com>
Message-ID: <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
Date:   Wed, 31 May 2017 09:28:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58096
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

On 05/31/2017 08:19 AM, James Hogan wrote:
> Adjust the atomic loop in the MIPS_ATOMIC_SET operation of the sysmips
> system call to branch straight back to the linked load rather than
> jumping via a different subsection (whose purpose remains a mystery to
> me).

The subsection keeps the code for the (hopefully) cold path out of line 
which should result in a smaller cache footprint in the hot path.


> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>   arch/mips/kernel/syscall.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> index ca54ac40252b..6c6bf43d681b 100644
> --- a/arch/mips/kernel/syscall.c
> +++ b/arch/mips/kernel/syscall.c
> @@ -137,13 +137,9 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
>   		"	move	%[tmp], %[new]				\n"
>   		"2:							\n"
>   		user_sc("%[tmp]", "(%[addr])")
> -		"	beqz	%[tmp], 4f				\n"
> +		"	beqz	%[tmp], 1b				\n"
>   		"3:							\n"
>   		"	.insn						\n"
> -		"	.subsection 2					\n"
> -		"4:	b	1b					\n"
> -		"	.previous					\n"
> -		"							\n"
>   		"	.section .fixup,\"ax\"				\n"
>   		"5:	li	%[err], %[efault]			\n"
>   		"	j	3b					\n"
> 
