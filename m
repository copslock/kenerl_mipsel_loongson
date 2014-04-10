Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 05:41:10 +0200 (CEST)
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54346 "EHLO
        mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822149AbaDJDlGDxg2I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Apr 2014 05:41:06 +0200
Received: by mail-qc0-f174.google.com with SMTP id c9so3728953qcz.19
        for <linux-mips@linux-mips.org>; Wed, 09 Apr 2014 20:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WNQAmnCpw/tAMC/cLzM44s8abALRrUVsYzyflSUpgOI=;
        b=P5rsLUYsUZexrffgoqJEVQIUb/fEpElKIa4Sl/Q/qzOS0Zg3mDKY8JmEfcuKjx9aM6
         gVh1z6NXEUfy+7W1acLQNheNf7guz4Um8Y4/9thhnPFOf44Qak222H6pZe3f1sstKEPJ
         6trwoi2kJHnSA7Yd205Y2oUYnQz8XVKpPhfJOux4Wld1j1jfM/keZOfgGRK/jYUAg8DK
         k4ceTw73ei8Yh9l2yyb7BTB8Tv5hzcEpWBZrLvW8uoIp5Crk3BEM/Rlvk3CZy/6EfVtC
         uOchHNY3zSEixmref4r/layt34xYa/+CpaL8md2fOw7MJQwN3yzwy/r2AEi5R+Yu2yWJ
         A2yQ==
MIME-Version: 1.0
X-Received: by 10.224.79.72 with SMTP id o8mr17704679qak.20.1397101259771;
 Wed, 09 Apr 2014 20:40:59 -0700 (PDT)
Received: by 10.96.158.132 with HTTP; Wed, 9 Apr 2014 20:40:59 -0700 (PDT)
In-Reply-To: <1397059208-27096-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-14-git-send-email-markos.chandras@imgtec.com>
        <1397059208-27096-1-git-send-email-markos.chandras@imgtec.com>
Date:   Wed, 9 Apr 2014 20:40:59 -0700
Message-ID: <CAADnVQLUKnHOjz55s_W+aVZrsWcJ7-UavJTCnFF7PRzLLnwVyQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] MIPS: net: Add BPF JIT
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Daniel Borkmann <dborkman@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Wed, Apr 9, 2014 at 9:00 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> This adds initial support for BPF-JIT on MIPS

Great work!

btw, net-next is closed and we're waiting to submit classic+internal
BPF testsuite
that would have helped in testing and benchmarking.

> Benchmarking:
> - BPF-JIT Disabled
> real    1m38.005s
> - BPF-JIT Enabled
> real    1m35.215s

it's hard to see the difference in a such setup.
In bpf only tests we see 4-20x speedup from jit.
I think mips arch should see something similar.

Few questions:
- why did you implement only this small set of bpf extensions?
  was there a use case or they were easier comparing to others?

- this patch set depends on 12 other patches.
  would be easier to review if the whole set is cc-ed to netdev

- did you consider doing jit over internal bpf?
  all bpf extensions support would have come for free and it would work
  for seccomp and tracing filters in the future.

Few comments:

> +#define RSIZE  (sizeof(unsigned long))
> +#define ptr typeof(unsigned long)

these are odd looking macros.

