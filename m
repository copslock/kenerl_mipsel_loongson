Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2013 19:09:26 +0100 (CET)
Received: from mail-vb0-f52.google.com ([209.85.212.52]:50330 "EHLO
        mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832221Ab3APSJZY102B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2013 19:09:25 +0100
Received: by mail-vb0-f52.google.com with SMTP id ez10so1616777vbb.39
        for <multiple recipients>; Wed, 16 Jan 2013 10:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=0tg41AYSFwqmwHoR+CxX34iOehT9wdxGIcF1UqVPI5c=;
        b=szvLsjEVRYhvp88Pr/Xj5NQ7iNGXi1c6fVv+9bZA76KZnDpzyT7SbZowsr3TKl3Xdt
         sQpC4wfZBrwlRAJWigvuOupI2eX4LDEF+rjHkvBQZGwEr94QF8YCtdNpwFhVo+HNTuVo
         9oEiUipk4S9+t1H1reu+J4Teklo7V0kZlIjpyAJScIgDx5dhoVqX7yZuHSqgCvnZbUSL
         IaO63dbE3V4+tocXovC5Chvn0w8qDfNe+WxdRt7n6V/7J0SXVGUrheOvge71l/xUOkEF
         4pu0WHYiEWu/cwwHYdXpeolWIvLstpkAcwavNSzdFwHQ8aWVBNiIKAC/64K0rtLVOeb0
         fR4A==
MIME-Version: 1.0
X-Received: by 10.52.177.103 with SMTP id cp7mr1954660vdc.113.1358359758799;
 Wed, 16 Jan 2013 10:09:18 -0800 (PST)
Received: by 10.58.227.168 with HTTP; Wed, 16 Jan 2013 10:09:18 -0800 (PST)
In-Reply-To: <20130116105757.GB26569@linux-mips.org>
References: <1358200025-15994-1-git-send-email-dinggnu@gmail.com>
        <20130116105757.GB26569@linux-mips.org>
Date:   Wed, 16 Jan 2013 19:09:18 +0100
X-Google-Sender-Auth: TymiDhQJkbc45H2Muq9g2Nngzto
Message-ID: <CAMuHMdUiJN_1anMHiEAvtjGTTREKdds361bqppu=7uJK4nxJyw@mail.gmail.com>
Subject: Re: [PATCH] mpis: cavium-octeon/executive/cvmx-l2c.c: fix
 uninitialized variable
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Cong Ding <dinggnu@gmail.com>, Jim Quinlan <jim2101024@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jan 16, 2013 at 11:57 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jan 14, 2013 at 10:47:03PM +0100, Cong Ding wrote:
>
>> the variable dummy is used without initialization.
>
> Interesting - I wonder how you found this one.  My compiler (gcc 4.7)
> doesn't warn about this one.

Probably older gcc does.

> Nor does gcc notice that the whole summing up business is wasted efford.
>
> So here's my counter proposal.  It works because ptr is a volatile pointer
> so the compiler will always dereference it even if the returned value is
> not being used.  The resulting code is a bit smaller.
>
>   Ralf
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>  arch/mips/cavium-octeon/executive/cvmx-l2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-l2c.c b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
> index 9f883bf..ec3e059 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-l2c.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-l2c.c
> @@ -286,7 +286,7 @@ uint64_t cvmx_l2c_read_perf(uint32_t counter)
>  static void fault_in(uint64_t addr, int len)
>  {
>         volatile char *ptr;
> -       volatile char dummy;
> +
>         /*
>          * Adjust addr and length so we get all cache lines even for
>          * small ranges spanning two cache lines.
> @@ -300,7 +300,7 @@ static void fault_in(uint64_t addr, int len)
>          */
>         CVMX_DCACHE_INVALIDATE;
>         while (len > 0) {
> -               dummy += *ptr;
> +               *ptr;

Alternatively, to make clearer what's intended:
  - drop the "volatile" from "ptr" and from the cast when assigning to it,
  - use "ACCESS_ONCE(*ptr)" instead of "*ptr".

>                 len -= CVMX_CACHE_LINE_SIZE;
>                 ptr += CVMX_CACHE_LINE_SIZE;
>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
