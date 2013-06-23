Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Jun 2013 04:10:56 +0200 (CEST)
Received: from mail-bk0-f48.google.com ([209.85.214.48]:50826 "EHLO
        mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816022Ab3FWCKoI6TC2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Jun 2013 04:10:44 +0200
Received: by mail-bk0-f48.google.com with SMTP id jf17so3840844bkc.35
        for <multiple recipients>; Sat, 22 Jun 2013 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=LtWX69fzYlZmfTd7u/GUSMFoIgSBc8DZpjus5B22yAE=;
        b=1KMxZTSrKXKMDMc0BL1uneGsv9wiCJUgHRxhWP5bfwopnI+muu28f6Xd/4zjKqv1Fe
         1PUp7d+bwvC/nWERqITP2Ir+Cf6zAM/ozeZ/DZwm7Af77HqOPLMJROEsDpOcwz+mDMDG
         pBHJOsmrOFR2DKcHl62ZyjbZhoCvRXS0M0Qd5a5cUBGEWCcCQ2DUwS4N67qYcewsH9RK
         V7rwb6oKOhwqWqSrNAvIBTXRIW3FhGUDkiRB7dEJa9+aRrGE2hUVQQYxo5dYHbEi4BCv
         8w1R6RQspMz4wvZfO6Ze8OXuNvsUmflkFD52WuLO750MdtLLULbB/Q+0jQ6pAyolgPBH
         c/1Q==
MIME-Version: 1.0
X-Received: by 10.205.9.129 with SMTP id ow1mr2416833bkb.43.1371953438499;
 Sat, 22 Jun 2013 19:10:38 -0700 (PDT)
Received: by 10.204.30.210 with HTTP; Sat, 22 Jun 2013 19:10:38 -0700 (PDT)
In-Reply-To: <CAAhV-H6s47NUHzbEX5UKYtkei7=s08PPXCMw39_fP_SV7Hv5Vg@mail.gmail.com>
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
        <1359527106-22879-4-git-send-email-chenhc@lemote.com>
        <5166ED66.7020307@realitydiluted.com>
        <CAAhV-H6s47NUHzbEX5UKYtkei7=s08PPXCMw39_fP_SV7Hv5Vg@mail.gmail.com>
Date:   Sun, 23 Jun 2013 10:10:38 +0800
X-Google-Sender-Auth: uTpdPRj06dw2TkFxSltPB5V4xis
Message-ID: <CAAhV-H58Y_Rd8thj8MWXGCqqGtYJekDKrO-nXYjdp3214jnQ0A@mail.gmail.com>
Subject: Re: [PATCH V9 03/13] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37104
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

Hi, Steven

Is the 3rd patch of V10 is OK to be accepted now? If so, could the
patchset of V10 be merged into 3.11?

Huacai

On Fri, Apr 12, 2013 at 11:07 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Hi, Steven,
>
> Maybe you are misunderstand Loongson-3's "hardware-maintained cache".
> Loongson-3's hardware maintain the cache coherency between multi-cores (also
> maintain coherency between CPU-core and DMA), but Loongson-3 can *still* has
> cache alias (Cache alias in Loongson is sovled by 16K PageSize).
>
> Meanwhile, I know why you misunderstand, because my code is like this:
>
>
> static inline void local_r4k___flush_cache_all(void * args)
>         if (cpu_has_coherent_cache)
>                 return;
>
> This implies that Loongson-3 has no cache alias, but in fact this is wrong
> if Loongson has configured PageSize < 16K.
>
> I think I should make my code in all flush functions like this:
>
> static inline void local_r4k___flush_cache_all(void * args)
>         if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
>                 return;
>
> Am I right?
>
>
> On Fri, Apr 12, 2013 at 1:05 AM, Steven J. Hill <sjhill@realitydiluted.com>
> wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 01/30/2013 12:24 AM, Huacai Chen wrote:
>> > Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
>> > feature named cpu_has_coherent_cache and use it to modify MIPS's cache
>> > flushing functions.
>> >
>> > Signed-off-by: Huacai Chen <chenhc@lemote.com> Signed-off-by: Hongliang
>> > Tao
>> > <taohl@lemote.com> Signed-off-by: Hua Yan <yanh@lemote.com> ---
>> > arch/mips/include/asm/cacheflush.h                 |    6 +++++
>> > arch/mips/include/asm/cpu-features.h               |    3 ++
>> > .../asm/mach-loongson/cpu-feature-overrides.h      |    6 +++++
>> > arch/mips/mm/c-r4k.c                               |   21
>> > ++++++++++++++++++- 4 files changed, 34 insertions(+), 2 deletions(-)
>> >
>> Hello.
>>
>> This patch masks the problem that you are not properly probing your L1
>> caches
>> to start with. For some reason in 'probe_pcache()' you reach the default
>> case
>> where the primary data cache is marked as having aliases. If your CPU
>> truly is
>> HW coherent with no aliases, then MIPS_CACHE_ALIASES should never get set.
>> Fixing this would eliminate the 'arch/mips/include/asm/cacheflush.h' and
>> 'arch/mips/mm/c-r4k.c' changes completely. There is no need to add more
>> CPU
>> feature bits for this single platform, thus changes to 'cpu-features.h'
>> and
>> 'cpu-features-overrides.h' will not be accepted.
>>
>> Also, please do not copy the <linux-kernel@vger.kernel.org> mailing list
>> unless your patch touches files outside of 'arch/mips' in order to cut
>> down
>> traffic on an already busy list. Thanks.
>>
>> Steve
>> - -----
>> <sjhill@mips.com>
>> <Steven.Hill@imgtec.com>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.11 (GNU/Linux)
>> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>>
>> iEYEARECAAYFAlFm7WAACgkQgyK5H2Ic36eHuwCeKZjp1+arkoheEpeuzjJkQskN
>> /7MAnig14A03hWxRvfqDOMbMFKXpZBO8
>> =HRPU
>> -----END PGP SIGNATURE-----
>>
>
