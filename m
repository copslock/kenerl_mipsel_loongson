Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Nov 2018 16:56:19 +0100 (CET)
Received: from mail-io1-xd42.google.com ([IPv6:2607:f8b0:4864:20::d42]:41820
        "EHLO mail-io1-xd42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992280AbeKRPz0uOAXP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Nov 2018 16:55:26 +0100
Received: by mail-io1-xd42.google.com with SMTP id s22so8648510ioc.8
        for <linux-mips@linux-mips.org>; Sun, 18 Nov 2018 07:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVpHVlN8yMb+8QBmHy6R38Io2Rvx7iOnFnXQ1i2RcB0=;
        b=U4YH+vLZlLB+8Lk1fLwwL9SqcRVKdWwEYNRWI29Tc2kuUJ6m4LvNFoAYY88XZbezRI
         jL+Uj+gZ15vaSPqfe1C5w38l7H/tUnQhdPqsTe5oC8bnov+61JhICme1/RWg1ppqNiZI
         ziqrJ5EiU8nbt66gD7FcGQ/P+iO/KFV8ZVSec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVpHVlN8yMb+8QBmHy6R38Io2Rvx7iOnFnXQ1i2RcB0=;
        b=IoUT+yRW5xMNROXdZaWmrUYakWQSkEuujP6AZBC756tas0iaXy5bKWZgcfk+9ck4ft
         FfDdxwJkN5NfXua+tj9ZPDe10PG3MyAtgPdoI4F/tJGNp7GBLvR9JylqjejWmfu6STqA
         zG9KyLmLUCwNAENhkXqHGmmT9+4aUEKzHpfCG59mmnI+rjZEh/nOkLzcNNfOTJcmpgtJ
         55QTuX+9OTbcxEk2Y2C1awPGho0tjArFlsvDxfrDe+3KDFy+3oC5PS0fE0GgIsN6Y00y
         Hust5dWjGKobO8DcvIQ5RZN+9dxk4BQrEzgzuBq2RL11zv/QSu6vAqadMCCOp5OxzGNo
         XWeQ==
X-Gm-Message-State: AGRZ1gI7aQWnsB2djBZtggEI/hPU082PEf6wxj/4CO9Nod0ljCHQFcl2
        sEg5RYb2ffarQB1LyH2DS9Q+yPpfUU3KxtPYkpbZsw==
X-Google-Smtp-Source: AFSGD/VNKyUsHCOcVEU25YMknGotPrNhpWyqf/fQRCqaqAvE2Nbcuc3zJbxkUkBaiT2Ul2zjAYDD4rvDQg2QpnI523o=
X-Received: by 2002:a6b:37c2:: with SMTP id e185-v6mr15113497ioa.173.1542556525869;
 Sun, 18 Nov 2018 07:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-3-ard.biesheuvel@linaro.org> <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
In-Reply-To: <CAH3MdRV85imzia+=irgbjL48wqFdorB-F1=BkwBgJgi3Z-XAKA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 18 Nov 2018 07:55:14 -0800
Message-ID: <CAKv+Gu9hB3a5LfFQskNzXZDmgps_+9dewbC1E5GFndcQZ-KgQg@mail.gmail.com>
Subject: Re: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
To:     ys114321@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux@vger.kernel.org,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On Sat, 17 Nov 2018 at 23:47, Y Song <ys114321@gmail.com> wrote:
>
> On Sat, Nov 17, 2018 at 6:58 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > All arch overrides of the __weak bpf_jit_free() amount to the same
> > thing: the allocated memory was never mapped read-only, and so
> > it does not have to be remapped to read-write before being freed.
> >
> > So in preparation of permitting arches to serve allocations for BPF
> > JIT programs from other regions than the module region, refactor
> > the existing bpf_jit_free() implementations to use the shared code
> > where possible, and only specialize the remap and free operations.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/mips/net/bpf_jit.c           |  7 ++-----
> >  arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
> >  arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
> >  arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
> >  kernel/bpf/core.c                 | 15 +++++----------
> >  5 files changed, 14 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> > index 1b69897274a1..5696bd7dccc7 100644
> > --- a/arch/mips/net/bpf_jit.c
> > +++ b/arch/mips/net/bpf_jit.c
> > @@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> >         kfree(ctx.offsets);
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index a1ea1ea6b40d..5b5ce4a1b44b 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
> >         return;
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 84c8f013a6c6..f64f1294bd62 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >         return fp;
> >  }
> >
> > -/* Overriding bpf_jit_free() as we don't set images read-only. */
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
> > index 01bda6bc9e7f..589950d152cc 100644
> > --- a/arch/sparc/net/bpf_jit_comp_32.c
> > +++ b/arch/sparc/net/bpf_jit_comp_32.c
> > @@ -756,10 +756,7 @@ cond_branch:                       f_offset = addrs[i + filter[i].jf];
> >         return;
> >  }
> >
> > -void bpf_jit_free(struct bpf_prog *fp)
> > +void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       if (fp->jited)
> > -               bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
> > -
> > -       bpf_prog_unlock_free(fp);
> > +       module_memfree(hdr);
> >  }
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 1a796e0799ec..29f766dac203 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
> >         return hdr;
> >  }
> >
> > -void bpf_jit_binary_free(struct bpf_binary_header *hdr)
> > +void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
> >  {
> > -       u32 pages = hdr->pages;
> > -
> > +       bpf_jit_binary_unlock_ro(hdr);
> >         module_memfree(hdr);
> > -       bpf_jit_uncharge_modmem(pages);
> >  }
> >
> > -/* This symbol is only overridden by archs that have different
> > - * requirements than the usual eBPF JITs, f.e. when they only
> > - * implement cBPF JIT, do not set images read-only, etc.
> > - */
>
> Do you want to move the above comments to
> new weak function bpf_jit_binary_free?
>

Perhaps. But one thing I don't understand, looking at this again, is
why we have these overrides in the first place. module_memfree() just
calls vfree(), which takes down the mapping entirely (along with any
updated permissions), and so remapping it back to r/w right before
that seems rather pointless imo.

Can we get rid of bpf_jit_binary_unlock_ro() entirely, and along with
it, all these overrides for the free() path?
