Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 00:09:08 +0200 (CEST)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:42099 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFWWJGleHXi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 00:09:06 +0200
Received: by mail-wg0-f50.google.com with SMTP id m15so280889wgh.9
        for <linux-mips@linux-mips.org>; Mon, 23 Jun 2014 15:09:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/CckaFl3GwHDgFPT8PO4Z/0zEwEGlFLPVH+DPf/xmS4=;
        b=LH6gyTSfW45mmRDvQJFnbp/pR0G1tC06C6E3vkclIz/3iHnVTgfGywyQmZlxLyeRDp
         Vu6RLdrnPh3WFEgmkRBNCDT4BcG9QJJg8a3+p1hZMqgQdLbZy93iYfahDmaA6lZNqb2N
         z73GYLB5XajTUuBGdujpuDxyPgBDLkCE9Ybi4IVxObKhUNNcTBWmWsSxt3IxB+K90CYj
         3RxNCL3CtncvQlZyM5Vcr5R4RbYT8mZHUb3mpgD1vQbOawXSOE1PljpK3EHbCMzLeQpy
         qhb2or9iSncATppP/HwWGcRdYfLRgyVgffeyh4/r9SoODjDNHsmKr1w60XJ2LK0hKEwU
         pXsw==
X-Gm-Message-State: ALoCoQmoOM8S42q2v1vIG0Dat2EmBJVK6zjBpbfrCNWzcIdb0SOpTweTL0qDD1HkxESGF//RI/np
MIME-Version: 1.0
X-Received: by 10.194.240.196 with SMTP id wc4mr31749185wjc.63.1403561341323;
 Mon, 23 Jun 2014 15:09:01 -0700 (PDT)
Received: by 10.194.121.228 with HTTP; Mon, 23 Jun 2014 15:09:01 -0700 (PDT)
In-Reply-To: <1403516340-22997-6-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
        <1403516340-22997-6-git-send-email-markos.chandras@imgtec.com>
Date:   Mon, 23 Jun 2014 15:09:01 -0700
Message-ID: <CAMEtUuyL8EV3UxS7yaD_ufiAywr7hkgPSC-3etMEYfbAZ_rRew@mail.gmail.com>
Subject: Re: [PATCH 05/17] MIPS: bpf: Return error code if the offset is a
 negative number
From:   Alexei Starovoitov <ast@plumgrid.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <dborkman@redhat.com>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ast@plumgrid.com
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

On Mon, Jun 23, 2014 at 2:38 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> Previously, the negative offset was not checked leading to failures
> due to trying to load data beyond the skb struct boundaries. Until we
> have proper asm helpers in place, it's best if we return ENOSUPP if K
> is negative when trying to JIT the filter or 0 during runtime if we
> do an indirect load where the value of X is unknown during build time.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Daniel Borkmann <dborkman@redhat.com>
> Cc: Alexei Starovoitov <ast@plumgrid.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

Hi Markos,

thank you for addressing all of my earlier comments.
Looks like test_bpf was quite useful in finding all of these bugs :)
For the patches that reached netdev:

Acked-by: Alexei Starovoitov <ast@plumgrid.com>

One minor nit below:

> ---
>  arch/mips/net/bpf_jit.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
> index 5cc92c4590cb..95728ea6cb74 100644
> --- a/arch/mips/net/bpf_jit.c
> +++ b/arch/mips/net/bpf_jit.c
> @@ -331,6 +331,12 @@ static inline void emit_srl(unsigned int dst, unsigned int src,
>         emit_instr(ctx, srl, dst, src, sa);
>  }
>
> +static inline void emit_slt(unsigned int dst, unsigned int src1,
> +                           unsigned int src2, struct jit_ctx *ctx)
> +{
> +       emit_instr(ctx, slt, dst, src1, src2);
> +}
> +
>  static inline void emit_sltu(unsigned int dst, unsigned int src1,
>                              unsigned int src2, struct jit_ctx *ctx)
>  {
> @@ -816,8 +822,21 @@ static int build_body(struct jit_ctx *ctx)
>                         /* A <- P[k:1] */
>                         load_order = 0;
>  load:
> +                       /* the interpreter will deal with the negative K */
> +                       if ((int)k < 0)

should be a space after cast.
