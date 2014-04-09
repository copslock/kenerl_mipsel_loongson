Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 21:43:42 +0200 (CEST)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:63299 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822185AbaDITnjybg5s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Apr 2014 21:43:39 +0200
Received: by mail-oa0-f50.google.com with SMTP id i7so3351173oag.9
        for <linux-mips@linux-mips.org>; Wed, 09 Apr 2014 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ab/c5QxEjRj+ePEYqIXRJXsmUa62ICh6T5upRwaZ4GY=;
        b=ZimopP0rRqjTqxZyVM3tYDYYPQKsAHxRpUtmYVx8Lx4nwVYHhzbhnXecOrr+MritkO
         lUbBPhayXk2pIEdB20UOSAuONeCM3BCxTYyU6IZPmbRcGrIwgBYHNVPbW+pGvFC6GTcA
         g7b8ZqMto4xvRfd4Myffnd5DwvagfvewiaoG5A6xs1bvn6orFZda2nTCo/6zXpXKtgT4
         gljg+RkrUo1mO0F6THeL/l/Sehir0YIKDD/QeEBCPyePilFlvVN8Sx83+i24z28D/aIv
         ppxpjBUQUkOtEw5TYJThtgFumjjj4YlO9IOPPHW/TlTrN1yp+n/OpN9AewrDONaALnRZ
         l78g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ab/c5QxEjRj+ePEYqIXRJXsmUa62ICh6T5upRwaZ4GY=;
        b=kvFh9p5y/7RoJxJ2sDhdashhKqH5EkO7AqQFjtMDnhyAgb3evnDKIfRWogCqkV2xna
         zrauXybTgerzLv+ih9vVj7pK1DyL62+aWgIxp6ZOaCSlRPoRXZ2LxNxilUzEqyuZJYLN
         g7prOO19zoEgmMCN7LYrPHX2X5SJa9IHgkzBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ab/c5QxEjRj+ePEYqIXRJXsmUa62ICh6T5upRwaZ4GY=;
        b=Tif8jzS6z9r5YLtuoXXOnh1a0G0Nub2LelAHvsaLWNy+7Wkp/5emYDEapAXZvYYooz
         S4CEVyum5Q2aSo+/HWLEg7Fwsp67jmGi7S3C9t5CJepRAi2AssBES+hMUaPom7+53n1k
         YCAsyDgMahMB41T1T6a0nPIG4pTgeefFFADK2d9LQGvo2oxBx99iatKeUnlgjq3tr+iI
         Hxa4Ryti0h/l/6qPtqWmi2C5FhSOUtRUNZvJ1P2ozK6l0ltWWIQiTxDp27A0VmauCngR
         E7sOOhOca2456+6V4M4xZoC3dUo+Wdk/bEIjstifCa6mQ7oYr64k4sB3M46AJX+NUjVl
         TeQQ==
X-Gm-Message-State: ALoCoQnSM0ZP8wqLYnOiQDx/VvSSIdkHDDLX5DsNrC0roliiOd5YtvztSHjSE6LTz9/wqAfw4bu/lj8we5NUCXaTm+OjJcrmvj1q9YLP8fnyYgwUPECawKr2IzcL31Ca/04OOSC8X997T/Xn22uc6tSsGznMFpYj87+n00zeFvSgWMRNAv54V1Kt5Fc2iXZ7YOWAq4f4JXkqNbuS/faicY1uzFrLyViAOQ==
MIME-Version: 1.0
X-Received: by 10.182.66.202 with SMTP id h10mr10356439obt.38.1397072613460;
 Wed, 09 Apr 2014 12:43:33 -0700 (PDT)
Received: by 10.182.226.163 with HTTP; Wed, 9 Apr 2014 12:43:33 -0700 (PDT)
In-Reply-To: <5342AEEF.4080503@windriver.com>
References: <20140322154720.GA23863@www.outflux.net>
        <CAGXu5jL+o4dG+ruUDh-+5LY=iD0veWaimBUq3cJBtuCiNbYt1A@mail.gmail.com>
        <5342AEEF.4080503@windriver.com>
Date:   Wed, 9 Apr 2014 12:43:33 -0700
X-Google-Sender-Auth: OQtpwDo_FzRgr3gIoleDQKyTDVE
Message-ID: <CAGXu5jL=p3xRxAxaobqXsXda7V9bU5fnKUB-vHL4Pm-UVWPs=Q@mail.gmail.com>
Subject: Re: [PATCH] mips: export icache_flush_range
From:   Kees Cook <keescook@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sanjay Lal <sanjayl@kymasys.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39748
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

On Mon, Apr 7, 2014 at 6:58 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On 14-03-22 03:05 PM, Kees Cook wrote:
>> On Sat, Mar 22, 2014 at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
>>> The lkdtm module performs tests against executable memory ranges, so
>>> it needs to flush the icache for proper behaviors. Other architectures
>>> already export this, so do the same for MIPS.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>> This is currently untested! I'm building a MIPS cross-compiler now...
>>> If someone can validate this fixes the build when lkdtm is a module,
>>> that would be appreciated. :)
>>
>> Okay, now tested. I reproduced the failure and this patch fixes it. :)
>
> Just checking if this happened to fall through the cracks.
> The most recent (Apr4) linux-next build for mips still fails
> with this error.
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/10877159/

Ralf, you acked this offlist, but someone needs to pull this into the tree?

On Mar 24, Ralf Baechle wrote:
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks!

-Kees

>
> Paul.
> --
>
>>
>> -Kees
>>
>>> ---
>>>  arch/mips/mm/cache.c |    1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
>>> index fde7e56d13fe..b3f1df13d9f6 100644
>>> --- a/arch/mips/mm/cache.c
>>> +++ b/arch/mips/mm/cache.c
>>> @@ -38,6 +38,7 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr, int size);
>>>  void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
>>>
>>>  EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
>>> +EXPORT_SYMBOL_GPL(flush_icache_range);
>>>
>>>  /* MIPS specific cache operations */
>>>  void (*flush_cache_sigtramp)(unsigned long addr);
>>> --
>>> 1.7.9.5
>>>
>>>
>>> --
>>> Kees Cook
>>> Chrome OS Security
>>
>>
>>



-- 
Kees Cook
Chrome OS Security
