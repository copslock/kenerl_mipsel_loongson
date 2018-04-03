Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2018 00:40:20 +0200 (CEST)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:37457
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeDCWkNJPH6y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2018 00:40:13 +0200
Received: by mail-pl0-x244.google.com with SMTP id v5-v6so9134270plo.4
        for <linux-mips@linux-mips.org>; Tue, 03 Apr 2018 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FyK+5vnYk5I18p/dtMldg/7KzuU+Ln/R0QBahsynNuo=;
        b=cyZPul60fwCQM4eh9c47D3PoEDvBjIBcr0BOQfZXzjl6Z3OUq5/WfSlT0/+FLwq7iH
         /wtb2u9NZXgDKDjUfPyE8Q+rmYqYHzP/PuHZcv6ZehCnISpxeFm4WKF9l/nbBY9LWJ7b
         s2Qx1FFLcJbFFGO+BahNd0fDHls9hdmJOT4oV4l1QiAoy2cDeST+HylHmSzpxgB02uXb
         CR8GaPj+vkf55tiLLlXcMQjJ42its6Y5bAhev12XzNjgA6y9KHLEeC+s44wBKPPKaP9N
         q0YZDt5zcJHDSsPpVI12GmRqni8o4eeur5dWvKxAfqyzPRDn4CJnD9iVX5dLqeLCxbhl
         cJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FyK+5vnYk5I18p/dtMldg/7KzuU+Ln/R0QBahsynNuo=;
        b=ba1M4wXHabEWpwbIzhzvlPF80o4JthI9PxjyMvl6ltxvbETzNW/6/C+E7ZGBs7rbho
         QDZOlUWcwm7kIR8fawobz+CiIfkti8ljkyGTfUNnQqY2B/UsJa2Ji7ToHCg9CnHKqB2U
         6onxD4H8Y2ufaRFwv8zhXAPOuMo6O7ShnV+jgHITx7pTpeVZUsBjdBCx4kiwa13r8APz
         dl8w46UvRWKhxyf1ut27g842JSiDE+lzzrezB64Eb3qltm3EBDRE98MH5gngcDVm2bqm
         UZnFNoLk2Tjyl72et2tEMV56e+irFkogwxNVbFgxpi5EukcJ6H0zacBDraSej6uzKxuo
         dBsw==
X-Gm-Message-State: AElRT7HrcdkOqHYCc4Ea06L9gT1ht2uGEJOa4UCkNd/c81HPA8KpCluj
        YgX02CrD95rfDQRaQuKxTjY4Ag==
X-Google-Smtp-Source: AIpwx48Af7iM55TxdtnwAMjhDUhrjVe0cU70s23+lbcTBxD/S2IR1VI5UYhL7ekcKWWhy4uACVaZRg==
X-Received: by 2002:a17:902:ba87:: with SMTP id k7-v6mr16220255pls.124.1522795205055;
        Tue, 03 Apr 2018 15:40:05 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 89sm8002326pfs.156.2018.04.03.15.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 15:40:04 -0700 (PDT)
Date:   Tue, 03 Apr 2018 15:40:04 -0700 (PDT)
X-Google-Original-Date: Tue, 03 Apr 2018 15:40:02 PDT (-0700)
Subject:     Re: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
In-Reply-To: <4ba976ed-7294-18ec-187f-7105a9782283@mips.com>
CC:     antonynpavlov@gmail.com, jhogan@kernel.org, ralf@linux-mips.org,
        linux-mips@linux-mips.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     matt.redfearn@mips.com
Message-ID: <mhng-56a331c2-0719-4c87-b1c9-172b64b5c315@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Tue, 03 Apr 2018 06:51:06 PDT (-0700), matt.redfearn@mips.com wrote:
> Hi Palmer,
>
> On 29/03/18 22:59, Palmer Dabbelt wrote:
>> On Thu, 29 Mar 2018 03:41:21 PDT (-0700), matt.redfearn@mips.com wrote:
>>> From: Palmer Dabbelt <palmer@sifive.com>
>>>
>>> As part of the MIPS conversion to use the generic GCC library routines,
>>> Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
>>> patch rectifies the problem.
>>>
>>> CC: Matt Redfearn <matt.redfearn@mips.com>
>>> CC: Antony Pavlov <antonynpavlov@gmail.com>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>> ---
>>>
>>> Changes in v4: None
>>> Changes in v3: None
>>> Changes in v2:
>>>   add notrace to lib/ucmpdi2.c
>>>
>>>  lib/ucmpdi2.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
>>> index 25ca2d4c1e19..597998169a96 100644
>>> --- a/lib/ucmpdi2.c
>>> +++ b/lib/ucmpdi2.c
>>> @@ -17,7 +17,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/libgcc.h>
>>>
>>> -word_type __ucmpdi2(unsigned long long a, unsigned long long b)
>>> +word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>>>  {
>>>      const DWunion au = {.ll = a};
>>>      const DWunion bu = {.ll = b};
>> 
>> Ah, thanks, I think I must have forgotten about this.  I assume these 
>> three are going through your tree?
>
> Yeah I think that's the plan - James will need your ack to patch 2 if 
> that's ok.

OK, I think I acked the right one... :)