> +static inline void emit_bcond(int cond, unsigned int reg1, unsigned int reg2,
> +                            unsigned int imm, struct jit_ctx *ctx)
> +{
> +       if (ctx->target != NULL) {
> +               u32 *p = &ctx->target[ctx->idx];
> +
> +               switch (cond) {
> +               case MIPS_COND_EQ:
> +                       uasm_i_beq(&p, reg1, reg2, imm);
> +                       break;
> +               case MIPS_COND_NE:
> +                       uasm_i_bne(&p, reg1, reg2, imm);
> +                       break;
> +               case MIPS_COND_ALL:
> +                       uasm_i_b(&p, imm);
> +                       break;
> +               default:
> +                       pr_warn("%s: Unhandled branch conditional: %d\n",
> +                               __func__, cond);

shouldn't it be BUG_ON instead?
can it spam kernel logs?

> +static bool is_load_to_a(u16 inst)
> +{
> +       switch (inst) {
> +       case BPF_S_LD_W_LEN:
> +       case BPF_S_LD_W_ABS:
> +       case BPF_S_LD_H_ABS:
> +       case BPF_S_LD_B_ABS:
> +       case BPF_S_ANC_CPU:
> +       case BPF_S_ANC_IFINDEX:
> +       case BPF_S_ANC_MARK:
> +       case BPF_S_ANC_PROTOCOL:
> +       case BPF_S_ANC_RXHASH:
> +       case BPF_S_ANC_VLAN_TAG:
> +       case BPF_S_ANC_VLAN_TAG_PRESENT:
> +       case BPF_S_ANC_QUEUE:

it seems this switch() statement handles more extensions
that actually jitted later. Future proofing?

> +static void save_bpf_jit_regs(struct jit_ctx *ctx, unsigned offset)
> +{
> +       int i = 0, real_off = 0;
> +       u32 sflags, tmp_flags;
> +
> +       /* Adjust the stack pointer */
> +       emit_stack_offset(-align_sp(offset), ctx);
> +
> +       if (ctx->flags & SEEN_CALL) {
> +               /* Argument save area */
> +               if (config_enabled(CONFIG_64BIT))
> +                       /* Bottom of current frame */
> +                       real_off = align_sp(offset) - RSIZE;
> +               else
> +                       /* Top of previous frame */
> +                       real_off = align_sp(offset) + RSIZE;
> +               emit_store_stack_reg(MIPS_R_A0, r_sp, real_off, ctx);
> +               emit_store_stack_reg(MIPS_R_A1, r_sp, real_off + RSIZE, ctx);
> +
> +               real_off = 0;
> +       }
> +
> +       tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
> +       /* sflags is essentially a bitmap */
> +       pr_debug("%s: register flags: 0x%08x\n", __func__, tmp_flags);

that will spam logs. please remove.

> +       while (tmp_flags) {
> +               if ((sflags >> i) & 0x1) {
> +                       pr_debug("%s: preserving register %d\n", __func__,
> +                                MIPS_R_S0 + i);

likewise.

> +static void restore_bpf_jit_regs(struct jit_ctx *ctx,
> +                                unsigned int offset)
> +{
> +       int i, real_off = 0;
> +       u32 sflags, tmp_flags;
> +
> +       if (ctx->flags & SEEN_CALL) {
> +               if (config_enabled(CONFIG_64BIT))
> +                       /* Bottom of current frame */
> +                       real_off = align_sp(offset) - RSIZE;
> +               else
> +                       /* Top of previous frame */
> +                       real_off = align_sp(offset) + RSIZE;
> +               emit_load_stack_reg(MIPS_R_A0, r_sp, real_off, ctx);
> +               emit_load_stack_reg(MIPS_R_A1, r_sp, real_off + RSIZE, ctx);
> +
> +               real_off = 0;
> +       }
> +
> +       tmp_flags = sflags = ctx->flags >> SEEN_SREG_SFT;
> +       /* sflags is a bitmap */
> +       pr_debug("%s: register flags: 0x%08x\n", __func__, tmp_flags);

likewise. please remove.

> +       i = 0;
> +       while (tmp_flags) {
> +               if ((sflags >> i) & 0x1) {
> +                       pr_debug("%s: restoring register %d\n", __func__,
> +                                MIPS_R_S0 + i);

likewise.

> +static u64 jit_get_skb_b(struct sk_buff *skb, unsigned offset)
> +{
> +       u8 ret;
> +       int err;
> +
> +       err = skb_copy_bits(skb, offset, &ret, 1);
> +
> +       return (u64)err << 32 | ret;
> +}

negative offsets are not supported intentionally?

> +static int build_body(struct jit_ctx *ctx)
> +{
> +       void *load_func[] = {jit_get_skb_b, jit_get_skb_h, jit_get_skb_w};
> +       const struct sk_filter *prog = ctx->skf;
> +       const struct sock_filter *inst;
> +       unsigned int i, off, load_order, condt;
> +       u32 k, b_off __maybe_unused;
> +
> +       for (i = 0; i < prog->len; i++) {
> +               inst = &(prog->insns[i]);
> +               pr_debug("%s: code->0x%02x, jt->0x%x, jf->0x%x, k->0x%x\n",
> +                        __func__, inst->code, inst->jt, inst->jf, inst->k);

please remove.

> +load_ind:
> +                       update_on_xread(ctx);
> +                       ctx->flags |= SEEN_OFF | SEEN_X;
> +                       emit_addiu(r_off, r_X, k, ctx);
> +               goto load_common;

needs extra tab of formatting

> +               case BPF_S_ANC_VLAN_TAG_PRESENT:
> +                       ctx->flags |= SEEN_SKB | SEEN_S0 | SEEN_A;
> +                       BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
> +                                                 vlan_tci) != 2);
> +                       off = offsetof(struct sk_buff, vlan_tci);
> +                       emit_half_load(r_s0, r_skb, off, ctx);
> +                       if (inst->code == BPF_S_ANC_VLAN_TAG)

this branch can never be hit. Did you miss 'case VLAN_TAG' few lines above?

> +                               emit_and(r_A, r_s0, VLAN_VID_MASK, ctx);
> +                       else
> +                               emit_and(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
> +                       break;
> +               case BPF_S_ANC_QUEUE:
> +                       ctx->flags |= SEEN_SKB | SEEN_A;
> +                       BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
> +                                                 queue_mapping) != 2);
> +                       BUILD_BUG_ON(offsetof(struct sk_buff,
> +                                             queue_mapping) > 0xff);
> +                       off = offsetof(struct sk_buff, queue_mapping);
> +                       emit_half_load(r_A, r_skb, off, ctx);
> +                       break;
> +               default:
> +                       pr_warn("%s: Unhandled opcode: 0x%02x\n", __FILE__,
> +                               inst->code);

that will spam the logs. please remove.

> +                       return -1;
> +               }
> +       }
> +
> +       /* compute offsets only during the first pass */
> +       if (ctx->target == NULL)
> +               ctx->offsets[i] = ctx->idx * 4;
> +
> +       return 0;
> +
> +}
> +
> +int bpf_jit_enable __read_mostly;
> +
> +void bpf_jit_compile(struct sk_filter *fp)
> +{
> +       struct jit_ctx ctx;
> +       unsigned int alloc_size, tmp_idx;
> +
> +       if (!bpf_jit_enable)
> +               return;
> +
> +       memset(&ctx, 0, sizeof(ctx));
> +
> +       ctx.offsets = kcalloc(fp->len, sizeof(*ctx.offsets), GFP_KERNEL);
> +       if (ctx.offsets == NULL)
> +               return;
> +
> +       ctx.skf = fp;
> +
> +       if (unlikely(build_body(&ctx)))

why 'unlikely'? this jit doesn't support all extensions
so it may very well be 'likely' for some use cases.

> +               goto out;
> +
> +       tmp_idx = ctx.idx;
> +       build_prologue(&ctx);
> +       ctx.prologue_bytes = (ctx.idx - tmp_idx) * 4;
> +       /* just to complete the ctx.idx count */
> +       build_epilogue(&ctx);
> +
> +       alloc_size = 4 * ctx.idx;
> +       ctx.target = module_alloc(alloc_size);
> +       if (ctx.target == NULL)
> +               goto out;
> +
> +       /* Clean it */
> +       memset(ctx.target, 0, alloc_size);
> +
> +       ctx.idx = 0;
> +
> +       /* Generate the actual JIT code */
> +       build_prologue(&ctx);
> +       build_body(&ctx);

do you want to add BUG_ON to make sure that 2nd build_body() succeeds?
