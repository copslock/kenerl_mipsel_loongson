Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 22:05:36 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:49672 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816877AbaCVVFeWoGol (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2014 22:05:34 +0100
Received: by mail-ob0-f169.google.com with SMTP id va2so4123355obc.0
        for <linux-mips@linux-mips.org>; Sat, 22 Mar 2014 14:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zUPMgP/JalcFL1bkfWuzC2+n4Znl+KnvbrwVBkqWA1w=;
        b=SvE31WO6q1Ng0IexQXMP3U6zfiG+a++Sa3rAh48ebpNcdKA8TBBITbdk0scQUY8Xar
         rNQLCdHfxzLDCi2ozAsGB1CiKoQR1f7rdctsRhAqZBue7ZTDBy3d/QakEKd0hmDnFhbv
         88TRAhsRE33vpeps7Wd5W7YyBfFN12x6AR44PnX7PV9z0ffjByjMLaMaJtf0ndsO5ePN
         OyIYsYQwVaw55nR5h56u84mjrWHrBXK7DfRmZB8ZeAO2uNqT29OGpnKxMPiJqCVXs78n
         waRkAs7+xYmLL4lzxCZw3gexZ+Kwp7vKknpA3B52IQgQs79bCg31lMJQRiQzTqX/kGbq
         coQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zUPMgP/JalcFL1bkfWuzC2+n4Znl+KnvbrwVBkqWA1w=;
        b=YXahOX2o2BB3wFeQCsj0oaojfK9RW79eqbYKK2WhVSiAFkjO454t83b/FA7Bh0+JKs
         NzQoMphJIhZstOsnHAWrfZTwm/OlMi8AYGFQpz911TbfiAyj3tLdPZuV7FwswsD3Sz+5
         1lZIpP90rFYk6iTZ3lNGT+ZUEnLyK9VbB+4s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zUPMgP/JalcFL1bkfWuzC2+n4Znl+KnvbrwVBkqWA1w=;
        b=QaHtNksWBd1qiXw9jm4p0v6MVdrw5fPq+NzQpDOFMS90cmU39JN3HoeoiJb10/Jyii
         t+vLjA9eJKlSw+gVeWiDih7jDdEQ9QjZWvbZ23qiET5gsaznyE9qYpI8FPmd3EqoYfeF
         jAVPRQwqpBAr3jCFXr5x7fVReAYWScABQ+RLp3us63m4JxUBx5JZf6ZTAkcoslkN+G5d
         zAvEcDudmT6/Gjn9YUL/35RSpl3tJa51neruFb24CGa7xkHFUg42UQ6e2Rp/du7VM3M0
         6nYNK6CmIv+CZzIToTINR3P7qL4dx2yOlfthWp622siIkgWJm3tKOxTAbaAYMmojwAUy
         eb2A==
X-Gm-Message-State: ALoCoQk1Ab9+/EV3ePVy9af94k0AYMVzDkfTP62iAnj0EREObqy747crcck6xm53QAgY2RpSF5zMC5EzjJcKKeIDzaTrNBglpjaZ5S4JurwfdROh7Qitl3fg+AHXssBL1PGLuBBA7YiGi+/jZA5CJ4GqHsJNm+/3WRf2Qm6Ua1ffyUKRq7jgq5zAKbX6Pn9ujBzA3+m+EnhyBCr51alvR0IseXcT7cd4vw==
MIME-Version: 1.0
X-Received: by 10.182.225.194 with SMTP id rm2mr2817620obc.49.1395522327815;
 Sat, 22 Mar 2014 14:05:27 -0700 (PDT)
Received: by 10.182.226.163 with HTTP; Sat, 22 Mar 2014 14:05:27 -0700 (PDT)
In-Reply-To: <532E0699.2080303@cogentembedded.com>
References: <20140322154720.GA23863@www.outflux.net>
        <532E0486.3010702@cogentembedded.com>
        <532E053C.90007@cogentembedded.com>
        <532E0699.2080303@cogentembedded.com>
Date:   Sat, 22 Mar 2014 15:05:27 -0600
X-Google-Sender-Auth: VsJmgytbawE24L6TWbLsoxO26v4
Message-ID: <CAGXu5jLUueSb2u_Ki+nEL1CaBzyZyT1+7rhCB-0ZGB0nD5cT4g@mail.gmail.com>
Subject: Re: [PATCH] mips: export icache_flush_range
From:   Kees Cook <keescook@chromium.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Sat, Mar 22, 2014 at 3:54 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 03/23/2014 12:48 AM, Sergei Shtylyov wrote:
>
>>>> The lkdtm module performs tests against executable memory ranges, so
>>>> it needs to flush the icache for proper behaviors. Other architectures
>>>> already export this, so do the same for MIPS.
>
>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>> This is currently untested! I'm building a MIPS cross-compiler now...
>>>> If someone can validate this fixes the build when lkdtm is a module,
>>>> that would be appreciated. :)
>>>> ---
>>>>   arch/mips/mm/cache.c |    1 +
>>>>   1 file changed, 1 insertion(+)
>
>
>>>> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
>>>> index fde7e56d13fe..b3f1df13d9f6 100644
>>>> --- a/arch/mips/mm/cache.c
>>>> +++ b/arch/mips/mm/cache.c
>>>> @@ -38,6 +38,7 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr,
>>>> int
>>>> size);
>>>>   void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
>>>>
>>>>   EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
>>>> +EXPORT_SYMBOL_GPL(flush_icache_range);
>
>
>>>     Have you run this thru scripts/checkpatch.pl? It would have told you
>>> that
>>> an export should immediately follow the corresponding function body,
>>> AFAIK.
>
>
>>     Hm, it doesn't now but definitely used to...
>
>
>    Decided to check Documentation/CodingStyle, and it still codifies this:
>
> In source files, separate functions with one blank line.  If the function is
> exported, the EXPORT* macro for it should follow immediately after the
> closing
> function brace line.  E.g.:
>
> int system_is_up(void)
> {
>         return system_state == SYSTEM_RUNNING;
> }
> EXPORT_SYMBOL(system_is_up);
>
> WBR, Sergei

Yup, thanks. I know the style, but it seemed from the source file that
the style was to declare the function pointers in bulk, and then
explicitly export them in the next section, so I continued that style.
For example:

void (*flush_cache_sigtramp)(unsigned long addr);
void (*local_flush_data_cache_page)(void * addr);
void (*flush_data_cache_page)(unsigned long addr);
void (*flush_icache_all)(void);

EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
EXPORT_SYMBOL(flush_data_cache_page);
EXPORT_SYMBOL(flush_icache_all);

Regardless, I'm happy to stick it in the middle of the function
pointers if that's preferred.

-Kees

-- 
Kees Cook
Chrome OS Security
