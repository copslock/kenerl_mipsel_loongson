Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2018 10:01:58 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:35656
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHKIBybN8mf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2018 10:01:54 +0200
Received: by mail-qk0-x241.google.com with SMTP id u21-v6so7959855qku.2;
        Sat, 11 Aug 2018 01:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PcWLAN+atwDcU2RuePCWuiwp/JR1bR56eaOYu+0fdeE=;
        b=Ks+y6vOMor+hdIBC1RQHOLTMnkZ753y3BQeZuyvTLR3YKhBuPcbKrVcIZFdpzKREcl
         WGA8DYmd1fTAkN3+Ljzob2fKF+XdpnkMTy1SEkQSsbDAAW5+Hq/+6gUdNAYiAgPXjLEz
         xOvveq8eI3On+2XxRdgLD1fIKanwoSJLyNXLUr5D6Vk38vO1JB2idBJ+f5nhjJ6JbAkR
         V3TMQ5EuDByRuYSMzJHhrD1BPvReKQA01ZbUrhfPT98FoLgTH1Sbz9uGQvnsyVc+beW0
         KdtKHP0V4b7iypVKLUOkSl7sO0Ggf2/f197hurfeYJ3JMUA5/DROsmPhFyfNPN6vjTk/
         hhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PcWLAN+atwDcU2RuePCWuiwp/JR1bR56eaOYu+0fdeE=;
        b=qvet4Bs0PU8KWZVHDrQEG09PkA6aWds2Rw3eHjgCQmQ/8IKFMt6iBLcVX3/WnlW91z
         Ju03Mrvl16gcA5m+kP2tpVDmECwwLOnWx+/tZhBb1Mi9C/amKdMzsPySinF+IrKgpYfQ
         IUSDfVm49rqS0bIkmSS10WzYC8RnACB/DbsKdP+ejBYOLKO0NRvSdm0SqpJsrslcVSlK
         UmO00uE45xKDE0Rq3xiBdSzA1dqIndSvkT1zNiNAPYn1tStuM3uZdBQaPGMqYx47BTqG
         C/rDrWrmqGrfFiSh5R5phD/YChDvukoukOOK4A3PP8mXNn3Opwj75fJJidJ0oEe1vB11
         w4qw==
X-Gm-Message-State: AOUpUlGmvHqnlMow8PI/x1Ct5iwaigEnKAH7ldPk+eVGL59wDndDd5mK
        tgWUQplrzp4D7v6KE1p7P8AjVwmcDp3dGK4ISLA=
X-Google-Smtp-Source: AA+uWPzNsBemhq1KxmR4B6+xAsWpuHbAMCNIhaK5X3Ww+fCMvkmj0GGGLRytgYd9F8W0AOkfBzqt2g+cgVqzTq7Niog=
X-Received: by 2002:a37:6e82:: with SMTP id j124-v6mr8977923qkc.179.1533974508497;
 Sat, 11 Aug 2018 01:01:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:01:48
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-3-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-3-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:01:48 -0700
Message-ID: <CAPhsuW71ysLTafz2y=v_dY_=0BOn0MDL0TKD6eEBQ2ZQUTBuvw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Add addition argument 'arch_uprobe' to uprobe_write_opcode().
> We need this in later set of patches.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Reviewed-by: Song Liu <songliubraving@fb.com>

> ---
>  arch/arm/probes/uprobes/core.c | 2 +-
>  arch/mips/kernel/uprobes.c     | 2 +-
>  include/linux/uprobes.h        | 2 +-
>  kernel/events/uprobes.c        | 9 +++++----
>  4 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
> index d1329f1ba4e4..bf992264060e 100644
> --- a/arch/arm/probes/uprobes/core.c
> +++ b/arch/arm/probes/uprobes/core.c
> @@ -32,7 +32,7 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
>  int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
>              unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr,
> +       return uprobe_write_opcode(auprobe, mm, vaddr,
>                    __opcode_to_mem_arm(auprobe->bpinsn));
>  }
>
> diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
> index f7a0645ccb82..4aaff3b3175c 100644
> --- a/arch/mips/kernel/uprobes.c
> +++ b/arch/mips/kernel/uprobes.c
> @@ -224,7 +224,7 @@ unsigned long arch_uretprobe_hijack_return_addr(
>  int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
>         unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
> +       return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
>  }
>
>  void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index 0a294e950df8..bb9d2084af03 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -121,7 +121,7 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
>  extern bool is_trap_insn(uprobe_opcode_t *insn);
>  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
>  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> -extern int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
>  extern int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
>  extern int uprobe_apply(struct inode *inode, loff_t offset, struct uprobe_consumer *uc, bool);
>  extern void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 471eac896635..c0418ba52ba8 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -299,8 +299,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
>   * Called with mm->mmap_sem held for write.
>   * Return 0 (success) or a negative errno.
>   */
> -int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
> -                       uprobe_opcode_t opcode)
> +int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> +                       unsigned long vaddr, uprobe_opcode_t opcode)
>  {
>         struct page *old_page, *new_page;
>         struct vm_area_struct *vma;
> @@ -351,7 +351,7 @@ int uprobe_write_opcode(struct mm_struct *mm, unsigned long vaddr,
>   */
>  int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr, UPROBE_SWBP_INSN);
> +       return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
>  }
>
>  /**
> @@ -366,7 +366,8 @@ int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned
>  int __weak
>  set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
>  {
> -       return uprobe_write_opcode(mm, vaddr, *(uprobe_opcode_t *)&auprobe->insn);
> +       return uprobe_write_opcode(auprobe, mm, vaddr,
> +                       *(uprobe_opcode_t *)&auprobe->insn);
>  }
>
>  static struct uprobe *get_uprobe(struct uprobe *uprobe)
> --
> 2.14.4
>
