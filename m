Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2018 16:30:59 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991532AbeJWOa4f3-oK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Oct 2018 16:30:56 +0200
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D870207DD
        for <linux-mips@linux-mips.org>; Tue, 23 Oct 2018 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540305048;
        bh=6xM7crWbxD95UwlDwb7/RoC0rAz+CQAX/M7qwA8yr0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nyJ4vHS1JiOoxLM7yURdbebRpz4JE6ABHKTO/cCf8xkk4XHo1iGg0NwZevkWURTb0
         +UZa0+houUYOE0i2pgVAKhCqdhuB2nkOYMWDLVco/4j8p4YCC4h8y4n5o9XUn2Zqg/
         y7tOg96x5JwIixHrd0J2d/oidrnEt3q6/sUc/p6E=
Received: by mail-qt1-f176.google.com with SMTP id q40-v6so1709408qte.0
        for <linux-mips@linux-mips.org>; Tue, 23 Oct 2018 07:30:48 -0700 (PDT)
X-Gm-Message-State: ABuFfogG9Rim+I+HHDhBlRm7pdRP8+xbrjCZjJejHSfgrczRCWnI2aqW
        SAACdoVmHrS7FQTvVQWaIIgQwuce89aOEFp+rg==
X-Google-Smtp-Source: ACcGV63jeCJDhIZNqn0I0FgsM6E84jjdrLHFwigRvrZenWI/ANsBR4fhiJMAd58RZ3JVG0zm8u/8aZtWOqcPWgm9zxw=
X-Received: by 2002:ac8:2d33:: with SMTP id n48-v6mr46236217qta.38.1540305047647;
 Tue, 23 Oct 2018 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181022224213.GA25145@bogus> <mhng-08dbc241-46e4-411b-ba13-32435abde7ad@palmer-si-x1c4>
In-Reply-To: <mhng-08dbc241-46e4-411b-ba13-32435abde7ad@palmer-si-x1c4>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 23 Oct 2018 09:30:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKA6_saB7Ak=BZqSth6KAZ1g2srF5BsOQRGdE2+rmcR8w@mail.gmail.com>
Message-ID: <CAL_JsqKA6_saB7Ak=BZqSth6KAZ1g2srF5BsOQRGdE2+rmcR8w@mail.gmail.com>
Subject: Re: [PATCH v2] OF: Handle CMDLINE when /chosen node is not present
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66907
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

On Mon, Oct 22, 2018 at 5:55 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 22 Oct 2018 15:42:13 PDT (-0700), robh@kernel.org wrote:
> > On Mon, Oct 15, 2018 at 05:20:10PM +0300, Nick Kossifidis wrote:
> >> The /chosen node is optional so we should handle CMDLINE regardless
> >> the presence of /chosen/bootargs. Move handling of CMDLINE in
> >> early_init_dt_scan() instead.
> >
> > I looked at this a while back. I'm not sure this behavior can be changed
> > without breaking some MIPS platforms that could be relying on the
> > current behavior. But trying to make sense of the MIPS code is a
> > challenge and they have some other issues in this area.
> >
> > Can't this be fixed by making /chosen manditory? I'd expect ultimately
> > you are always going to need it.
> >
> > I'd rather not resort to making this per arch. There's also some effort
> > to consolidate cmd line handling[1].
>
> I'd rather make /chosen mandatory on RISC-V than to have per-arch handling, as
> like you've said there's already too much duplication.  That said, it does seem
> like a bug to me because the behavior seems somewhat arbitrary -- an empty
> /chosen node causing the built-in command-line argument handling to go off the
> rails just smells so buggy.

Yes. Probably need to do some archaeology on this code to figure out
some of the expectations.

> If that's the case, could we at least have something like
> "CONFIG_OF_CHOSEN_IS_MANDATORY" that provides a warning when there is no
> /chosen node and is set on architecture where the spec mandates /chosen?

I'd be okay to make it a warning unconditionally. At least then we can
find the cases that deviate and either fix them or understand their
expectations.

Rob
