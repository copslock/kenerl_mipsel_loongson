Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 23:29:13 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:26572 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823043Ab3I3V3Kf09yh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Sep 2013 23:29:10 +0200
Message-ID: <5249ED1E.4050106@imgtec.com>
Date:   Mon, 30 Sep 2013 14:29:02 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: 74K/1074K support
References: <20130925052715.GB473@linux-mips.org>
In-Reply-To: <20130925052715.GB473@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
X-SEF-Processed: 7_3_0_01192__2013_09_30_22_29_05
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38079
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

On 09/24/2013 10:27 PM, Ralf Baechle wrote:
> Commit 006a851b10a395955c153a145ad8241494d43688 adds 74K support in c-r4k.c:
>
> +static inline void alias_74k_erratum(struct cpuinfo_mips *c)
> +{
> +       /*
> +        * Early versions of the 74K do not update the cache tags on a
> +        * vtag miss/ptag hit which can occur in the case of KSEG0/KUSEG
> +        * aliases. In this case it is better to treat the cache as always
> +        * having aliases.
> +        */
> +       if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> +               c->dcache.flags |= MIPS_CACHE_VTAG;
> +       if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> +               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +       if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
> +           ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
> +               c->dcache.flags |= MIPS_CACHE_VTAG;
> +               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +       }
> +}
>
> But MIPS D-caches are never virtually tagged, so there is nothing in
> the kernel that ever tests the MIPS_CACHE_VTAG flag in a D-cache
> descriptor.
>
> Cargo cult programming at its finest?  Or was MIPS_CACHE_ALIASES what
> really was meant to be set?
>
>    Ralf

There is a problem on early versions of 74K/1074K which can be effectively cured by setting MIPS_CACHE_VTAG.
It enforces the needed cache handling.
I hope it will go away as customers replace RTL for newer versions.
  
But I prefer the patch version from Maciej W. Rozycki, it is more clear.

- Leonid.
