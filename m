Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 19:18:54 +0100 (CET)
Received: from mail-lf0-x22d.google.com ([IPv6:2a00:1450:4010:c07::22d]:38288
        "EHLO mail-lf0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdK1SSqQ1ypU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 19:18:46 +0100
Received: by mail-lf0-x22d.google.com with SMTP id e137so870724lfg.5
        for <linux-mips@linux-mips.org>; Tue, 28 Nov 2017 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kiJbfaquJCU5AuNBCHQDLNDUFQDBrNr3cgUeTjtau7E=;
        b=LxEfKHQGzLTh2UsfF34MrcVhAq/KrYpy16ZCWNypBbHlubuQU/sfGXLJKP1BfazEEK
         WFXQnTG3m0fXrhjQyGG0loNk3BSx3iy4MK9ogO2dt4mjtgppCIFChDbmQ1UWEMLxEfnP
         x5vW3uIUWuerJvR8kc6D5xI4denUWG13s7tBKEIEiS8eEWvb4CCRZpwl2Rkc/Q30VulI
         I4qI/Dp/cF8AxxGWGNXve4OLa9NSy5X29ChoxMb4/msGgh3uIy+3bMwSfhs7ErSiGMrC
         gNrAjKC4GWuLgi8oOINfcReq4LduL0Wgfk+ED52VxwlJm7ry9fdGc12PFD4UgNz/Pt7+
         2Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kiJbfaquJCU5AuNBCHQDLNDUFQDBrNr3cgUeTjtau7E=;
        b=dcwplqOMPVT557yy5t2RUqUF66PGVPKrVretXZvh1vPFWw8nK3s0q3VVJYXBiXpJ8A
         K8K7zj86M87JecAo+uI3fp8rmP7KZ69NN5j6J+uZOk3PuBxUY3b1yYRo9mRwfo7gJsmK
         7TMT8LOPQCOc3SBGoBHe8TcgyOA+lsr+6oWs50KxSNk3FF4kRFVQGsD7Sn5GlDT560fm
         hoxZuJaBKD2XIQz+SM+VBwNNLGIZ/XI6aYkAA6ar8cr1ZvyM5m9nUGbSNu+0OziOsO0w
         4+E74azkqIl7UuS8W3WtxJSMXe0dsgegVdhhVRMAblXLv4oZOVoJaoDn+J5/OwfAB4tT
         qz3g==
X-Gm-Message-State: AJaThX7n4CaYeYDqg5CmjBw6dy/44xdKPIg+KZvTL3K0Bv+/QKPsi4y+
        lYrFW84dhxuQKA7tRUeDo5lqBwH4t2coVwGxmWBnJA==
X-Google-Smtp-Source: AGs4zMa0nAbvXFQm2cLpg+K4WJ/JQTZqg3ua+Z5jeFpRjg4aAT0BPoo2MxDjNC92G/ZkTe/aSk0xvhFulW76f9nqIPE=
X-Received: by 10.46.16.138 with SMTP id 10mr12817ljq.115.1511893120173; Tue,
 28 Nov 2017 10:18:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.109.4 with HTTP; Tue, 28 Nov 2017 10:18:38 -0800 (PST)
In-Reply-To: <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com>
References: <CAK7LNAS1NaqPRhK6FOXN=YTMhLagpSrR2=tXn-uWZbpzr=NeoQ@mail.gmail.com>
 <20171115204231.34914-1-ndesaulniers@google.com> <CAK7LNAQNEHRapzFem3nr7=EWJPYvZby9K7vem-R99ijYNoguEg@mail.gmail.com>
 <CAK7LNASGYZfQFkM3yMRQaHLUwW5Lhp8CxHGX0bJ9sVja0f=n+A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Nov 2017 10:18:38 -0800
Message-ID: <CAKwvOdmcthyd1KbxRr54QztBcmeZ7JA=M_7N1xfmVurVOG=77w@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Set KBUILD_CFLAGS before incl. arch Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Behan Webster <behanw@converseincode.com>,
        =?UTF-8?Q?Jan=2DSimon_M=C3=B6ller?= <dl9pf@gmx.de>,
        Mark Charlebois <charlebm@gmail.com>,
        Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Chris Fries <cfries@google.com>,
        Michal Marek <mmarek@suse.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ndesaulniers@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndesaulniers@google.com
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

Hi Masahiro,

Thanks for merging Chris' patch, and sorry for taking so long to respond.

On Wed, Nov 22, 2017 at 8:24 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Linus suggests to move compiler flag testing to Kconfig.

Do you have an LKML link for context?

On Wed, Nov 15, 2017 at 6:32 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> BTW, I notice another issue.
>
> If we move clang settings before including arch Makefile,
> "ifneq ($(CROSS_COMPILE),)" comes early.
>
> Some arch Makefiles (arch/mips/Makefile, arch/blackfin/Makefile, etc.)
> set CROSS_COMPILE there if CROSS_COMPILE is not given.
>
> Then, we have a conflict between two requirements among arch.
>
> [1] arm64, powerpc use ld-option in their Makefile.
>     So, clang flags must be set before inc. arch Makefile.
> [2] mips, blackfin, etc. may set CROSS_COMPILE in their Makefile.
>     So, we want to reference CROSS_COMPILE only after inc. arch Makefile
>
> I have no idea how to solve it.
>
> At this moment, I guess clang is intended to support
> only limited architectures.
>
> It might be OK to be compromised here.

I definitely find it curious that certain arch's define CROSS_COMPILE
themselves.  The benefit is one less argument to supply at compile
time, but it assumes that the toolchain always has a certain prefix.
This makes sense to me when cross compiling, but seems odd when
compiling natively on that arch as the host and target.  Maybe those
arch's use that convention, or simply are always cross compiled for?

Taking a survey of all arch's currently in the kernel via `cd arch; ag
CROSS_COMPILE` and quickly eyeballing the result:

m68k if not set
arc if not set
openrisc for some configs (openrisc/configs/or1ksim_defconfig,
openrisc/configs/simple_smp_defconfig)
blackfin if not set
hexagon for some configs (hexagon/configs/comet_defconfig)
parisc if not set
sh if not set
xtensa if not set
score always
arm for some configs (arm/configs/lpc18xx_defconfig)
h8300 if not set
mips if not set (and explicitly emptied for some configs,
mips/configs/nlm_xlr_defconfig )
unicore32 if not set
tile if not set

The * if not set (or not being on the list) seems correct, as the top
level Makefile will handle this correctly.  Setting it for some
configs seems curious (not necessarily wrong?), emptying it/always
setting it via config sounds wrong to me, but maybe those hosts don't
have toolchains and must always be cross compiled for?

For reference, this file in LLVM source defines the supported backend
targets: https://llvm.org/doxygen/Triple_8h_source.html

Either way, it sounds like we're all set here, I guess I'm just
curious about the LKML link/context and why some configs set
CROSS_COMPILE themselves?
