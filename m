Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 08:59:29 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:39172 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817318Ab2LGH716YNr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 08:59:27 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so185407lbo.36
        for <multiple recipients>; Thu, 06 Dec 2012 23:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YRmf6SDtwqu7yAxj/jJCzb4Vi6yYXiQIwS8m3jkkjVc=;
        b=h7mx0Z3VrW958KYF1GRoIIH09ghnGCbdjGNa7t4Bi7GVaXdBSm2T8DoVGz+ua7eLPm
         izVY4JM5BInpDEH4vCPRGLBPoPmhVo0uXl+zS6FEmXr4sEgRe4DdJiPx1bVsR3gau4XQ
         dbeBydDVdrpVZulQWMssXSBYtINM40CFVX8MlI34pR1svfzUUFllsrPeRe/gdbvtUGB/
         0TFNol4iHhPLd4Y29XLkmb4PTXIQ2xEkiRotFsYA/Te0jEQpM4+IuCTru73dWq5GI401
         wDL9cqAKnT+1JEIND2ZkalwKhyzEeczjFrRTRbtTEFwkEHX0UwOaffucltu2O1vmDlLw
         GHtQ==
MIME-Version: 1.0
Received: by 10.112.43.161 with SMTP id x1mr2198235lbl.32.1354867162281; Thu,
 06 Dec 2012 23:59:22 -0800 (PST)
Received: by 10.114.20.137 with HTTP; Thu, 6 Dec 2012 23:59:22 -0800 (PST)
In-Reply-To: <1354856737-28678-3-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
        <1354856737-28678-3-git-send-email-sjhill@mips.com>
Date:   Thu, 6 Dec 2012 23:59:22 -0800
Message-ID: <CAJiQ=7DhoP0n0mUfZbq82td1FDKFx_GoAQkW4rC73zLSjf6g8g@mail.gmail.com>
Subject: Re: [PATCH v99,02/13] MIPS: Whitespace clean-ups after microMIPS additions.
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Dec 6, 2012 at 9:05 PM, Steven J. Hill <sjhill@mips.com> wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Clean-up tabs, spaces, macros, etc. after adding in microMIPS
> instructions for the micro-assembler.

My personal preference would be to fix up the whitespace in the
existing code first, then make the new (MM) code follow the convention
from the get-go.

> -struct fp0_format {      /* FPU multipy and add format (MIPS32) */
> +struct fp0_format {    /* FPU multipy and add format (MIPS32) */

"multiply"

> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -73,6 +73,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>         if (cpu_has_dsp)        seq_printf(m, "%s", " dsp");
>         if (cpu_has_dsp2)       seq_printf(m, "%s", " dsp2");
>         if (cpu_has_mipsmt)     seq_printf(m, "%s", " mt");
> +       if (cpu_has_mmips)      seq_printf(m, "%s", " micromips");
>         seq_printf(m, "\n");

This should probably go into a different commit.
