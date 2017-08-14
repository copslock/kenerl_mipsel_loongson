Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 18:48:43 +0200 (CEST)
Received: from mail-lf0-x22b.google.com ([IPv6:2a00:1450:4010:c07::22b]:32885
        "EHLO mail-lf0-x22b.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993931AbdHNQsdKl9t- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 18:48:33 +0200
Received: by mail-lf0-x22b.google.com with SMTP id d17so42184331lfe.0
        for <linux-mips@linux-mips.org>; Mon, 14 Aug 2017 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTVKzwNG6tWcMolDV3BumgFvrlgMGyfQYzFpP/BRAhM=;
        b=gSNoFZu+VemPtLgUx+V1f/+zq69X1i+WnzvCt6NAk3dF2B/jYcmkNttT1pNDCSB/h5
         UFWFOrgnj6UnZtXQ0WzrEVP6hYoeBDj/Acv7iVWhCgh/9LcxzEU6AsOa2UcNxdrdIyga
         YYqgM6tIBbzbx1IlgMwYfhYTW61au0sXmatHsOowOOd6vj/crE4qnIsuemX8A0wrFJXG
         iXyTOerNz6f7HrgwQZb0gF2T69W8WGpq6bIowe6OaKNV/9i3HMm9ZzBz0WI4iNFlQhLE
         HW6TPW3E1An4UISBKUXqUkjZcDFuQI0OPNfCJwhlV34V2zR4VeaTa+obEAQvGCE4gaKs
         oSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QTVKzwNG6tWcMolDV3BumgFvrlgMGyfQYzFpP/BRAhM=;
        b=KrQizDMv3GgGpT0QIIfiw15R5FxBxkOym/Y+zONpJtga0zDiiEpAeq2NZodNnX4mAd
         drHDzcL0tuJxC/OdU6hJ0AmDe3/+EQ5o4pWEsPWORPAJoOnxl5iIoShh4SMeo3LuU1BJ
         L/P2JM+TrmkVugkqrr4hOoIoCcJNZ33cbm1U68p3v2m0kNhJwWco/v2smUQ4Hvl/SuTb
         ol5nRfndjLmu3D5u+fCaDXEBZiJvi1N3deyagjWCnjB0ONQNfVvbDOH50jK5hcdcza19
         JJa/Kj7kywfn5q3KWeo8dMNqnjx7PoYLsLqinoFnNQtWF0gQ9vM2VovA3D5ZThi5BfKR
         0NQQ==
X-Gm-Message-State: AHYfb5g3Lm6WyEGSz/qFED4LBRe85VmcZhjD8lv2tVq95YWgakENFnTQ
        jsvUsgqBaunPwsfb
X-Received: by 10.46.80.4 with SMTP id e4mr7773782ljb.63.1502729307544;
        Mon, 14 Aug 2017 09:48:27 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.78])
        by smtp.gmail.com with ESMTPSA id o85sm1569749lfb.9.2017.08.14.09.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2017 09:48:25 -0700 (PDT)
Subject: Re: [PATCH 37/38] irqchip: mips-gic: Use cpumask_first_and() in
 gic_set_affinity()
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-38-paul.burton@imgtec.com>
 <8af291b4-2cdc-d9aa-88a3-a6c3af856bb4@cogentembedded.com>
 <2303810.q0vlmmS52X@np-p-burton>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8fa63739-ff57-394d-11b1-9eb314659183@cogentembedded.com>
Date:   Mon, 14 Aug 2017 19:48:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2303810.q0vlmmS52X@np-p-burton>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59568
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

On 08/14/2017 07:18 PM, Paul Burton wrote:

>> On 8/13/2017 7:36 AM, Paul Burton wrote:
>>> Currently in gic_set_affinity() we calculate a temporary cpumask holding
>>> the intersection of the provided cpumask & the CPUs that are online,
>>> then we call cpumask_first twice on it to find the first such CPU. Since
>>> we don't need to temporary cpumask for anything else & we only care
>>
>>      s/to/the/?
> 
> Indeed - nice to know someone is reading a 38 patch series :)

    I can't say I've read all of them, only the smaller ones... :-)

> I'll fix up but leave submitting a v2 until someone asks me to.

    It's OK.

> Thanks,
>      Paul
> 
>>
>>> about the first CPU that's both online & in the provided cpumask, we can
>>> instead use cpumask_first_and to find that CPU & drop the temporary
>>> mask.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: linux-mips@linux-mips.org
>>
>> [...]

MBR, Sergei
