Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 16:38:14 +0100 (CET)
Received: from mail-it1-x143.google.com ([IPv6:2607:f8b0:4864:20::143]:54729
        "EHLO mail-it1-x143.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991175AbeKSPhwFKLxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 16:37:52 +0100
Received: by mail-it1-x143.google.com with SMTP id a205-v6so8860026itd.4
        for <linux-mips@linux-mips.org>; Mon, 19 Nov 2018 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HovDyLoW9JgP2dOMddyLtoMQVzEDX+zbCzhvdFpRmKg=;
        b=D7qcptHPzcuFLxZJDKf3/4DYoAkuBIC1/vhhevIzPorrX0vffSlkOwDgxtkWOJQ5at
         HawzLKIlQZPHhzcg/ht+WOn2/Bwzx35gGjNcBaHjt33qZAinytdLYzklmhvd92e87Qpx
         QdcvOzwwWfj2RygLc+IHYXpaaAK0ppUfMF4FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HovDyLoW9JgP2dOMddyLtoMQVzEDX+zbCzhvdFpRmKg=;
        b=JTWQ4Bj13OYoRqrIzkCrDxOcsMZndmAU/4JOtIJrYTMioqHduqGL6vL6FmGYtBGNcY
         J1vwqHXwLOJBMvCEHu3LZqkOAvnElb7vO58+2Ug3ET5zKlYFvpnQbSkrA38+hCuaimkR
         nIDNSrNetrwYN5H65PGUObqt9Buq0J/Lz5ueNNoyCbrM9v3kEzTijqev03M7gRv1cA3K
         bfZAnwpE8Jv8lJb/ZPy1s3F4zCxtBPsKo4GVQApUk5c8Gt11oTwb2b8X07kqacdtBeKN
         wCP/F0D4aCs4ORCxOmC1JzF0zkiJTPkK8HT+2xBy9LO6YtHmQCGD/0LjeOEQTHs9LaVO
         OKyA==
X-Gm-Message-State: AA+aEWbq5ij0SOUjCJTRpbzbfwMDuI9a0mnDWckl0J0GtxDmpbinsmwH
        iH213nawMhVcwxP/SuPqMd6GLkYClPbb/jjsPctXog==
X-Google-Smtp-Source: AFSGD/XYGCOxtGQjZNHVynlMGnMqP3y8k20/U+DJFyEKBYt23Zja/1TkjR662SNXidQ9wGwqBoa2EOaNRg2lDyTv3Xs=
X-Received: by 2002:a24:710:: with SMTP id f16mr1015081itf.121.1542641871167;
 Mon, 19 Nov 2018 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
 <20181117185715.25198-2-ard.biesheuvel@linaro.org> <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
In-Reply-To: <b37c3411-7950-dcb3-f0c3-6d9f589d36ab@iogearbox.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 19 Nov 2018 07:37:39 -0800
Message-ID: <CAKv+Gu8mo+WkJ356wByidUDoA-xHrUH99od5N_yJoqtX_28_5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] bpf: account for freed JIT allocations in arch code
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
X-archive-position: 67352
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

On Mon, 19 Nov 2018 at 02:37, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 11/17/2018 07:57 PM, Ard Biesheuvel wrote:
> > Commit ede95a63b5e84 ("bpf: add bpf_jit_limit knob to restrict unpriv
> > allocations") added a call to bpf_jit_uncharge_modmem() to the routine
> > bpf_jit_binary_free() which is called from the __weak bpf_jit_free().
> > This function is overridden by arches, some of which do not call
> > bpf_jit_binary_free() to release the memory, and so the released
> > memory is not accounted for, potentially leading to spurious allocation
> > failures.
> >
> > So replace the direct calls to module_memfree() in the arch code with
> > calls to bpf_jit_binary_free().
>
> Sorry but this patch is completely buggy, and above description on the
> accounting incorrect as well. Looks like this patch was not tested at all.
>

My apologies. I went off into the weeds a bit looking at different
versions for 32-bit and 64-bit on different architectures. So indeed,
this patch should be dropped.

> The below cBPF JITs that use module_memfree() which you replace with
> bpf_jit_binary_free() are using module_alloc() internally to get the JIT
> image buffer ...
>

Indeed. So would you prefer for arm64 to override bpf_jit_free() in
its entirety, and not call bpf_jit_binary_free() but simply call
bpf_jit_uncharge_modmem() and vfree() directly? It's either that, or
we'd have to untangle this a bit, to avoid having one __weak function
on top of the other just so other arches can replace the
module_memfree() call in bpf_jit_binary_free() with vfree() (which
amount to the same thing on arm64 anyway)
