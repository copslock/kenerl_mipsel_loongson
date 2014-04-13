Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2014 10:13:20 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:64086 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900AbaDMINR4OtZ2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Apr 2014 10:13:17 +0200
Received: by mail-la0-f43.google.com with SMTP id e16so4730711lan.2
        for <multiple recipients>; Sun, 13 Apr 2014 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SJK8yWIO5bZXeSekpyi4k+GqDsLCw4g+JcuwDfQudao=;
        b=clwqIQuvVvoF2D8wdgPYiVRzmB4dWqbbOzJOPH5qJw7RXFsqVdJ9hvruLxVCDFetz7
         UMJ3SwUqdRhzzlCfHQUY5Sqr/BWpksT8XhhMdmzlT3zPPp1i7iQkNMUvRCnaDjAGBV4D
         T8rks1N64bEluYkLfpgovMt9K5TY8tWPmsWpsEye6+XJaHdCvnbpsVquTOevJhDrDyai
         WzJhjC6t5L0ak4dd+gU0chqVyTiUpn6hC10Iy2TB0qPWpi4pcRsH+vW8FUe/65ha0yfU
         WUTI/1iQn99QKYao3UVL1o4OLm/Pl90Y8ZOJoYd261gvcMlnXgFKndU6zHaGLO4zQOiF
         uzDA==
MIME-Version: 1.0
X-Received: by 10.152.1.8 with SMTP id 8mr24165213lai.1.1397376792350; Sun, 13
 Apr 2014 01:13:12 -0700 (PDT)
Received: by 10.152.198.166 with HTTP; Sun, 13 Apr 2014 01:13:12 -0700 (PDT)
In-Reply-To: <1397228303-7689-1-git-send-email-Steven.Hill@imgtec.com>
References: <1397228303-7689-1-git-send-email-Steven.Hill@imgtec.com>
Date:   Sun, 13 Apr 2014 10:13:12 +0200
X-Google-Sender-Auth: 6frfZ2ARzguuA61uwsVU0nSUBx0
Message-ID: <CAMuHMdV=WWE1iWG5M0-+nE+EOrdjnC8adbYqL+2hWF1_1Oj9MA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add microMIPS MSA support.
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Stephen,

On Fri, Apr 11, 2014 at 4:58 PM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -273,7 +273,12 @@
>         .macro  cfcmsa  rd, cs
>         .set    push
>         .set    noat
> +#ifdef CONFIG_CPU_MICROMIPS
> +       .insn
> +       .word   0x587e0056 | (\cs << 11)
> +#else
>         .word   0x787e0059 | (\cs << 11)
> +#endif

Personally, I would like it more if you would use the CFCMSA_INSN
macro in the code above. This allows to get rid of all but one #ifdef,
and avoids mistakes in the parameter parts (e.g. "| (\cs << 11)").

> diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
> index a2aba6c..fd76b3b 100644
> --- a/arch/mips/include/asm/msa.h
> +++ b/arch/mips/include/asm/msa.h
> @@ -96,6 +96,13 @@ static inline void write_msa_##name(unsigned int val)                \
>   * allow compilation with toolchains that do not support MSA. Once all
>   * toolchains in use support MSA these can be removed.
>   */
> +#ifdef CONFIG_CPU_MICROMIPS
> +#define CFCMSA_INSN    0x587e0056
> +#define CTCMSA_INSN    0x583e0816
> +#else
> +#define CFCMSA_INSN    0x787e0059
> +#define CTCMSA_INSN    0x783e0819
> +#endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
