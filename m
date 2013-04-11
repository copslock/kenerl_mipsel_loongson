Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 19:05:59 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:36515 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822682Ab3DKRF4Y-zHa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Apr 2013 19:05:56 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1UQKwU-0001LX-Kn; Thu, 11 Apr 2013 12:05:46 -0500
Message-ID: <5166ED66.7020307@realitydiluted.com>
Date:   Thu, 11 Apr 2013 12:05:42 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V9 03/13] MIPS: Loongson: Introduce and use cpu_has_coherent_cache
 feature
References: <1359527106-22879-1-git-send-email-chenhc@lemote.com> <1359527106-22879-4-git-send-email-chenhc@lemote.com>
In-Reply-To: <1359527106-22879-4-git-send-email-chenhc@lemote.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/30/2013 12:24 AM, Huacai Chen wrote:
> Loongson-3 maintains cache coherency by hardware. So we introduce a cpu 
> feature named cpu_has_coherent_cache and use it to modify MIPS's cache 
> flushing functions.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com> Signed-off-by: Hongliang Tao
> <taohl@lemote.com> Signed-off-by: Hua Yan <yanh@lemote.com> --- 
> arch/mips/include/asm/cacheflush.h                 |    6 +++++ 
> arch/mips/include/asm/cpu-features.h               |    3 ++ 
> .../asm/mach-loongson/cpu-feature-overrides.h      |    6 +++++ 
> arch/mips/mm/c-r4k.c                               |   21
> ++++++++++++++++++- 4 files changed, 34 insertions(+), 2 deletions(-)
> 
Hello.

This patch masks the problem that you are not properly probing your L1 caches
to start with. For some reason in 'probe_pcache()' you reach the default case
where the primary data cache is marked as having aliases. If your CPU truly is
HW coherent with no aliases, then MIPS_CACHE_ALIASES should never get set.
Fixing this would eliminate the 'arch/mips/include/asm/cacheflush.h' and
'arch/mips/mm/c-r4k.c' changes completely. There is no need to add more CPU
feature bits for this single platform, thus changes to 'cpu-features.h' and
'cpu-features-overrides.h' will not be accepted.

Also, please do not copy the <linux-kernel@vger.kernel.org> mailing list
unless your patch touches files outside of 'arch/mips' in order to cut down
traffic on an already busy list. Thanks.

Steve
- -----
<sjhill@mips.com>
<Steven.Hill@imgtec.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFm7WAACgkQgyK5H2Ic36eHuwCeKZjp1+arkoheEpeuzjJkQskN
/7MAnig14A03hWxRvfqDOMbMFKXpZBO8
=HRPU
-----END PGP SIGNATURE-----
