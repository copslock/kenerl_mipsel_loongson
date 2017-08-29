Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 09:43:08 +0200 (CEST)
Received: from mail-wr0-x235.google.com ([IPv6:2a00:1450:400c:c0c::235]:34312
        "EHLO mail-wr0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994908AbdH2Hm7XOAc5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 09:42:59 +0200
Received: by mail-wr0-x235.google.com with SMTP id z91so7587506wrc.1
        for <linux-mips@linux-mips.org>; Tue, 29 Aug 2017 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rjY/Prx4zR6N4L/k4DBbOnkwvkmSlAJz6RMqW2/hwjU=;
        b=Tul5JHTRVIoALJ7FqoqZO86piMGWeQVlwTu4mc6PyFdjmSns2XOscpR2n8C2NnMRZg
         fvpe540+0YMCaD5cHYDYboCLadAAo7KBvH2xMvDujvU4WeziWFsJDpTNIhq76M/Pgw2e
         +d43AIqQpsZ4e+W9Is7AwSjHO0l1jwKbOFSns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rjY/Prx4zR6N4L/k4DBbOnkwvkmSlAJz6RMqW2/hwjU=;
        b=OlIx5bw4oA0jbkiI2VeOr2xBt0GTI9vB3+USE81IFXWqmk06wm/WgePT2MUl0ZqTes
         quhtUleDyIwUWa8+7wD8MUrcxdSbgy1yyguf0lS0AO1wppRgUKMnkuAOFfTT8BeaYA4m
         ZGxSiOAze+5KS2nvYWwPEpyCQ2Nc3kvkHpPzPVvX6HIDXuBvOAZD0o115MQX+ajvEtaV
         +Oo77lgEW0MtPi3yYUxjBtDPCoKfyB38ktdtMph3FeTNVhkcEDmKpUB6tcMKGaMUV4wB
         q8ipZ+kuNf2EA88952UhDEWQnzGlTswZvYFOZpsf4qCBgtKPNR5gkngRVL2tgBmrJwtu
         PPBQ==
X-Gm-Message-State: AHYfb5hbmG2SZLUJxenVeauzG4dXdQnS+1UkaO5DCNtpHZFFfE8/y6jQ
        nZRDSDkAE0XNNdIAI0YQOw==
X-Received: by 10.223.130.184 with SMTP id 53mr1597508wrc.221.1503992573605;
        Tue, 29 Aug 2017 00:42:53 -0700 (PDT)
Received: from [192.168.0.74] (135-224-190-109.dsl.ovh.fr. [109.190.224.135])
        by smtp.googlemail.com with ESMTPSA id m188sm2376092wme.1.2017.08.29.00.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Aug 2017 00:42:53 -0700 (PDT)
Subject: Re: [PATCH 13/19] MIPS: Unify checks for sibling CPUs
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     linux-mips@linux-mips.org
References: <20170813024943.14989-1-paul.burton@imgtec.com>
 <20170813024943.14989-14-paul.burton@imgtec.com>
 <20170826122749.GI7433@linux-mips.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c850dd48-abde-4268-0896-98561a0c657b@linaro.org>
Date:   Tue, 29 Aug 2017 09:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170826122749.GI7433@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 26/08/2017 14:27, Ralf Baechle wrote:
> Hi,
> 
> Paul didn't cc the other maintainers.  Tglx gave me his Ack on IRC so I
> now only still need one of a drivers/cpuidle/ maintainer.
> 
> Thanks,
> 
>   Ralf
> 
> On Sat, Aug 12, 2017 at 07:49:37PM -0700, Paul Burton wrote:
>> Date:   Sat, 12 Aug 2017 19:49:37 -0700
>> From: Paul Burton <paul.burton@imgtec.com>
>> To: linux-mips@linux-mips.org
>> CC: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
>> Subject: [PATCH 13/19] MIPS: Unify checks for sibling CPUs
>> Content-Type: text/plain
>>
>> Up until now we have open-coded checks for whether CPUs are siblings,
>> with slight variations on whether we consider the package ID or not.
>>
>> This will only get more complex when we introduce cluster support, so in
>> preparation for that this patch introduces a cpus_are_siblings()
>> function which can be used to check whether or not 2 CPUs are siblings
>> in a consistent manner.
>>
>> By checking globalnumber with the VP ID masked out this also has the
>> neat side effect of being ready for multi-cluster systems already.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
