Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 18:38:26 +0100 (CET)
Received: from mail-pb0-f43.google.com ([209.85.160.43]:53217 "EHLO
        mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822344AbaAURiX4nS1H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 18:38:23 +0100
Received: by mail-pb0-f43.google.com with SMTP id md12so8684379pbc.30
        for <multiple recipients>; Tue, 21 Jan 2014 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9QQp0mvm/DGFct375IMkLSGLduD7zMbd9dC1osnuZTc=;
        b=lNtJLDfXxtgRPcvaOkgLPaONH5bgCntdZyKcz/g78UvMgvrfU824QG8sGSdBf2sIv8
         PV5+VkqT9VHqvDc5OszRNSVczMv+40TaPbFjDNStRCPWrmqGDrwbKQ7dQULlXMrLqSVc
         i54gROT7RoUsbLzhPQjgTPP62wwUN6JL/N2AoPcUSpsqZh5QZZQ9iAVE93KgUqtgJban
         MKj8n7H5upyIbL8wm0Yan/KnzP8jbhcN7jr6Ps8S5IUzPo523ibZ2N9qYUXenp+Rf8aT
         70/unl/tXBHHr1aWSBFbSyNVzsDT2eA3QbyIdCAIdN6qOZUeEJ1cVPM/qxWVbNUHvQol
         qPdQ==
X-Received: by 10.66.146.133 with SMTP id tc5mr26008979pab.58.1390325896961;
 Tue, 21 Jan 2014 09:38:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Tue, 21 Jan 2014 09:37:36 -0800 (PST)
In-Reply-To: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
References: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 21 Jan 2014 09:37:36 -0800
Message-ID: <CAGVrzcYAyMiz4K7rg2xVGsYR1B-LaJzG2=KoQq6Weuy1tc5dqA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lib: Optimize partial checksum ops using prefetching.
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014/1/21 Steven J. Hill <Steven.Hill@imgtec.com>:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Use the PREF instruction to optimize partial checksum operations.

This does look like a nice feature, do you have any performance
benchmark results?

>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> ---
>  arch/mips/lib/csum_partial.S | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
> index a6adffb..272820e 100644
> --- a/arch/mips/lib/csum_partial.S
> +++ b/arch/mips/lib/csum_partial.S
> @@ -417,13 +417,19 @@ FEXPORT(csum_partial_copy_nocheck)
>          *
>          * If len < NBYTES use byte operations.
>          */
> +       PREF(   0, 0(src))
> +       PREF(   1, 0(dst))
>         sltu    t2, len, NBYTES
>         and     t1, dst, ADDRMASK
>         bnez    t2, .Lcopy_bytes_checklen
> +       PREF(   0, 32(src))
> +       PREF(   1, 32(dst))
>          and    t0, src, ADDRMASK
>         andi    odd, dst, 0x1                   /* odd buffer? */
>         bnez    t1, .Ldst_unaligned
>          nop
> +       PREF(   0, 2*32(src))
> +       PREF(   1, 2*32(dst))
>         bnez    t0, .Lsrc_unaligned_dst_aligned
>         /*
>          * use delay slot for fall-through
> @@ -434,6 +440,8 @@ FEXPORT(csum_partial_copy_nocheck)
>         beqz    t0, .Lcleanup_both_aligned # len < 8*NBYTES
>          nop
>         SUB     len, 8*NBYTES           # subtract here for bgez loop
> +       PREF(   0, 3*32(src))
> +       PREF(   1, 3*32(dst))
>         .align  4
>  1:
>  EXC(   LOAD    t0, UNIT(0)(src),       .Ll_exc)
> @@ -464,6 +472,8 @@ EXC(        STORE   t7, UNIT(7)(dst),       .Ls_exc)
>         ADDC(sum, t7)
>         .set    reorder                         /* DADDI_WAR */
>         ADD     dst, dst, 8*NBYTES
> +       PREF(   0, 8*32(src))
> +       PREF(   1, 8*32(dst))
>         bgez    len, 1b
>         .set    noreorder
>         ADD     len, 8*NBYTES           # revert len (see above)
> @@ -569,8 +579,10 @@ EXC(       STFIRST t3, FIRST(0)(dst),      .Ls_exc)
>
>  .Lsrc_unaligned_dst_aligned:
>         SRL     t0, len, LOG_NBYTES+2    # +2 for 4 units/iter
> +       PREF(   0, 3*32(src))
>         beqz    t0, .Lcleanup_src_unaligned
>          and    rem, len, (4*NBYTES-1)   # rem = len % 4*NBYTES
> +       PREF(   1, 3*32(dst))
>  1:
>  /*
>   * Avoid consecutive LD*'s to the same register since some mips
> --
> 1.8.3.2
>
>



-- 
Florian
