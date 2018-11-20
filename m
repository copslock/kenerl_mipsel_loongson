Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 08:16:08 +0100 (CET)
Received: from mail-it1-x141.google.com ([IPv6:2607:f8b0:4864:20::141]:35388
        "EHLO mail-it1-x141.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeKTHOFPD0N4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 08:14:05 +0100
Received: by mail-it1-x141.google.com with SMTP id v11so2045377itj.0
        for <linux-mips@linux-mips.org>; Mon, 19 Nov 2018 23:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAts0Gb6wtX4+ypNYNFi2pnx4xhkIPqxi2UclCxVXU4=;
        b=MXi5PceiuS3IEkmo6XQnDpfTCUNgu2agTXBDwJOp9hqkvh1Ir2LiNV56RsnH/7hRIn
         6ppL2wpK4PqM9SlGd4PVWnK+5F4YOMYOMEdo9Vb3bfmQ/Hknn7qVMjeDlBWadDiLWClU
         q4DCEq4t8clyQFPrInyjMauFmKdLFTwWh5FwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAts0Gb6wtX4+ypNYNFi2pnx4xhkIPqxi2UclCxVXU4=;
        b=SdsgBS2U4KDSUlJxP/BeZ3oEAO0GpFn2oTuBHiXzYb7HHZOyQNiD923xSI2HjXnI9O
         M2U+0qCLS1GB+N0BMu6ZFWHwo6iClAo15RvryuqeFlztsh/M1UofgNc1q6EgY9xANEBv
         RS4vv6sxCNsVfTuxUXCl1DaUb+6CuxHTd0XEcRABAG89cp9VmP4KnoBFcdq9I7+Ler+k
         fqayRUYGsMlD4mxfwVGnQFZaFjT2v06l3k4stMZJXSsN6AftNKExnTHFD6k/p2KzRUcP
         mHCnHScjg7rJo3ZPhUYn/CdWNcVVIwgVqnDcvOJw9+2G147xpV/46JxaQD9yqhZFHeQg
         o/Lg==
X-Gm-Message-State: AGRZ1gKaSxsiYYkUW56nsgYubjFlK/9TjnH41Ljlj/Y+Fb7Sor0vv+51
        CeZorZVqFPptSKYenK5YwWQ1QkZLNDRAKuFCmNiPOQ==
X-Google-Smtp-Source: AJdET5c/Uq29AUOy1iq0VOFObvACMMgpFoj9QZYyrR36nZhRYpM/cO+/cN+q8rcX4RotNwJFJ6J4A1cta8/BY8LWJAY=
X-Received: by 2002:a02:788:: with SMTP id f130-v6mr828954jaf.58.1542698044441;
 Mon, 19 Nov 2018 23:14:04 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-5-git-send-email-firoz.khan@linaro.org> <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
In-Reply-To: <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 20 Nov 2018 12:43:53 +0530
Message-ID: <CALxhOnjYzvDGdvuWitiOP46YuV6XViu9O3Fi0FU9u2jnV3W2EQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

Hi Paul,

On Tue, 20 Nov 2018 at 04:05, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Nov 15, 2018 at 11:44:20AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
> > new file mode 100644
> > index 0000000..dc6bbb1
> > --- /dev/null
> > +++ b/arch/mips/kernel/syscalls/Makefile
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +kapi := arch/$(SRCARCH)/include/generated/asm
> > +uapi := arch/$(SRCARCH)/include/generated/uapi/asm
> > +
> > +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')    \
> > +       $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> > +
> > +syscallo32 := $(srctree)/$(src)/syscall_o32.tbl
> > +syscall64 := $(srctree)/$(src)/syscall_64.tbl
> > +syscalln32 := $(srctree)/$(src)/syscall_n32.tbl
> > +syshdr := $(srctree)/$(src)/syscallhdr.sh
> > +systbl := $(srctree)/$(src)/syscalltbl.sh
>
> Could we go with 'n64' instead of just '64'?
>
> When we get nanoMIPS support we'll be introducing the p32 ABI, and
> there's a reasonable chance that the equivalent p64 ABI may come along
> in the future. Using 'n64' now would avoid confusion in that case where
> we may have 2 different 64-bit ABIs.

Sure, will do.

Thanks
Firoz

>
> Thanks,
>     Paul
