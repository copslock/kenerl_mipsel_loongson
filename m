Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2018 17:40:33 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeIKPk2Hn-A3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2018 17:40:28 +0200
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF9420891;
        Tue, 11 Sep 2018 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536680421;
        bh=nUdRa2GZMl/vIJ/aXz//ZUz1Z56ZGs5/inYrg4Jpmmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z7dB9g6AqF2Rh+QcRCQV6tR/bYmWjldPmKQqYoEMxEUH6DRMVws5oVR937OAOVzIN
         398Kvm38gF8t5tKptnoFJhBbmNjh5BT1ltIralrQIy2wtHYULusdFiidghY+pRcY3y
         VprQf8QksU4JQY6UpmIqM9zJkQVyzXmKQNENJPYo=
Received: by mail-qt0-f181.google.com with SMTP id n6-v6so28671157qtl.4;
        Tue, 11 Sep 2018 08:40:21 -0700 (PDT)
X-Gm-Message-State: APzg51BIw2+n33/i4OM2HkMGYetpgTJfD/Mtj7LWyJZ3dlM1MEXb7WSu
        lavr++9K5xULwhRNY8X14YieN1epp2LLG0VRvg==
X-Google-Smtp-Source: ANB0VdbI4+2Kwc4KDe+gT15iLXZI7ixWvkk3Tr9ih69wHGm7FZfAaUX1VsiXmx93SKLNypQ7Untbz/TiuQLE4FQ554Q=
X-Received: by 2002:a0c:d5d3:: with SMTP id h19-v6mr19244034qvi.218.1536680420205;
 Tue, 11 Sep 2018 08:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
In-Reply-To: <20180910150403.19476-7-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Sep 2018 10:40:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
Message-ID: <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66202
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

On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.

[...]

> @@ -1215,6 +1215,33 @@ kselftest-merge:
>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
> +# ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree := arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE

This can be true when dtstree is unset. So this line should be this
instead to fix the 0-day reported error:

ifneq ($(dtstree),)

> +
> +%.dtb : scripts_dtc
> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +
> +PHONY += dtbs dtbs_install
> +dtbs: scripts_dtc
> +       $(Q)$(MAKE) $(build)=$(dtstree)
> +
> +dtbs_install: dtbs
> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> +
> +all: dtbs
> +
> +endif
