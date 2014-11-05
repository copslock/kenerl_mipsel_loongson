Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 21:37:05 +0100 (CET)
Received: from mail-qc0-f178.google.com ([209.85.216.178]:60185 "EHLO
        mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012612AbaKEUhDE6zAj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Nov 2014 21:37:03 +0100
Received: by mail-qc0-f178.google.com with SMTP id b13so1433777qcw.9
        for <multiple recipients>; Wed, 05 Nov 2014 12:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ABC1JwBuirksxWcccQPgpdZN6fNaI/22N2U95nXZZi8=;
        b=hueFvZig1gHoqqu0awqG3zxTzouCnHZFa5z1VMmQaxQQibHtfmIMIkwlVpOorO7HjM
         QX3CTbp6JctYxs/QxgozeQt9EogjdZmrypq/vIL4KVjpRPG27BqgYgrg3+/ujjZwgjtS
         RwWF/bdOHE2j2UH+kO6ffnyijOMMmuZA3fYcdFNwrvJFOV9be30Njai++nbvIZSnorxd
         jN+MKcTgU8PDZmu4w0Th9vThPs6/XHcUes31rbl9AsjpKwson5WCxQxdJ5/6Z+xeW2a/
         mPF9mq8a2gnqnT9K4uKw2MHRQuZluGMcjze8J4ZjTSn5hhdv31FCSHelKygVp4T0LThH
         doWw==
X-Received: by 10.140.102.169 with SMTP id w38mr86804763qge.95.1415219816011;
 Wed, 05 Nov 2014 12:36:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 5 Nov 2014 12:36:34 -0800 (PST)
In-Reply-To: <1404831204-30659-8-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org> <1404831204-30659-8-git-send-email-jogo@openwrt.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 5 Nov 2014 12:36:34 -0800
Message-ID: <CAJiQ=7ArNiqSRo3cDsWH+pE_9C3B8DiKUWwKYV+ajwY1+JdXXQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] MIPS: BCM63XX: remove !RUNTIME_DETECT in cpu-feature-overrides
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Jul 8, 2014 at 7:53 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> All three SoCs have in common they have a BMIPS32/BMIPS3300 CPU, so
> we can replace this as no SoC with BMIPS4350 support enabled.
>
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
> index e9c408e..bc1167d 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/cpu-feature-overrides.h
> @@ -24,7 +24,7 @@
>  #define cpu_has_smartmips              0
>  #define cpu_has_vtag_icache            0
>
> -#if !defined(BCMCPU_RUNTIME_DETECT) && (defined(CONFIG_BCM63XX_CPU_6348) || defined(CONFIG_BCM63XX_CPU_6345) || defined(CONFIG_BCM63XX_CPU_6338))
> +#if !defined(CONFIG_SYS_HAS_CPU_BMIPS4350)
>  #define cpu_has_dc_aliases             0
>  #endif

Note that BCM6318 uses a 40nm BMIPS3300 with a 32kB D$.  I haven't
actually booted one of these myself but I would assume the way size is
either 16kB or 8kB.

I'm seeing another issue with the generic cpu_has_dc_aliases
implementation (cpu_data[0].dcache.flags & MIPS_CACHE_ALIASES).  The
HIGHMEM check in paging_init() runs before cpu_cache_init(), so
cpu_data[0].dcache.flags is still 0 and cpu_has_dc_aliases will never
be true at this point unless it was defined at compile time.

There seem to be some other problems with the way the HIGHMEM check is
handled, and I'm tempted to just move it after cpu_cache_init() and
make it a fatal error condition.  Then it can be removed entirely when
imgtec finalizes the "cache aliases + HIGHMEM" patch series.

Any opinions?
