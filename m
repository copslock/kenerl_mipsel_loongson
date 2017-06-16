Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 12:24:23 +0200 (CEST)
Received: from www62.your-server.de ([213.133.104.62]:37298 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994805AbdFPKYQQL3OG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 12:24:16 +0200
Received: from [92.105.166.74] (helo=localhost.localdomain)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1dLoQB-0007dT-GY; Fri, 16 Jun 2017 12:24:07 +0200
Message-ID: <5943B1C6.7040809@iogearbox.net>
Date:   Fri, 16 Jun 2017 12:24:06 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 2/3] samples/bpf: Add define __EMITTING_BPF__ when
 building BPF
References: <20170615223543.22867-1-david.daney@cavium.com> <20170615223543.22867-3-david.daney@cavium.com>
In-Reply-To: <20170615223543.22867-3-david.daney@cavium.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.2/23478/Fri Jun 16 06:12:21 2017)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@iogearbox.net
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

On 06/16/2017 12:35 AM, David Daney wrote:
> ... this allows gating of inline assembly code that causes llvm to
> fail when emitting BPF.
>
> Signed-off-by: David Daney <david.daney@cavium.com>

I don't have a better idea at the moment, perhaps there could be
a clang rewrite plugin that would ignore all inline assembly code
since this is never used from BPF progs. Hmm. Really ugly that
we have to add this __EMITTING_BPF__ into arch asm files, but I
don't have a better idea for an immediate workaround right now ...
I would really prefer if we could avoid just for the sake of the
kernel samples going down the road of adding a !defined(__EMITTING_BPF__)
into a uapi asm header for mips, though. Is this coming from
networking sample code or rather tracing?

> ---
>   samples/bpf/Makefile | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index a0561dc762fe..4979e6b56662 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -193,12 +193,12 @@ $(src)/*.c: verify_target_bpf
>
>   $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
>
> -# asm/sysreg.h - inline assembly used by it is incompatible with llvm.
> -# But, there is no easy way to fix it, so just exclude it since it is
> -# useless for BPF samples.
> +# __EMITTING_BPF__ used to exclude inline assembly, which cannot be
> +# emitted in BPF code.
>   $(obj)/%.o: $(src)/%.c
>   	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
> -		-D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
> +		-D__KERNEL__ -D__EMITTING_BPF__ \
> +		-Wno-unused-value -Wno-pointer-sign \
>   		-Wno-compare-distinct-pointer-types \
>   		-Wno-gnu-variable-sized-type-not-at-end \
>   		-Wno-address-of-packed-member -Wno-tautological-compare \
>
