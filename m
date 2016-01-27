Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 20:17:13 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36124 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011776AbcA0TRLe9iGv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 20:17:11 +0100
Received: by mail-ob0-f169.google.com with SMTP id ba1so15878983obb.3
        for <linux-mips@linux-mips.org>; Wed, 27 Jan 2016 11:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tKmu8q8Cz/netD4cpnF2F6Hh8A9FYPDWq5Q68Mh+Ano=;
        b=cSB0dT1b+209C6wYCMAVUoEpNobhK7u7QMxdPrd+0LBjceoL8j9jBdFtKfdKKPSnxm
         W5PUp8i/iFzuisrN2Gf/VmF6ZW3b/RbJt95fIMGdQ5xi/fR3xIjcOAtlyhw9BofVpNLC
         F6ykUocoQ8QPaA1weZRw5KwaqXMS4AYaKtP37NLYT1rj2kcXO2EBrUwJQ0dxnSA1uDdN
         OsFu3hxQ0J/xKMh9PAhGqMH4KM+02+O0wOFmIY+8LdOEyS/DG8i+fVif//feJ9k7mDZj
         GgeZWRYQSTSWw2WW+F+aGX4N3T7QYQ6T3rEFIf3vUv8PRymPHdTObk37wyd/ckJNCbhL
         tIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tKmu8q8Cz/netD4cpnF2F6Hh8A9FYPDWq5Q68Mh+Ano=;
        b=NEcRu6gJpsSu7zHNGWqBPS3dsJsxCkuSk0kRA5HWw0JRMcohkd9jBG1ZKWoHU5rAt5
         7Bj5UL3rP/RlLz3kLYpfymm4ED+f/HAyma+tAeo5Plig0NSOICbyZI5zk8XbwsHNmaMj
         tDukaW/LMCgXEakzaJi723VqrPYmtxSI76yAlL2RCzGRi+YPijwfQ2gHxDPzx0zBclzv
         uhpXzU2bduF53RCB2v6yZKPgTI+Wo2KgQFrX9sE8ERE/Ne+WOB5cpt4N+Ev54mTZSyS7
         UnaUZMBY4ufHa54vl0jaoRyBt4O1okC+qMpPPoOBoQ37AxbEBSXY16bI8z/rG1z5bDLT
         lx7Q==
X-Gm-Message-State: AG10YOQEcUId/0s38zm7T/+jBv4IVnz1PzQfs+Tg8dgDGgRrnKxFATld0A443K87LCM3OvXu2O0cY7wUgxkGaQ==
MIME-Version: 1.0
X-Received: by 10.60.226.203 with SMTP id ru11mr24290738oec.36.1453922225625;
 Wed, 27 Jan 2016 11:17:05 -0800 (PST)
Received: by 10.182.73.193 with HTTP; Wed, 27 Jan 2016 11:17:05 -0800 (PST)
In-Reply-To: <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
        <64480084bc652d5fa91bf5cd4be979e2f1e4cf11.1453759363.git.luto@kernel.org>
Date:   Wed, 27 Jan 2016 11:17:05 -0800
Message-ID: <CAKdAkRQm6ADz5aCYAFxXcoGZ2zNFwTUXjMzZdNj-D2-YrYQtrg@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] input: Redefine INPUT_COMPAT_TEST as in_compat_syscall()
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-parisc@vger.kernel.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

Hi Andy,

On Mon, Jan 25, 2016 at 2:24 PM, Andy Lutomirski <luto@kernel.org> wrote:
> The input compat code should work like all other compat code: for
> 32-bit syscalls, use the 32-bit ABI and for 64-bit syscalls, use the
> 64-bit ABI.  We have a helper for that (in_compat_syscall()): just
> use it.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  drivers/input/input-compat.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/input/input-compat.h b/drivers/input/input-compat.h
> index 148f66fe3205..0f25878d5fa2 100644
> --- a/drivers/input/input-compat.h
> +++ b/drivers/input/input-compat.h
> @@ -17,17 +17,7 @@
>
>  #ifdef CONFIG_COMPAT
>
> -/* Note to the author of this code: did it ever occur to
> -   you why the ifdefs are needed? Think about it again. -AK */
> -#if defined(CONFIG_X86_64) || defined(CONFIG_TILE)
> -#  define INPUT_COMPAT_TEST is_compat_task()
> -#elif defined(CONFIG_S390)
> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_31BIT)
> -#elif defined(CONFIG_MIPS)
> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT_ADDR)
> -#else
> -#  define INPUT_COMPAT_TEST test_thread_flag(TIF_32BIT)
> -#endif
> +#define INPUT_COMPAT_TEST in_compat_syscall()
>


If we now have function that works on all arches I'd prefer if we used
it directly instead of continuing using INPUT_COMPAT_TEST.

Thanks.

-- 
Dmitry
