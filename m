Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2011 20:33:05 +0100 (CET)
Received: from mail-yi0-f41.google.com ([209.85.218.41]:53500 "EHLO
        mail-yi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491143Ab1ASTbI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jan 2011 20:31:08 +0100
Received: by yia25 with SMTP id 25so558598yia.28
        for <multiple recipients>; Wed, 19 Jan 2011 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ORf5/R8BzMeB9IAS/WnAnjO3MFwxFZ4ga59Q+BrLnCY=;
        b=FZwDwm5i7ckzgL+aYVkpYkQf5cvW7EG9kWkuuf5hgMD5YCucRIyesY1qISfpapGj8J
         H2TMUXhsVHFMD8RW01hKCAiihKLOBPerY19KAmokkzM6HIKnERVRwuJqjdN4Io/zSarZ
         mZUQySGAQZ1vywMur2cV21HN8zSwfVncLMngA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lw1KWjYxmUftEC+uBRfPEMi4+DGUBlzvsRZfEbFY5iAEESimT0Q6pgVhtTfkeWn5Xq
         NE89PTXnca53ISeqxpvGWvTXhJxCKTVzTvyVTrFqO0RqUjrid+Dtef/ioUDyGOI+5NqV
         M7tTvjcGl2vZ4Z9B85VMzh5k18Do3MRJacN4U=
MIME-Version: 1.0
Received: by 10.216.164.14 with SMTP id b14mr1248410wel.33.1295465432209; Wed,
 19 Jan 2011 11:30:32 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Wed, 19 Jan 2011 11:30:32 -0800 (PST)
In-Reply-To: <5fcf37ab006f1ccfe6844e7392a66c4cdd1aa84d.1295464564.git.wuzhangjin@gmail.com>
References: <cover.1295464564.git.wuzhangjin@gmail.com>
        <cover.1295464855.git.wuzhangjin@gmail.com>
        <5fcf37ab006f1ccfe6844e7392a66c4cdd1aa84d.1295464564.git.wuzhangjin@gmail.com>
Date:   Thu, 20 Jan 2011 03:30:32 +0800
Message-ID: <AANLkTinuP0ZDVgWQiG-YyCV1LWRAYMZB2dtQhHW6DOqE@mail.gmail.com>
Subject: Re: [PATCH 1/5] tracing, MIPS: reduce one instruction for function
 graph tracer
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <srostedt@redhat.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry, please ignore this one.

On Thu, Jan 20, 2011 at 3:28 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> This simply moves the "ip-=4" statement down to the end of the do { ...
> } while (...); loop, which reduces one unneeded subtration and the
> subsequent memory loading and comparation. as a result, speed up the
> function a little.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/kernel/ftrace.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 5a84a1f..635c1dc 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -200,19 +200,17 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
>        int faulted;
>
>        /*
> -        * For module, move the ip from calling site of mcount to the
> -        * instruction "lui v1, hi_16bit_of_mcount"(offset is 20), but for
> -        * kernel, move to the instruction "move ra, at"(offset is 12)
> +        * For module, move the ip from calling site of mcount after the
> +        * instruction "lui v1, hi_16bit_of_mcount"(offset is 24), but for
> +        * kernel, move after the instruction "move ra, at"(offset is 16)
>         */
> -       ip = self_addr - (in_module(self_addr) ? 20 : 12);
> +       ip = self_addr - (in_module(self_addr) ? 24 : 16);
>
>        /*
>         * search the text until finding the non-store instruction or "s{d,w}
>         * ra, offset(sp)" instruction
>         */
>        do {
> -               ip -= 4;
> -
>                /* get the code at "ip": code = *(unsigned int *)ip; */
>                safe_load_code(code, ip, faulted);
>
> @@ -226,7 +224,9 @@ unsigned long ftrace_get_parent_addr(unsigned long self_addr,
>                if ((code & S_R_SP) != S_R_SP)
>                        return parent_addr;
>
> -       } while (((code & S_RA_SP) != S_RA_SP));
> +               /* Move to the next instruction */
> +               ip -= 4;
> +       } while ((code & S_RA_SP) != S_RA_SP);
>
>        sp = fp + (code & OFFSET_MASK);
>
> --
> 1.7.1
>
>
