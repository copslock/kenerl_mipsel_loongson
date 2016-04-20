Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 08:18:28 +0200 (CEST)
Received: from mail-io0-f195.google.com ([209.85.223.195]:34530 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026390AbcDTGS0y-MJ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 08:18:26 +0200
Received: by mail-io0-f195.google.com with SMTP id z133so5649206iod.1
        for <linux-mips@linux-mips.org>; Tue, 19 Apr 2016 23:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=g7I/jl72m2YpqLP1pfPS+mPqEvTo2Kr+ldH6+q91cjE=;
        b=xAgk5saZcGhwgEYcl2SnCawwFpz2mKJLhewXhWHd4+zNJ+opGpStxqR+Ei6fHd2CtR
         ZQCRuzmiFkUN+1F8qO8Q05o2+s7HiqwoBESOPuMYwRjMxZltALHGOjGkbgAvcUuLoHec
         XA9+vWZNzF0Z85K0qi1/lSnLrcY+kqAdkFT3tnAK4gcBGrHcp/z7sRAi9wZ1IUovlc8V
         70I1YibJNAU//WID4MH4GDd0ifXOsuDlW8fYDvIXAS/2mIBRCiptjmg+C/6m1ajARXTo
         SpizzlQvAWzZ1Vj6Q57X8lBz3xhc02V/vZGyopj5A0Dl/Vv1LeXLIHmfAJW+JjikOihR
         25QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=g7I/jl72m2YpqLP1pfPS+mPqEvTo2Kr+ldH6+q91cjE=;
        b=AZyP7q+gDLwbDQ97474TDLUE1n04m31hbsRttbal+5zZ8Ewk3H2sUugWBYoHEx0uzN
         upwu8Xovp38XKrWCGyw1vU5u0ecKFn98E70FOpgQbQ9iwpYAoRxzDS+8Qukf2OWRHW8o
         G+ftji6wlCKyV+quw3YvIY5n5TBO8G7SikV9ZANjgiwEO/iDjGNWJxQOj79cadZjWlkl
         Gv5bOSwZvDUrwLI86vkrcoqctSPr/EXJwHljOKHygoNgmhZGRJzzMe26Z7drtzSM/XC1
         TSrnJ8PQ0JrX6GmwI6vTySK+OseUcWbNbyp8TF4S19gTd5GHNftn9qyPo8LL/VQzD56J
         SgYw==
X-Gm-Message-State: AOPr4FWcTPo2lKrqW1dtnCTv+o9zOWSECa/JJOYYPiYXuR3wECxHN+kMBTlzs7YTYfiF7M0H1saHtDCqPe3upQ==
MIME-Version: 1.0
X-Received: by 10.107.163.4 with SMTP id m4mr7408260ioe.79.1461133101043; Tue,
 19 Apr 2016 23:18:21 -0700 (PDT)
Received: by 10.36.56.198 with HTTP; Tue, 19 Apr 2016 23:18:20 -0700 (PDT)
In-Reply-To: <CADnq5_OyS_pCu-4wW5uFpnr5kvqkHK5uPdmBKgHHmfZ-dOdXvw@mail.gmail.com>
References: <1461064751-17873-1-git-send-email-chenhc@lemote.com>
        <CADnq5_OyS_pCu-4wW5uFpnr5kvqkHK5uPdmBKgHHmfZ-dOdXvw@mail.gmail.com>
Date:   Wed, 20 Apr 2016 14:18:20 +0800
X-Google-Sender-Auth: JxxIt-mKUsClR-Th7zNYe965Tik
Message-ID: <CAAhV-H6EsxUhuXAAYBhun-S4+tM-xhWxKbXD4Jg0btK4sLfjGg@mail.gmail.com>
Subject: Re: [PATCH] drm: Loongson-3 doesn't fully support wc memory
From:   Huacai Chen <chenhc@lemote.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        stable <stable@vger.kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Cc: stable@vger.kernel.org

On Tue, Apr 19, 2016 at 9:53 PM, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Tue, Apr 19, 2016 at 7:19 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>> ---
>>  include/drm/drm_cache.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
>> index 461a055..cebecff 100644
>> --- a/include/drm/drm_cache.h
>> +++ b/include/drm/drm_cache.h
>> @@ -39,6 +39,8 @@ static inline bool drm_arch_can_wc_memory(void)
>>  {
>>  #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
>>         return false;
>> +#elif defined(CONFIG_MIPS) && defined(CONFIG_CPU_LOONGSON3)
>> +       return false;
>>  #else
>>         return true;
>>  #endif
>> --
>> 2.7.0
>>
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
