Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 01:58:45 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36385 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008271AbbCZA6mvhQjA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Mar 2015 01:58:42 +0100
Received: by wibg7 with SMTP id g7so130240141wib.1;
        Wed, 25 Mar 2015 17:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Io/+CbP8sAmQLbQAaDUSSIYt7hidYdHAwp3Q63apzN0=;
        b=UEDxJNw+kyBN813/fXf8ORp/4CEK3d9ncKYumm5VeELwqCdlCd6b4oU4839fksZviS
         hZxNtBpYPkodNmAnmQkrPiuLk7iMgvouqzVH1RYF46Pjvyk/aDXV3BmznY8zQROqv6bz
         E15poLuVcuUeSxWjZOnWTZG+44g6iIZKFNqe/3XJFgq3GQ/b6aEn7l/Uw+oNb1ZSbZrM
         3A1e3CTBiUUu90yFGjt+CYpJcl7DkVlBNo/eALorycjIevDu52mFFYdRgOsfaKEQ6xs/
         53xMzcejE9QYPwljEoLk4hxNMOFx2BXZUQUhno8A3MzgVma+9SmlnppLC6p6FBlOSgy8
         9JfA==
MIME-Version: 1.0
X-Received: by 10.180.75.103 with SMTP id b7mr30811899wiw.32.1427331518567;
 Wed, 25 Mar 2015 17:58:38 -0700 (PDT)
Received: by 10.28.62.131 with HTTP; Wed, 25 Mar 2015 17:58:38 -0700 (PDT)
In-Reply-To: <tencent_61CBDDE16BEF4EA42D44A313@qq.com>
References: <1419215439-27900-1-git-send-email-chenhc@lemote.com>
        <tencent_61CBDDE16BEF4EA42D44A313@qq.com>
Date:   Thu, 26 Mar 2015 08:58:38 +0800
X-Google-Sender-Auth: EcszZEU55L73AnUHN6NjG_jRELg
Message-ID: <CAAhV-H7jZ35=qTDeSf-zSCueknXhWVf6w3cd=GS_LPtMY923fw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Hibernate: flush TLB entries earlier
From:   Huacai Chen <chenhc@lemote.com>
To:     Huacai Chen <chenhc@lemote.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

Can these two patches be merged in 4.0?

Huacai

On Thu, Jan 22, 2015 at 10:59 PM, 陈华才 <chenhc@lemote.com> wrote:
> Hi, Ralf,
>
> Can these two patches be merged in 3.19?
>
> Huacai
>
> ------------------ Original ------------------
> From:  "Huacai Chen"<chenhc@lemote.com>;
> Date:  Mon, Dec 22, 2014 10:30 AM
> To:  "Ralf Baechle"<ralf@linux-mips.org>;
> Cc:  "John Crispin"<john@phrozen.org>; "Steven J. Hill"<Steven.Hill@imgtec.com>; "linux-mips"<linux-mips@linux-mips.org>; "Fuxin Zhang"<zhangfx@lemote.com>; "wuzhangjin"<wuzhangjin@gmail.com>; "Huacai Chen"<chenhc@lemote.com>; "stable"<stable@vger.kernel.org>;
> Subject:  [PATCH 1/2] MIPS: Hibernate: flush TLB entries earlier
>
> We found that TLB mismatch not only happens after kernel resume, but
> also happens during snapshot restore. So move it to the beginning of
> swsusp_arch_suspend().
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/power/hibernate.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
> index 32a7c82..e7567c8 100644
> --- a/arch/mips/power/hibernate.S
> +++ b/arch/mips/power/hibernate.S
> @@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
>  END(swsusp_arch_suspend)
>
>  LEAF(swsusp_arch_resume)
> +       /* Avoid TLB mismatch during and after kernel resume */
> +       jal local_flush_tlb_all
>         PTR_L t0, restore_pblist
>  0:
>         PTR_L t1, PBE_ADDRESS(t0)   /* source */
> @@ -43,7 +45,6 @@ LEAF(swsusp_arch_resume)
>         bne t1, t3, 1b
>         PTR_L t0, PBE_NEXT(t0)
>         bnez t0, 0b
> -       jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
>         PTR_LA t0, saved_regs
>         PTR_L ra, PT_R31(t0)
>         PTR_L sp, PT_R29(t0)
> --
> 1.7.7.3
