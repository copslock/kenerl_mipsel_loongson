Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2017 17:29:38 +0200 (CEST)
Received: from shards.monkeyblade.net ([184.105.139.130]:42140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993417AbdEZP32V15S0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2017 17:29:28 +0200
Received: from localhost (unknown [38.140.131.194])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 50644125073FD;
        Fri, 26 May 2017 07:47:50 -0700 (PDT)
Date:   Fri, 26 May 2017 11:29:24 -0400 (EDT)
Message-Id: <20170526.112924.2288900171993979942.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, markos.chandras@imgtec.com
Subject: Re: [PATCH 5/5] MIPS: Add support for eBPF JIT.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20170526003826.10834-6-david.daney@cavium.com>
References: <20170526003826.10834-1-david.daney@cavium.com>
        <20170526003826.10834-6-david.daney@cavium.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 May 2017 07:47:51 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: David Daney <david.daney@cavium.com>
Date: Thu, 25 May 2017 17:38:26 -0700

> +static int gen_int_prologue(struct jit_ctx *ctx)
> +{
> +	int stack_adjust = 0;
> +	int store_offset;
> +	int locals_size;
> +
> +	if (ctx->flags & EBPF_SAVE_RA)
> +		/*
> +		 * If RA we are doing a function call and may need
> +		 * extra 8-byte tmp area.
> +		 */
> +		stack_adjust += 16;
> +	if (ctx->flags & EBPF_SAVE_S0)
> +		stack_adjust += 8;
> +	if (ctx->flags & EBPF_SAVE_S1)
> +		stack_adjust += 8;
> +	if (ctx->flags & EBPF_SAVE_S2)
> +		stack_adjust += 8;
> +	if (ctx->flags & EBPF_SAVE_S3)
> +		stack_adjust += 8;
> +
> +	BUILD_BUG_ON(MAX_BPF_STACK & 7);
> +	locals_size = (ctx->flags & EBPF_SEEN_FP) ? MAX_BPF_STACK : 0;

You will also need to use MAX_BPF_STACK here when you see a tail call,
but it appears you haven't implemented tail call support yet.

Which also several of the eBPF samples won't JIT and thus be tested
under this new MIPS JIT, since they make use of tail calls.

> +/*
> + * Track the value range (i.e. 32-bit vs. 64-bit) of each register at
> + * each eBPF insn.  This allows unneeded sign and zero extension
> + * operations to be omitted.
> + *
> + * Doesn't handle yet confluence of control paths with conflicting
> + * ranges, but it is good enough for most sane code.
> + */
> +static int reg_val_propagate(struct jit_ctx *ctx)

Very interesting technique.  I may adopt this for Sparc as well :-)

Perhaps at a some point, when the BPF verifier has real data flow
analysis, it can compute this for the JIT.
