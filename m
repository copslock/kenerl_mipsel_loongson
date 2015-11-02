Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2015 21:51:00 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33583 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012127AbbKBUu6btM9P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Nov 2015 21:50:58 +0100
Received: by igvi2 with SMTP id i2so56583662igv.0
        for <linux-mips@linux-mips.org>; Mon, 02 Nov 2015 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y+38Bq+0gFhLLNK7MqVj/FkYZOlxRRwJqzNso9sQ0sQ=;
        b=nap0GMirbSyjS2afA3q7Gp7lQsSMnT1St0VtnSP+NcAwtR2HvhQc7MqreDxpMi/LqB
         4LEYKrpx3d3qSSTYZjj7J0+kJLxjRtGetAo11HGuf+j/RDV6rTVUyBC4rby2UhDqKSDu
         pcMJ0Atafs5tUvPN/HM6SL66y0QRLdQupiamEXmJRcLfPlZ6sCGzGYFv9oRHy6/97L8r
         Qcek8MOmon3pEVATG9SzNYWTdkk69MB1TmZwpc5DCdt9sJriYDe9M8S7XqQtVUTsWT7v
         /vONiz/kXeB1trUYgGB9MqZATbB4/wav89xwZGU0504bnMk4XnlGcwxgzR6Qlg0VdZjj
         4HeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Y+38Bq+0gFhLLNK7MqVj/FkYZOlxRRwJqzNso9sQ0sQ=;
        b=EEUnmEzEmSlUEHSejK0fA0kRjkwgKsXyqqVmn5GFz69ynspONxnroZkgjlGGcxQXvp
         XPWDlTZzOeR7+q6UpYwU3sKH8rUXpbCf0wZDwhBSNGyrMWMNssn/vj1Fj6IPYQGkDqdK
         ExaXrMtYRpcoLVsIESgrfPnIZsnjR6+7+h8HflL5P1dvkg7z45Jv3o22ggox4SiLCTdT
         pafEdKW5nDkOy41Jz5+g0QctNfARlQxn3TBaGaVK5ug4EwRrCv8+ncRy5xeeQJ1xzWKx
         NQ/ZnNxQtDKnJLpWBj2XVCA0Wb1XW9Z8uVbb0LhG8WcZeLkgaBWOK3SsOGcqiwiEkesO
         CEGg==
X-Gm-Message-State: ALoCoQnlsyTlh9VcWKOgQ46EKKMOuJz8GroLHdhvLvD0FGwFV5AL5z7tsOE0Wff7rbweAsxwqbtV
MIME-Version: 1.0
X-Received: by 10.50.65.74 with SMTP id v10mr14825405igs.54.1446497450779;
 Mon, 02 Nov 2015 12:50:50 -0800 (PST)
Received: by 10.64.228.37 with HTTP; Mon, 2 Nov 2015 12:50:50 -0800 (PST)
In-Reply-To: <1445280592-43038-1-git-send-email-pgynther@google.com>
References: <1445280592-43038-1-git-send-email-pgynther@google.com>
Date:   Mon, 2 Nov 2015 12:50:50 -0800
Message-ID: <CAGXr9JH5TLxOnA2LMPdxo3Sqeigprm=KFiiM9Vu2eMOaMgC6yA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add nmi_enter() + nmi_exit() to nmi_exception_handler()
From:   Petri Gynther <pgynther@google.com>
To:     linux-mips <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Petri Gynther <pgynther@google.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

On Mon, Oct 19, 2015 at 11:49 AM, Petri Gynther <pgynther@google.com> wrote:
>
> We need to enter NMI context when NMI interrupt fires.
>
> Signed-off-by: Petri Gynther <pgynther@google.com>
> ---
>  arch/mips/kernel/traps.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index fdb392b..efcedd4 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1856,12 +1856,14 @@ void __noreturn nmi_exception_handler(struct pt_regs *regs)
>  {
>         char str[100];
>
> +       nmi_enter();
>         raw_notifier_call_chain(&nmi_chain, 0, regs);
>         bust_spinlocks(1);
>         snprintf(str, 100, "CPU%d NMI taken, CP0_EPC=%lx\n",
>                  smp_processor_id(), regs->cp0_epc);
>         regs->cp0_epc = read_c0_errorepc();
>         die(str, regs);
> +       nmi_exit();
>  }
>
>  #define VECTORSPACING 0x100    /* for EI/VI mode */
> --
> 2.6.0.rc2.230.g3dd15c0
>

Any comments/concerns about this patch?

On our systems, we have seen stack traces like this:
<4>[158549.586000] : [<800103c0>] show_stack+0x78/0x90
<4>[158549.586000] : [<807340a0>] dump_stack+0xd0/0x144
<4>[158549.586000] : [<8006475c>] dequeue_task_idle+0x38/0x4c
<4>[158549.586000] : [<80735c8c>] __schedule+0x49c/0xa68
<4>[158549.586000] : [<80736294>] schedule+0x3c/0x9c
<4>[158549.586000] : [<80739930>] schedule_timeout+0x144/0x254
<4>[158549.586000] : [<800964f8>] msleep+0x40/0x54
<4>[158549.586000] : [<80010604>] die+0x124/0x130
<4>[158549.586000] : [<80012abc>] set_vi_handler+0x0/0x24
<4>[158549.586000] :
<3>[158549.586000] bad: scheduling from the idle thread!

80012a24 <nmi_exception_handler>:
...
80012ab4:       0c004138        jal     800104e0 <die>
80012ab8:       02002821        move    a1,s0

80012abc <set_vi_handler>:
...
