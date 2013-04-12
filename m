Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 09:19:52 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:35773 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816859Ab3DLHTq0DYr0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 09:19:46 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id B448422EEF;
        Fri, 12 Apr 2013 15:19:35 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h8qKohP+y-WY; Fri, 12 Apr 2013 15:19:19 +0800 (CST)
Received: from mail.lemote.com (localhost [127.0.0.1])
        (Authenticated sender: chenhc@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id AAF2122D4E;
        Fri, 12 Apr 2013 15:19:18 +0800 (CST)
Received: from 172.16.2.208
        (SquirrelMail authenticated user chenhc)
        by mail.lemote.com with HTTP;
        Fri, 12 Apr 2013 15:19:19 +0800
Message-ID: <f7d8c68416aadfcebe234fa4d6741f0f.squirrel@mail.lemote.com>
In-Reply-To: <5166ED66.7020307@realitydiluted.com>
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com>
    <1359527106-22879-4-git-send-email-chenhc@lemote.com>
    <5166ED66.7020307@realitydiluted.com>
Date:   Fri, 12 Apr 2013 15:19:19 +0800
Subject: Re: [PATCH V9 03/13] MIPS: Loongson: Introduce and use
 cpu_has_coherent_cache feature
From:   chenhc@lemote.com
To:     "Steven J. Hill" <sjhill@realitydiluted.com>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Fuxin Zhang" <zhangfx@lemote.com>,
        "Zhangjin Wu" <wuzhangjin@gmail.com>,
        "Hongliang Tao" <taohl@lemote.com>, "Hua Yan" <yanh@lemote.com>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36084
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

Hi, Steven,

Maybe you are misunderstand Loongson-3's "hardware-maintained cache".
Loongson-3's hardware maintain the cache coherency between multi-cores
(also maintain coherency between CPU-core and DMA), but Loongson-3 can
*still* has cache alias (Cache alias in Loongson is sovled by 16K
PageSize).

Meanwhile, I know why you misunderstand, because my code is like this:


static inline void local_r4k___flush_cache_all(void * args)
        if (cpu_has_coherent_cache)
                return;

This implies that Loongson-3 has no cache alias, but in fact this is wrong
if Loongson has configured PageSize < 16K.

I think I should make my code in all flush functions like this:

static inline void local_r4k___flush_cache_all(void * args)
        if (cpu_has_coherent_cache && !cpu_has_dc_aliases)
                return;

Am I right?

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 01/30/2013 12:24 AM, Huacai Chen wrote:
>> Loongson-3 maintains cache coherency by hardware. So we introduce a cpu
>> feature named cpu_has_coherent_cache and use it to modify MIPS's cache
>> flushing functions.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com> Signed-off-by: Hongliang
>> Tao
>> <taohl@lemote.com> Signed-off-by: Hua Yan <yanh@lemote.com> ---
>> arch/mips/include/asm/cacheflush.h                 |    6 +++++
>> arch/mips/include/asm/cpu-features.h               |    3 ++
>> .../asm/mach-loongson/cpu-feature-overrides.h      |    6 +++++
>> arch/mips/mm/c-r4k.c                               |   21
>> ++++++++++++++++++- 4 files changed, 34 insertions(+), 2 deletions(-)
>>
> Hello.
>
> This patch masks the problem that you are not properly probing your L1
> caches
> to start with. For some reason in 'probe_pcache()' you reach the default
> case
> where the primary data cache is marked as having aliases. If your CPU
> truly is
> HW coherent with no aliases, then MIPS_CACHE_ALIASES should never get set.
> Fixing this would eliminate the 'arch/mips/include/asm/cacheflush.h' and
> 'arch/mips/mm/c-r4k.c' changes completely. There is no need to add more
> CPU
> feature bits for this single platform, thus changes to 'cpu-features.h'
> and
> 'cpu-features-overrides.h' will not be accepted.
>
> Also, please do not copy the <linux-kernel@vger.kernel.org> mailing list
> unless your patch touches files outside of 'arch/mips' in order to cut
> down
> traffic on an already busy list. Thanks.
>
> Steve
> - -----
> <sjhill@mips.com>
> <Steven.Hill@imgtec.com>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlFm7WAACgkQgyK5H2Ic36eHuwCeKZjp1+arkoheEpeuzjJkQskN
> /7MAnig14A03hWxRvfqDOMbMFKXpZBO8
> =HRPU
> -----END PGP SIGNATURE-----
>
