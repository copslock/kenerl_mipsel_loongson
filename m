Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 12:47:04 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:40475 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2FSKq5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 12:46:57 +0200
Received: by lbbgg6 with SMTP id gg6so5868859lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 03:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=x62d37sToMV/blnQxZZ1ofQiX8Mk7K1ZwN2+AGwh2EU=;
        b=pzRtZSlHJJLXIIPTbMoMKjKCeNAfoP0k4N/JxmFTLC6V8cggG424rF/D0nL15ayOK0
         ajIRBivxrkcJ1w4p7815qZfwXyhGS4g5FCZHEs9xI+g0yXnMUPOMxHfVEiDCetYtQ3aq
         Z0vbLUWnWHdWLqJfL2RDj66/tUNdv8mF5Qb/FGSqZf8uobgDRWM5UroUokeJ8QXB8buD
         iQTSuXc4urKg+XjXbrn6NQvSwwLcaqaywHCrvl6C8k/GMrGHcl4zLCRSVr8gkJJYqX60
         5K2HLlCcJh9h8LGjnqzlsUusLTli9Gdb/y8ZUgxBmOUIi2b4wKPMYRc6re8iKa/IUU4k
         SM6A==
MIME-Version: 1.0
Received: by 10.152.124.141 with SMTP id mi13mr17787273lab.50.1340102811973;
 Tue, 19 Jun 2012 03:46:51 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 03:46:51 -0700 (PDT)
In-Reply-To: <1340092605.5442.0.camel@thor.local>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-13-git-send-email-chenhc@lemote.com>
        <1340092605.5442.0.camel@thor.local>
Date:   Tue, 19 Jun 2012 18:46:51 +0800
Message-ID: <CAAhV-H61zN42kntGrVWwfXPpi42WgTcBcxj-Ym1=cfPaaXmd9w@mail.gmail.com>
Subject: Re: [PATCH V2 12/16] drm/radeon: Make radeon card usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Zhangjin Wu <wuzhangjin@gmail.com>, Hua Yan <yanh@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        dri-devel@lists.freedesktop.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Thanks, I'll follow your suggestions.

On Tue, Jun 19, 2012 at 3:56 PM, Michel Dänzer <michel@daenzer.net> wrote:
> On Die, 2012-06-19 at 14:50 +0800, Huacai Chen wrote:
>> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>>    doesn't support DMA address above 4GB).
>> 2, Read vga bios offered by system firmware.
>> 3, Handle io prot correctly for MIPS.
>> 4, Don't use swiotlb on Loongson machines (when use swiotlb, GPU reset
>>    occurs at resume from suspend).
>
> Sounds like this should be split up into smaller patches.
>
>
>> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
>> index ee5389d..1d1a858 100644
>> --- a/include/drm/drm_sarea.h
>> +++ b/include/drm/drm_sarea.h
>> @@ -37,6 +37,8 @@
>>  /* SAREA area needs to be at least a page */
>>  #if defined(__alpha__)
>>  #define SAREA_MAX                       0x2000U
>> +#elif defined(__mips__)
>> +#define SAREA_MAX                       0x4000U
>>  #elif defined(__ia64__)
>>  #define SAREA_MAX                       0x10000U     /* 64kB */
>>  #else
>
> Also, this change doesn't seem to be accounted for in the commit log.
>
>
> --
> Earthling Michel Dänzer           |                   http://www.amd.com
> Libre software enthusiast         |          Debian, X and DRI developer
