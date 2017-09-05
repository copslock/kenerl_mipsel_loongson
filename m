Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 16:42:20 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994923AbdIEOmJoqVLV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Sep 2017 16:42:09 +0200
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5C021E94
        for <linux-mips@linux-mips.org>; Tue,  5 Sep 2017 14:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5C021E94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qt0-f180.google.com with SMTP id k2so12486398qte.2
        for <linux-mips@linux-mips.org>; Tue, 05 Sep 2017 07:42:06 -0700 (PDT)
X-Gm-Message-State: AHPjjUh9z3jaNTf/8ztwR+C4de7DgHbjxgaWXA6PRrYhj4YkgVy+y+zW
        aYL3PuoCxHgfc6V47nf5ugbVl1w9fw==
X-Google-Smtp-Source: ADKCNb54HFh8p9wvZ6VoyC5TnMTZKr/Q7Zz1W595tegxbAoxypWn6AlJ2OOEu3qdNsA/U7I/gF/63lf/u0n6k8MpVN8=
X-Received: by 10.237.60.154 with SMTP id d26mr5940180qtf.87.1504622525928;
 Tue, 05 Sep 2017 07:42:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.153.1 with HTTP; Tue, 5 Sep 2017 07:41:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Sep 2017 09:41:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKKePqec7OER=MMSTDXTGiYiuM5jE0QWg_nUvmvQoEw4g@mail.gmail.com>
Message-ID: <CAL_JsqKKePqec7OER=MMSTDXTGiYiuM5jE0QWg_nUvmvQoEw4g@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for "chosen@0"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
        Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Sat, Sep 2, 2017 at 3:43 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> Since, according to a recent devicetree ML posting by Rob Herring,
> the node "/chosen@0" is most likely for real Open Firmware and does
> not apply to DTSpec, remove all remaining tests and references for
> that node, of which there are very few left:
>
>  arch/microblaze/kernel/prom.c | 3 +--
>  arch/mips/generic/yamon-dt.c  | 4 ----
>  arch/powerpc/boot/oflib.c     | 7 ++-----
>  drivers/of/base.c             | 2 --
>  drivers/of/fdt.c              | 5 +----
>  5 files changed, 4 insertions(+), 17 deletions(-)
>
> This should be innocuous as, in all of the three arch/ files above,
> there is a test for "chosen" immediately before the test for
> "chosen@0", so nothing should change.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
>
> ---
>
>   if this patch is premature, then just ignore it, thanks.
>
> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
> index 68f0999..c81bfd7 100644
> --- a/arch/microblaze/kernel/prom.c
> +++ b/arch/microblaze/kernel/prom.c
> @@ -53,8 +53,7 @@ static int __init early_init_dt_scan_chosen_serial(unsigned long node,
>
>         pr_debug("%s: depth: %d, uname: %s\n", __func__, depth, uname);
>
> -       if (depth == 1 && (strcmp(uname, "chosen") == 0 ||
> -                               strcmp(uname, "chosen@0") == 0)) {
> +       if (depth == 1 && (strcmp(uname, "chosen") == 0)) {

I'd really hoped to remove early_init_dt_scan_chosen_serial()
altogether. It may now be just a matter of adding the compatible
strings to the uartlite earlycon.

Rob
