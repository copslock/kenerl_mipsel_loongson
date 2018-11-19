Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 16:52:17 +0100 (CET)
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43506 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993136AbeKSPwC1zh0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 16:52:02 +0100
Received: by mail-qk1-f193.google.com with SMTP id r71so49271648qkr.10;
        Mon, 19 Nov 2018 07:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+5bJn4B66njPBzARi8LUL9emGuyKZAzXJwIQjlDvtM=;
        b=dKYEnQrgHc5GjxFAg1owVMFBrbH3UcJhvMNN0NWuQqorSAQoYV0Gqlh1OLiTw0Piko
         qQe4i9IT9Qs4g8dVUzAluiPo/gVnauKPgEWB90ifuLwXIvujvB1wP5sfjq3/HclRqynH
         vXp+oVAC5dpkNRxnj0tod7v9u7Y5EZNyQcXWY5teHodHYzHvHyziPN126iRv8gPlm2/W
         JVxm+/0UayxB8UfC3YKyU1IXiHcZDpwsVpacP7EbqFHhk8/xZYpyYwrk9FTqF7jEm0kl
         zQBpJzMOCT1ppGgMo8//9csu4Y2UrQGFsLEy0k/ajin147Ojg+RNK9OlR5fXLWGXXp8J
         MOSw==
X-Gm-Message-State: AGRZ1gKO4Po6mPiz2duAQ6JJdC9SJ2O5fRSkDJuZ90ZXhhsDEEJCUf+M
        kwQ72jehaijT3lfemlJX/PvDHA9PhmlfLAlhlUM=
X-Google-Smtp-Source: AJdET5cHmp/1dPcEYWWI7tbPZ6Do3MOei8PyXIbAgc68MwufxSav+3VqTvU3aV64CpGFlwtyfyVVC8eiHkrFWwRpg40=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr21441655qvk.40.1542642721554;
 Mon, 19 Nov 2018 07:52:01 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-2-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 16:51:44 +0100
Message-ID: <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, Nov 15, 2018 at 7:14 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The 2nd option will be the recommended one. For that, I
> added the __NR_syscalls macro in uapi/asm/unistd.h along
> with __NR_Linux_syscalls. The macro __NR_syscalls also
> added for making the name convention same across all
> architecture. While __NR_syscalls isn't strictly part of
> the uapi, having it as part of the generated header to
> simplifies the implementation. We also need to enclose
> this macro with #ifdef __KERNEL__ to avoid side effects.

I fear this doesn't work the way you hoped:

> --- a/arch/mips/include/uapi/asm/unistd.h
> +++ b/arch/mips/include/uapi/asm/unistd.h
> @@ -391,16 +391,19 @@
>  #define __NR_rseq                      (__NR_Linux + 367)
>  #define __NR_io_pgetevents             (__NR_Linux + 368)
>
> +#ifdef __KERNEL__
> +#define __NR_syscalls                  368
> +#endif

We now have three different definitions of __NR_syscalls,
one for each ABI. User space previously saw the correct
one (now it doesn't see any, but that's ok).

>  /*
>   * Offset of the last Linux o32 flavoured syscall
>   */
> -#define __NR_Linux_syscalls            368
> +#define __NR_Linux_syscalls            __NR_syscalls

so this part part again is ok.

>  #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
>
>  #define __NR_O32_Linux                 4000
> -#define __NR_O32_Linux_syscalls                368
> +#define __NR_O32_Linux_syscalls                __NR_syscalls

but this part is not: Now __NR_O32_Linux_syscalls is defined
to __NR_syscalls, which may be one of the three values.
Any usage of __NR_O32_Linux_syscalls in a 64-bit kernel
is then clearly wrong.

>  #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
>
>  #define __NR_N32_Linux                 6000
> -#define __NR_N32_Linux_syscalls                332
> +#define __NR_N32_Linux_syscalls                __NR_syscalls

Same for this one.

       Arnd
