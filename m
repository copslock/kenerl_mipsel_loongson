Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 02:43:18 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:56978 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903484Ab2HPAnM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 02:43:12 +0200
Received: by lagu2 with SMTP id u2so1088653lag.36
        for <multiple recipients>; Wed, 15 Aug 2012 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9nFHNpM33JVy9QgNk+CCd+5Wku2cC3K3rtWjjuSIdpM=;
        b=BG1HHSss9zowIHpLlKqGXeA8ns7kBJb3gqZ9LrjssyisXkE1fHQHwTBRhOh2ZAyMK4
         DGR8N5A137Y5hYblEudScdMONJch/ZHol1jnZFQrKAX4zO0dj5VSl90OPc7rhEK5+EqY
         XUEZckal36BHCERzZdtBTAQMKfkn8SsOBbihE9lSnNZ6/tMbgPdqEzO9o582txWD6rDn
         iZIaNuW4jPU26jbCpkAuuRWYQ+J/c2dPHf32J8a/zB5y7oaMjOz7WOdJTZRT006mFIK8
         BwHeEOE7eJULliUjbkQjifhVxywxZPOBgjzB929T6ArrcTjPcfaSZgSqKRIt4MG+Q6TT
         fbSw==
MIME-Version: 1.0
Received: by 10.152.144.134 with SMTP id sm6mr21227352lab.5.1345077786659;
 Wed, 15 Aug 2012 17:43:06 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Wed, 15 Aug 2012 17:43:06 -0700 (PDT)
In-Reply-To: <20120815213126.GC15844@linux-mips.org>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <1344677543-22591-14-git-send-email-chenhc@lemote.com>
        <20120815213126.GC15844@linux-mips.org>
Date:   Thu, 16 Aug 2012 08:43:06 +0800
Message-ID: <CAAhV-H46joC7baQ44-O0sqWM4iWVFf=DE2DoAVn1+bxro+7pNg@mail.gmail.com>
Subject: Re: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize = 16KB).
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34186
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

On Thu, Aug 16, 2012 at 5:31 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Aug 11, 2012 at 05:32:18PM +0800, Huacai Chen wrote:
>
>> Subject: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize = 16KB).
>
> But your code doesn't define it just for Loongsson as the log message claims
> but rather for all MIPS.
>
>> diff --git a/include/drm/drm_sarea.h b/include/drm/drm_sarea.h
>> index ee5389d..1d1a858 100644
>> --- a/include/drm/drm_sarea.h
>> +++ b/include/drm/drm_sarea.h
>> @@ -37,6 +37,8 @@
>>  /* SAREA area needs to be at least a page */
>>  #if defined(__alpha__)
>>  #define SAREA_MAX                       0x2000U
>> +#elif defined(__mips__)
>> +#define SAREA_MAX                       0x4000U
>
> How about replacing this whole #ifdef mess with something like:
>
> #include <linux/kernel.h>
> #include <asm/page.h>
>
> /* Intel 830M driver needs at least 8k SAREA */
> #define SAREA_MAX       max(PAGE_SIZE, 0x2000U)
>
> MIPS also uses 64K page size and your patch as posted would break with 64k
> pages.
Yes, I think this is better. Thank you.
>
>   Ralf
