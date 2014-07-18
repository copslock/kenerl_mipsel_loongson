Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 20:05:38 +0200 (CEST)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:64446 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861344AbaGRSFbue4bj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 20:05:31 +0200
Received: by mail-lb0-f170.google.com with SMTP id w7so2290324lbi.29
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 11:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=n5f2X0bvfHuJv8Y6kyU6zw9QXrcvmKPe/PujzhJj1BE=;
        b=ZSEOZ1+nKEjTb3tH8rXV058pL1Hc8jVlWs/4u0oo3rWKB/DyoH71WPRuCRsGWJfwJ6
         YypS2cnrSTnvdJLeufVi1HJ9dbVWnoypTht7dJ8c6IjvnOdaH6+P+G6BjEaxEBY2uZsa
         XjanedEiSZEsrYnyNVnlqGIf9qiua8cuN6LjnmJM9ye3IPnmgHCTfoY22jykvt1Syt0b
         ztYux54vxgMmM2WU48L5vKqpjQNjPNZl2D8Kd6tJO0sqIXVEAfT3U+8fPvoOq7Lk1prT
         vvJNoK+CuLgdK8Z7Z/5UV0M+ZbjKAH+eiXjBzNHO7fMoBwJyfa1atPL4QEpsXiIU60j5
         +BaQ==
X-Gm-Message-State: ALoCoQm2OCe387v5gxZZnw0Lc22ct0hA0KbqaB0pvO5taGwG1OaqVfoLSMvee3Lg2PiO8LJUUSPx
X-Received: by 10.152.21.132 with SMTP id v4mr7314037lae.24.1405706726012;
        Fri, 18 Jul 2014 11:05:26 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp25-152.pppoe.mtu-net.ru. [81.195.25.152])
        by mx.google.com with ESMTPSA id n1sm10448499lbs.0.2014.07.18.11.05.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 11:05:25 -0700 (PDT)
Message-ID: <53C961E9.9000803@cogentembedded.com>
Date:   Fri, 18 Jul 2014 22:05:29 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] MIPS: GIC: Fix GICBIS macro
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com> <1405585259-24941-8-git-send-email-markos.chandras@imgtec.com> <53C7C5E2.1020307@cogentembedded.com> <53C8D2AE.3020300@imgtec.com>
In-Reply-To: <53C8D2AE.3020300@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41325
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

Hello.

On 07/18/2014 11:54 AM, Jeffrey Deans wrote:

>>> From: Jeffrey Deans <jeffrey.deans@imgtec.com>

>>> The GICBIS macro could update the GIC registers incorrectly, depending
>>> on the data value passed in:

>>> * Bits were only OR'd into the register data, so register fields could
>>>    not be cleared.

>>> * Bits were OR'd into the register data without masking the data to the
>>>    correct field width, corrupting adjacent bits.

>>> Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>>   arch/mips/include/asm/gic.h | 21 +++++++++++----------
>>>   1 file changed, 11 insertions(+), 10 deletions(-)

>>> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
>>> index 8b30befd99d6..3f20b2111d56 100644
>>> --- a/arch/mips/include/asm/gic.h
>>> +++ b/arch/mips/include/asm/gic.h
>>> @@ -43,18 +43,17 @@
>>>   #ifdef GICISBYTELITTLEENDIAN
>>>   #define GICREAD(reg, data)    ((data) = (reg), (data) =
>>> le32_to_cpu(data))
>>>   #define GICWRITE(reg, data)    ((reg) = cpu_to_le32(data))
>>> -#define GICBIS(reg, bits)            \
>>> -    ({unsigned int data;            \
>>> -        GICREAD(reg, data);        \
>>> -        data |= bits;            \
>>> -        GICWRITE(reg, data);        \
>>> -    })
>>> -
>>>   #else
>>>   #define GICREAD(reg, data)    ((data) = (reg))
>>>   #define GICWRITE(reg, data)    ((reg) = (data))
>>> -#define GICBIS(reg, bits)    ((reg) |= (bits))
>>>   #endif
>>> +#define GICBIS(reg, mask, bits)            \
>>> +    do { u32 data;                \
>>> +        GICREAD((reg), data);        \

>>     Why () only around 'reg', not around 'data'?

> Brackets aren't necessary around "data" because it is declared at the start of
> the "do" code block, so it can't expand to anything else within that scope.

    Oh, I was not attentive enough, sorry about that... :-<
    However, it makes sense to at least put that declaration at a separate line.

WBR, Sergei
