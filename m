Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 20:08:31 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:49916 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815753Ab3LUTI30e5e3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Dec 2013 20:08:29 +0100
Received: from mail-qa0-f52.google.com (mail-qa0-f52.google.com [209.85.216.52])
        by mail.nanl.de (Postfix) with ESMTPSA id 53683460B4
        for <linux-mips@linux-mips.org>; Sat, 21 Dec 2013 19:07:11 +0000 (UTC)
Received: by mail-qa0-f52.google.com with SMTP id cm18so3809933qab.4
        for <linux-mips@linux-mips.org>; Sat, 21 Dec 2013 11:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RgD/LzQPknc19hjdOP/2ZxnQMF8HfT2p2x1wSoJdDBA=;
        b=aicKK2qn/fK3co/A7jXbo4XCD61ZYGBMndZL5ymYZCBLyQGNcwq1XIr+L2E5jas3CS
         K9CkXJ3oYKa1thmZrnHRQ5z1pWIT5he+bFjaEZwUAtttEW65uIrH3tMX+j+ZDzdWlfKF
         fL/gX1vACflqRtSBiFB8orWIiF2y/pXpfBO6/4cT5/DfnPImf/Ga4FjAgDpwpRt/bn+N
         wzbiIzR352tC7HQZebk420J4lQkeEjUmDxCJqsvQMtJWRVT5I3xgVFL0Hf7NWyKG7JGo
         r6/+ebwX4lW3hjAmJpV5rzBc1+9hgzKd95uR6HklWWvoTS8vDbGoVvutsl20ns7Q0IFb
         jXWg==
X-Received: by 10.229.219.5 with SMTP id hs5mr26935119qcb.9.1387652903686;
 Sat, 21 Dec 2013 11:08:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.27.117 with HTTP; Sat, 21 Dec 2013 11:08:03 -0800 (PST)
In-Reply-To: <1380530280-6467-1-git-send-email-markos.chandras@imgtec.com>
References: <1380530280-6467-1-git-send-email-markos.chandras@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 21 Dec 2013 20:08:03 +0100
Message-ID: <CAOiHx=kBLNAKhfa_6iPC5CsqYcNBCpaLPTw2ihNr8EEYdCkWsg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: bcm63xx: cpu: Replace BUG() with panic()
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On Mon, Sep 30, 2013 at 10:38 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> BUG() can be a noop if CONFIG_BUG is not selected,
> leading to the following build problem on a randconfig:
>
> arch/mips/bcm63xx/cpu.c: In function 'detect_cpu_clock':
> arch/mips/bcm63xx/cpu.c:254:1: error: control reaches end of
> non-void function [-Werror=return-type]
>
> We fix this problem by replacing BUG() with panic() since it's
> best to handle the case of an unknown board instead of silently
> returning a random clock frequency.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

The patch seems mostly okay, although there tend to be quite a few
places treating BUG() as unreachable() - for my part BUG() not being
unreachable for BUG=n is a bug, but that's a different story ;) One
nitpick though ...

> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree
> ---
>  arch/mips/bcm63xx/cpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> index b713cd6..88c57cc 100644
> --- a/arch/mips/bcm63xx/cpu.c
> +++ b/arch/mips/bcm63xx/cpu.c
> @@ -123,7 +123,9 @@ unsigned int bcm63xx_get_memory_size(void)
>
>  static unsigned int detect_cpu_clock(void)
>  {
> -       switch (bcm63xx_get_cpu_id()) {
> +       u16 cpu_id = bcm63xx_get_cpu_id();
> +
> +       switch (cpu_id) {
>         case BCM3368_CPU_ID:
>                 return 300000000;
>
> @@ -249,7 +251,7 @@ static unsigned int detect_cpu_clock(void)
>         }
>
>         default:
> -               BUG();
> +               panic("Failed to detect clock for CPU with id=%04d\n", cpu_id);

The cpu_id is in hex, so it needs to be %04x - not that it matters
much since early printk won't work yet at this stage anyway IIRC.

with this fixed (maybe John is nice enough to replace the one character ;),

Acked-by: Jonas Gorski <jogo@openwrt.org>
