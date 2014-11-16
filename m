Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 02:50:59 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38511 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013700AbaKPBuzDqudB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 02:50:55 +0100
Received: by mail-ig0-f177.google.com with SMTP id uq10so2228569igb.10
        for <multiple recipients>; Sat, 15 Nov 2014 17:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uBh7PvRfotsMr48gs+37KUTkkmJIVowiArSiaXcceRU=;
        b=tkGHjHzYIuH3wO2RbmIZgUPBgGVy5E6d9qarojiJT0Mfg8gwxG86OfVQGk1/HbP9uh
         GrdinWzQ7awKo4W+euNqssI9h7OSdqhmR/GeDehLkFZJGmXMWRXNBg6cKCE1BFXJDmXm
         vyPHa+W5NV7cRcxzAmbruI+qkCiBhIzf5UuS94lQuD/Mjveo91cWqXC9d9Q9hO1D1vnP
         eqrPbck9XmY6fHTS1PtCp+T3e2obpdN/EIq1u5BuYEkM2YTxgxa3KNc1Y9NVd0g73yqv
         HEAkrQfZWHrmlV622zCU4X0Afg19T8ZsJ/ZPtht0GSsKzjlErCUxC0JkuH2eqKFS/t2N
         /saw==
MIME-Version: 1.0
X-Received: by 10.51.16.37 with SMTP id ft5mr16339512igd.6.1416102648929; Sat,
 15 Nov 2014 17:50:48 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Sat, 15 Nov 2014 17:50:48 -0800 (PST)
In-Reply-To: <1415771234-6364-1-git-send-email-chenhc@lemote.com>
References: <1415771234-6364-1-git-send-email-chenhc@lemote.com>
Date:   Sun, 16 Nov 2014 09:50:48 +0800
X-Google-Sender-Auth: gLAfrzn_-nu2txobcbxrETWX7RY
Message-ID: <CAAhV-H7qc_LChc8k8-RG9VsXm2MG55fOnxD37XAu2veZmDoqoQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix a copy & paste error in unistd.h
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44215
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

It seems like this patch is missing during rebase.

Huacai

On Wed, Nov 12, 2014 at 1:47 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Commit 5df4c8dbbc (MIPS: Wire up bpf syscall.) break the N32 build
> because of a copy & paste error.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/uapi/asm/unistd.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> index 9dc5856..d001bb1 100644
> --- a/arch/mips/include/uapi/asm/unistd.h
> +++ b/arch/mips/include/uapi/asm/unistd.h
> @@ -1045,7 +1045,7 @@
>  #define __NR_seccomp                   (__NR_Linux + 316)
>  #define __NR_getrandom                 (__NR_Linux + 317)
>  #define __NR_memfd_create              (__NR_Linux + 318)
> -#define __NR_memfd_create              (__NR_Linux + 319)
> +#define __NR_bpf                       (__NR_Linux + 319)
>
>  /*
>   * Offset of the last N32 flavoured syscall
> --
> 1.7.7.3
>
