Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 16:38:04 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:32825
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991948AbdFSOh5RJL6Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2017 16:37:57 +0200
Received: by mail-qt0-x242.google.com with SMTP id w1so19482674qtg.0
        for <linux-mips@linux-mips.org>; Mon, 19 Jun 2017 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=greyhouse-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Im6SeFA7p6i7B9c+I+TeMpwObs0yTeoACAL2KFq3+Q=;
        b=wlDxV3me/mycCnRGNwprHPX0uF6qXJiZbQOBg194lxHe5IdXI9Pq37f26k9Le2d4e8
         Oo+gJiRZRBGYJbP7dVp2Kf6epLiXDyukX5OWyHs00kejH7ofhLb8PmsPhHGSmOgts9u4
         heO21Wg0SHCUggebgM4McHr6zjP+OtFJ9u7X+DkCR0uQd4ORH26S8MEHSm/uzUdBn1CS
         tKdIYcbVHUttxlr/hSkScKToAcJgfQgriygqz5pZscaSmhbjx3NcXZTBnulaL/Cvzs+p
         GXhS850wQvnfcy1C+tPtf+cfPg7Yca6FeWZNNzo1IAcNBhjNliVwjzxHADEw3pumOU97
         Ejnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Im6SeFA7p6i7B9c+I+TeMpwObs0yTeoACAL2KFq3+Q=;
        b=lZVa94c5HBPYWLaTkTDXTp8H+Q40kfY9pbN8I2bmjcrqWfBva7IuxztsalBzKLuefy
         oXhkNi2y3CBsUywWDaFIR0faGbGwpZoJBrSZS5wuE7EGit6k20EIU+YlpgqzuPXq0idE
         23hJshkb4YCyUTtDE9K4tgI47x6P493E/+vQO/kfVSZFScKx0oXS60pQqOpGr+Kp3csn
         Jt23fc81qb7kQ/McsRPmxlfmf2ib1jROjybMtvAH7q5txyoM3e+p5iZhDLTyj6Nm4Rr/
         RAhRbmHorJbOVX1B4fDD1BMNqQZnPvkytW/7Veb2ve7CqmJMPxmzyUmLh4zGtcal6puV
         NNsw==
X-Gm-Message-State: AKS2vOyvvfYdKav3ptMLmwG6sxTaL+ENTqAES/m37DoCpiINbkwYtEPh
        A6o6yCLunrl1o9vI
X-Received: by 10.237.59.147 with SMTP id r19mr27317707qte.47.1497883071381;
        Mon, 19 Jun 2017 07:37:51 -0700 (PDT)
Received: from C02RW35GFVH8.dhcp.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q90sm3752416qki.11.2017.06.19.07.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 07:37:50 -0700 (PDT)
Date:   Mon, 19 Jun 2017 10:37:47 -0400
From:   Andy Gospodarek <andy@greyhouse.net>
To:     David Daney <david.daney@cavium.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 2/3] samples/bpf: Add define __EMITTING_BPF__ when
 building BPF
Message-ID: <20170619143747.GA20370@C02RW35GFVH8.dhcp.broadcom.net>
References: <20170615223543.22867-3-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615223543.22867-3-david.daney@cavium.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <andy@greyhouse.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy@greyhouse.net
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

On Thu, Jun 15, 2017 at 03:35:42PM -0700, David Daney wrote:
> ... this allows gating of inline assembly code that causes llvm to
> fail when emitting BPF.

I floated essentially the same patch in Feb without much luck:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492758.html

Many of the folks on the cc-list here had objections then and I suspect they
unfortunately still object.  I like the fact that this fix allowed
architectures that are currently problematic to move forward before there is a
possibly mythical "fix in llvm" to address this problem.

When talking about this in one of the IOVisor calls it was also discussed that
this needs to be fixed for tracing, so there are more than just the BPF
use-case where this is important.

I wasn't sure there was buy-in from the ARM developers, but my thought had been
that a cleaner solution to this would be to reorganize sysreg.h into multiple
files.  The inline assembly would be the only thing in sysreg-asm.h (that was
actually the only thing originally in sysreg.h) and the rest of the code would
be in sysreg.h.

That is not what Dave suggested, but it would be a good starting point for a
custom asm/ layer for BPF/tracing.  I'm with Dave and think a specialized set
of asm/ files for tracing/BPF to avoid these issues all-together and let arch
developers to do whatever they want in their code.

> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  samples/bpf/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index a0561dc762fe..4979e6b56662 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -193,12 +193,12 @@ $(src)/*.c: verify_target_bpf
>  
>  $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
>  
> -# asm/sysreg.h - inline assembly used by it is incompatible with llvm.
> -# But, there is no easy way to fix it, so just exclude it since it is
> -# useless for BPF samples.
> +# __EMITTING_BPF__ used to exclude inline assembly, which cannot be
> +# emitted in BPF code.
>  $(obj)/%.o: $(src)/%.c
>  	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) \
> -		-D__KERNEL__ -D__ASM_SYSREG_H -Wno-unused-value -Wno-pointer-sign \
> +		-D__KERNEL__ -D__EMITTING_BPF__ \
> +		-Wno-unused-value -Wno-pointer-sign \
>  		-Wno-compare-distinct-pointer-types \
>  		-Wno-gnu-variable-sized-type-not-at-end \
>  		-Wno-address-of-packed-member -Wno-tautological-compare \
