Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 05:21:00 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:65086 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903452Ab2HPDUx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 05:20:53 +0200
Received: by lbbgf7 with SMTP id gf7so1154164lbb.36
        for <multiple recipients>; Wed, 15 Aug 2012 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j0hOu4EFLgmQxh3JJQahGGWmOgDhDy4VUM17KU//HtQ=;
        b=oYD5efcr5426uhGiSlb4Zhpb8xWOYtFCwcmsAu16ixQ3Rv6m0yCIwvYM/3Dh0nGUMU
         eVBz6Y9Ck7JY4U5xQZM7B0f4nzUvvKhb0BOg5AcBUCWALAvroyAWvEcIRUW6geVeiMJN
         0l58nsEHbyf17bRG0ADL1KCasaOjfmCOBkE7DQRXHDGZ2S+9SdOieyFV+Z/FT1cnRdwL
         xu95xc87RrMRNdKHc3/qjz5U1OAjLc+/U9usWH8/Kzls9uJaped08KbdW/gxgc4tSpGc
         gAoCFRILQLGsd5wZvqHwaS0+afm0/4vPH+cH6Qhnwt7HmHDxrsAtQT4CsBc8bYcKii1q
         vFzw==
MIME-Version: 1.0
Received: by 10.152.105.51 with SMTP id gj19mr17819504lab.38.1345087247707;
 Wed, 15 Aug 2012 20:20:47 -0700 (PDT)
Received: by 10.152.111.138 with HTTP; Wed, 15 Aug 2012 20:20:47 -0700 (PDT)
In-Reply-To: <CAEdQ38EW_N2Qcquyvn5UxfEc8978i4=zQE_5H65PXahQPOOEuw@mail.gmail.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <1344677543-22591-14-git-send-email-chenhc@lemote.com>
        <CAEdQ38EW_N2Qcquyvn5UxfEc8978i4=zQE_5H65PXahQPOOEuw@mail.gmail.com>
Date:   Thu, 16 Aug 2012 11:20:47 +0800
Message-ID: <CAAhV-H7dRNiZmPDnjn-qh7GPt0kW0x1tq7GiG-reyR+xTQE41g@mail.gmail.com>
Subject: Re: [PATCH V5 13/18] drm: Define SAREA_MAX for Loongson (PageSize = 16KB).
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34189
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

On Thu, Aug 16, 2012 at 9:58 AM, Matt Turner <mattst88@gmail.com> wrote:
> On Sat, Aug 11, 2012 at 2:32 AM, Huacai Chen <chenhuacai@gmail.com> wrote:
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>  include/drm/drm_sarea.h |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
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
>>  #elif defined(__ia64__)
>>  #define SAREA_MAX                       0x10000U       /* 64kB */
>>  #else
>> --
>> 1.7.7.3
>
> SAREA is a DRI-1 concept. The Radeon drivers you're using is DRI-2, so
> what do you need this for? All the DRI-1 drivers have been removed
> from Mesa, so I think the answer is nothing.

This patch will be drop, thank you.
