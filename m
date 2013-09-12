Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 16:57:49 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:61199 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817315Ab3ILO5q7M0GU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Sep 2013 16:57:46 +0200
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     Paul Burton <Paul.Burton@imgtec.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
Thread-Topic: [PATCH] MIPS: Fix errata for some 1074K cores.
Thread-Index: AQHOrynF0sZcYE/SBUSzvM9JZ+mYmJnCTuwA///jmEE=
Date:   Thu, 12 Sep 2013 14:57:37 +0000
Message-ID: <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com>
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>,<52318BC6.7030903@imgtec.com>
In-Reply-To: <52318BC6.7030903@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2013_09_12_15_57_41
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Treat it as is.

It is a dirty laundry of HW engineers and you may need to communicate with them or read Errata docs on CPU.

If it is about a way how it is written - ask Steven, initially it was in mainland probe code but he think it should be a separate function. I just corrected him, pointing that erratas on 74K and 1074K are different. But because he insist on having the same CPU_74K for both, so...

- Leonid.

PS. If you think the code is bad, please be specific beyond broad blame.


Paul Burton <Paul.Burton@imgtec.com> wrote:


Could you expand on that please? What is errata E16, what are "some
problems" and how does this fix those problems? The commit message is
somewhat lacking...

Paul

On 11/09/13 21:01, Steven J. Hill wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Fixes errata E16 for some problems on 1074K cores.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>   arch/mips/mm/c-r4k.c |   12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index f749f68..8d3ed32 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -786,12 +786,12 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
>        * aliases. In this case it is better to treat the cache as always
>        * having aliases.
>        */
> -     if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> -             c->dcache.flags |= MIPS_CACHE_VTAG;
> -     if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> -             write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> -     if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
> -         ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
> +     if ((c->processor_id & 0xff00) != PRID_IMP_1074K) {
> +             if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> +                     c->dcache.flags |= MIPS_CACHE_VTAG;
> +             if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> +                     write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +     } else if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0)) {
>               c->dcache.flags |= MIPS_CACHE_VTAG;
>               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
>       }
