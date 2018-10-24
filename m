Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 23:07:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994573AbeJXVHMiYwYP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 23:07:12 +0200
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FDA20840
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540415225;
        bh=4f0Fe8Ps3oY6n7KWGpJz5aZusd6Mpr/caJHJJr3zdPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ye+Wau624fk4ZLG5+LXiEH+FrMFtTsCT9EOMpoqeEQidVdiMDD+nzthS9nvmlASC2
         G5sDjuRORoEl4CgstaCMaF2xR/JBHM0z0+QkveP97yRR0zWKwj6r146uYwXufIb7dX
         S02Gpg0hH5KyRLIrQ/czwevjuuUV5O6VmkDSLbLU=
Received: by mail-qt1-f173.google.com with SMTP id j46-v6so7340984qtc.9
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 14:07:05 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKnpNz9dRH2qLF9EXVP/SJZinCze/Rob0CzQymsDiTmVw2IKND0
        84JRqLk4GIWTU/HjjW7plYYbRsJfUa/REEIK5Q==
X-Google-Smtp-Source: AJdET5eGdSi6U72LuJVh7YpQy4hqb5UeE5oe+Ws3STrIXfGifdZpOBGCd0Ryh50ZCOVi3G6DKMrkCqHaID7MTR0lP58=
X-Received: by 2002:ac8:2d1d:: with SMTP id n29-v6mr1783988qta.38.1540415224742;
 Wed, 24 Oct 2018 14:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181022224213.GA25145@bogus> <mhng-08dbc241-46e4-411b-ba13-32435abde7ad@palmer-si-x1c4>
 <CAL_JsqKA6_saB7Ak=BZqSth6KAZ1g2srF5BsOQRGdE2+rmcR8w@mail.gmail.com> <8e420b9dee0f246fda8e018532737b1a@mailhost.ics.forth.gr>
In-Reply-To: <8e420b9dee0f246fda8e018532737b1a@mailhost.ics.forth.gr>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Oct 2018 16:06:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+CgxWbCMz_qwLbMJS3fYwKyCMBGVS501-5ShXywyDAXA@mail.gmail.com>
Message-ID: <CAL_Jsq+CgxWbCMz_qwLbMJS3fYwKyCMBGVS501-5ShXywyDAXA@mail.gmail.com>
Subject: Re: [PATCH v2] OF: Handle CMDLINE when /chosen node is not present
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66928
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

On Wed, Oct 24, 2018 at 8:33 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Στις 2018-10-23 17:30, Rob Herring έγραψε:
> > On Mon, Oct 22, 2018 at 5:55 PM Palmer Dabbelt <palmer@sifive.com>
> > wrote:
> >>
> >> On Mon, 22 Oct 2018 15:42:13 PDT (-0700), robh@kernel.org wrote:
> >> > On Mon, Oct 15, 2018 at 05:20:10PM +0300, Nick Kossifidis wrote:
> >> >> The /chosen node is optional so we should handle CMDLINE regardless
> >> >> the presence of /chosen/bootargs. Move handling of CMDLINE in
> >> >> early_init_dt_scan() instead.
> >> >
> >> > I looked at this a while back. I'm not sure this behavior can be changed
> >> > without breaking some MIPS platforms that could be relying on the
> >> > current behavior. But trying to make sense of the MIPS code is a
> >> > challenge and they have some other issues in this area.
> >> >
> >> > Can't this be fixed by making /chosen manditory? I'd expect ultimately
> >> > you are always going to need it.
> >> >
> >> > I'd rather not resort to making this per arch. There's also some effort
> >> > to consolidate cmd line handling[1].
> >>
> >> I'd rather make /chosen mandatory on RISC-V than to have per-arch
> >> handling, as
> >> like you've said there's already too much duplication.  That said, it
> >> does seem
> >> like a bug to me because the behavior seems somewhat arbitrary -- an
> >> empty
> >> /chosen node causing the built-in command-line argument handling to go
> >> off the
> >> rails just smells so buggy.
> >
> > Yes. Probably need to do some archaeology on this code to figure out
> > some of the expectations.
> >
> >> If that's the case, could we at least have something like
> >> "CONFIG_OF_CHOSEN_IS_MANDATORY" that provides a warning when there is
> >> no
> >> /chosen node and is set on architecture where the spec mandates
> >> /chosen?
> >
> > I'd be okay to make it a warning unconditionally. At least then we can
> > find the cases that deviate and either fix them or understand their
> > expectations.
> >
> > Rob
>
> I don't think we can make /chosen node mandatory since it's not
> specified as such
> by the spec
> (https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2).

We can change the spec. :) Maybe only to recommended for the DT spec,
but you should also clearly define the boot interface to the kernel on
risc-v or suffer the pain later. And in that you can make it required.

Regardless, what I was really getting at is effectively it will become
required anyways. Pretty much every setup needs kernel cmdline. Yes it
can be built-in, but soon as it is your kernel works on a single
platform. Want to support an initrd? Need chosen. crashdump? Need
chosen. Want a console? Need chosen.

> No matter what we say from the kernel side, the device tree provider is
> not expected
> to always provide the /chosen mode. Also device tree is not the only
> provider of
> a command line, we might get a command line from different places
> per-arch (e.g. atags
> on arm) or through EFI/ACPI/kexec as well. That's why my initial
> approach for RISC-V
> was on the arch-specific code.

An arch is free to choose its own way, yes. You'd be crazy to invent
something new though.

ATAGS is legacy. If we do have ATAGS with DT, we fix it up in one
place (the decompressor) by moving all the parameters to DT. Then it
is either ATAGS or DT boot and one code path from there. MIPS does not
do that and is a mess. AFAICT, there can be 3 sources of parameters
(bootloader(legacy), DT, or kernel) and those have an undefined way
they are combined (other than what the code happens to do). And on top
of that the DT can be built-in, external, or both.

ACPI and EFI don't deal with the command line (as least on arm and
arm64). The kernel command line is always passed via DT. DT is the
kernel boot interface even for arm64 ACPI systems.

Rob


>
> We shouldn't try to handle the built-in CMDLINE on each of the possible
> command line
> providers and if we do we should at least make sure we don't depend on
> the presence
> of a provided command line (which is the issue in this case).
>
> I believe the best approach is to consolidate all the different CMDLINE
> approaches
> for the various archs / providers and clean up the mess instead of
> re-implementing
> the same thing again and again. I saw the patch you mentioned and it's a
> start.
> I'll look more into it and try to come up with a similar one.
>
> Nick
