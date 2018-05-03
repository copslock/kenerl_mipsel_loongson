Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 00:31:42 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:35430
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990465AbeECWbf3RHOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2018 00:31:35 +0200
Received: by mail-qt0-x243.google.com with SMTP id f5-v6so11735871qth.2;
        Thu, 03 May 2018 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=m5rk9vTTU41Y0eqMpzeo3pDtUzA9CWj3UspDYvs6hRQ=;
        b=J7vVvaRP6ug1hU9ppWII8OAWQItSPYg/AC3ftmX/eMobHWKkQzjmtIrCpPNgo+CbN0
         NCpmeTpKW0xx2dDQ2Q02zNRht0hRs7YhZDwKTb2Mk6v5JTfdZ4zxgpu9szFRhJ/h9ItJ
         a8OmNd4rydCSOVWl/3XXaYu1dH5+S9lyToZo+X/a0hofb91No7vTTsOtQiH6/1FMAUR1
         A9FxVkm5eiGCHdNUtZfU6u2R6qxZjdwQebTbP8X3WwMRZaiCfQWqYCPqM0Ww+wz6/o5M
         vGWtmIZe+Qw9EagYI90FLw6FraweMa2Tm2HVRNVLfKugdmHyI9iFvMbf4iv/v0F0WHS/
         sVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=m5rk9vTTU41Y0eqMpzeo3pDtUzA9CWj3UspDYvs6hRQ=;
        b=aNrwZzp4fVYmvHtDbp4pVwFGBy7oBw3QU599b2CTYIPuzhWZGEUBBn08SdOHVSD/8n
         ySEcBLP/pKnL5ThtmTV82EiL54GxhEuwkqlFRnNEXxwCNvIqO9vpVXUcVNa1m10fOHog
         jeszWx0xvnEpqIAZipNWnv0JFvF5juDPCFrlUq6TT/aC5/ZMAzVtOmBqlyT7uOHKKick
         6jOrHWG7W9gaxFYWb4QjJXFACNP308Pul6tMYjMMvXDmV1IjoX8znGCdsinHWqmVSamj
         7TxTIDNF3tbFs0n2gcVVAVaKKvXR8sS8xQ1PDnjDNAz9Tkd/OV9KtV2V2qrrxRBOnyaZ
         zl1g==
X-Gm-Message-State: ALQs6tA5Q1SpucsMNL8bOHx0fdvBjsocxbgc7mVhzquN1NEC4Aw5g6ne
        k6v6XZLuZfJKhDR+Ht+GO/HkBPFvJc1hsXse1WU=
X-Google-Smtp-Source: AB8JxZrOjKPgiVbQN5BN3iWX7B+ZBRnNiW74v49MC/AnCtB1rDfspA3iB4k6Q8zo9F/saVucxiN78dScw0XLyRVNjj8=
X-Received: by 2002:ac8:64a:: with SMTP id e10-v6mr11290866qth.163.1525386689288;
 Thu, 03 May 2018 15:31:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.3 with HTTP; Thu, 3 May 2018 15:31:28 -0700 (PDT)
In-Reply-To: <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
 <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 3 May 2018 18:31:28 -0400
X-Google-Sender-Auth: W2IBI1tieqmu0oFICq5qaf0B3Cg
Message-ID: <CAK8P3a3TJ-5+22_CSYjdtL3pXEVHC7t_KzaOX6PG4X_1R1bMxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, May 2, 2018 at 10:53 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index 17d4cd2..c4e2a1a 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -27,8 +27,8 @@
>   *     rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
>   *                     to be set.  Used by RTC sync-up.
>   */
> -extern int rtc_mips_set_time(unsigned long);
> -extern int rtc_mips_set_mmss(unsigned long);
> +extern int rtc_mips_set_time(time64_t);
> +extern int rtc_mips_set_mmss(time64_t);
>

I think these should just get removed, and each implementation replaced
with a direct update_persistent_clock64() function.

> -int update_persistent_clock(struct timespec now)
> +int update_persistent_clock64(struct timespec64 now)
>  {
>         return rtc_mips_set_mmss(now.tv_sec);
>  }

And this one also removed

> @@ -69,7 +69,7 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>                 if (rtctmp < 0)
>                         rtctmp = 0;
>         }
> -       r = proc_dointvec(table, write, buffer, lenp, ppos);
> +       r = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>         if (r)
>                 return r;
>
> @@ -224,7 +224,7 @@ int proc_lasat_prid(struct ctl_table *table, int write,
>         {
>                 .procname       = "rtc",
>                 .data           = &rtctmp,
> -               .maxlen         = sizeof(int),
> +               .maxlen         = sizeof(time64_t),
>                 .mode           = 0644,
>                 .proc_handler   = proc_dolasatrtc,
>         },

Something seems wrong here: time64_t is not the same as 'unsigned long',
and the 'rtctmp' variable is still 'unsigned int'. Not sure what the right fix
would be (we don't seem to have a sysctl helper for s64), but the change
here makes it worse.

       Arnd
