Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jun 2013 11:00:24 +0200 (CEST)
Received: from mail-wi0-f171.google.com ([209.85.212.171]:61101 "EHLO
        mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823098Ab3FQJAMfKRBh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jun 2013 11:00:12 +0200
Received: by mail-wi0-f171.google.com with SMTP id hj3so2028016wib.16
        for <multiple recipients>; Mon, 17 Jun 2013 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LRFVyf2BoajjG0XiVLgRECVKilToUwdWc4lvZp4quic=;
        b=COGs/e3MrAmnduJjk0rDQGND8RUgcb6o5z7Qphgrv2dDTcfI05R5otDSFVQxjox4sn
         RgPwqNZMDqA3u3Q0hWJjh4ojv1Hkxgbs6K82qnpuJ3MaVn3/cwtoZ+6LpCAGPxnxG9tu
         eGAbOTnIe4EpqE0MQ1ytzWw69bFhcCZz8/6LTBp9sd/J+1OnW64QIKRKsknAGkLzBNwS
         q89evfXDDhgF7URjTB3dtEhKedRfhfSrc/4kcJlrOAn/TFFtwaJuXdN4vcH4dtmlHDyB
         0ZnFeJBtUvhxeyeVDY+R1KBlk8V5vZvdh8xSjCvZsaYYrQyI+LrdfNvjw/amYaajcff/
         Y0Bw==
X-Received: by 10.180.198.10 with SMTP id iy10mr4356124wic.29.1371459606272;
 Mon, 17 Jun 2013 02:00:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.136.115 with HTTP; Mon, 17 Jun 2013 01:59:26 -0700 (PDT)
In-Reply-To: <1371328124-29926-1-git-send-email-jchandra@broadcom.com>
References: <1371328124-29926-1-git-send-email-jchandra@broadcom.com>
From:   Markos Chandras <markos.chandras@gmail.com>
Date:   Mon, 17 Jun 2013 09:59:26 +0100
Message-ID: <CAG2jQ8gEfkQ2bahnH-iAedUatA5=CB3_L2sX-OGO+nF+BqkiPg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix include guard macro in uapi/asm/fcntl.h
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@gmail.com
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

On 15 June 2013 21:28, Jayachandran C <jchandra@broadcom.com> wrote:
> The commit d7f15bb42274a12ac95c237d6d9cb46b691881fa
> "MIPS: <uapi/asm/fcntl.h>: Don't reference CONFIG_* symbols."
> in linux-mips.org master, causes userspace to break:
>
> udevd[324]: error getting socket: Invalid argument
> udevd[324]: error initializing udev control socket
>
> This is because the include guard in asm/fcntl.h is the same as the one
> in uapi/asm/fcntl.h Fix the issue by using _UAPI_ASM_FCNTL_H as include
> guard in the uapi file.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> [ I don't see the same commit in kernel.org git. If the patch are not
>  yet sent upstream - then this change can be merged to the commit
>  d7f15bb]
>
>
>  arch/mips/include/uapi/asm/fcntl.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
> index 898b953..97e56a5 100644
> --- a/arch/mips/include/uapi/asm/fcntl.h
> +++ b/arch/mips/include/uapi/asm/fcntl.h
> @@ -5,8 +5,8 @@
>   *
>   * Copyright (C) 1995, 96, 97, 98, 99, 2003, 05 Ralf Baechle
>   */
> -#ifndef _ASM_FCNTL_H
> -#define _ASM_FCNTL_H
> +#ifndef _UAPI_ASM_FCNTL_H
> +#define _UAPI_ASM_FCNTL_H
>
>
>  #define O_APPEND       0x0008
> @@ -50,4 +50,4 @@
>
>  #include <asm-generic/fcntl.h>
>
> -#endif /* _ASM_FCNTL_H */
> +#endif /* _UAPI_ASM_FCNTL_H */
> --
> 1.7.9.5
>
>
>

Looks good to me

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

--
Regards,
Markos Chandras
