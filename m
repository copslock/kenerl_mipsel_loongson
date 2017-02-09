Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 13:23:12 +0100 (CET)
Received: from mail-ua0-x242.google.com ([IPv6:2607:f8b0:400c:c08::242]:36544
        "EHLO mail-ua0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdBIMXDzuw3V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2017 13:23:03 +0100
Received: by mail-ua0-x242.google.com with SMTP id f2so159994uaf.3;
        Thu, 09 Feb 2017 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PZWchJZETkW13kZz1Hbx37PcRgE8LZteJMyuJHfCqME=;
        b=lAX7637seqG+oq4n/RMqqbXJNc44hire6zH94Cb8TLgEXY0snJnzxq1WerPPEQWagu
         B9v8pOLfePbY0Khc1GCYQJHoYskSO+mOVZq38GJh8vYsdpnfMYMS8sOszysHjVeTp/eH
         0s6F2tHdTj5LKDAeEvf7WbMEiW/MIlRSnp+C/WeqGk08ktJOWJcxqihZ3/z5FkazZ6vd
         HEVklu+pSy4vwEXGIwEyIgPCIeW5t88tIkpXNn4pQ50SCL9cVoAyw5wwbZKHgVvs7uwJ
         8xpcfD91jMAcECFBlKALEPjZAAuSN3XSIpz1FbjxPmn/dVAFhA8PlJXSpJFabX17pg/l
         7eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PZWchJZETkW13kZz1Hbx37PcRgE8LZteJMyuJHfCqME=;
        b=WWYYTCNPppqQivblrZVG6TCKZfWjLJWW7dJbK685GUBlabw2mG+hE5Q/br48JnI/Kg
         m8RqE6ZXRNQocDCXQWXGtPpgZlw5G7w138sQdIoVCH1Kyfzpib5aa9hSGz1lBPpZnmCe
         427vwFwXsYU7MJqc7tO0IK2h2fZKyizXm9OJXzdCnJu4w4F/W2Vs4+DrqfPMj+a3XyfI
         uI//6G/sCEmmW/BbTMmyoevsITTIsBU7YeqaQCRG1Cbg8PIGwMiVjclV/9Hpl7pjBl9K
         f/TEk1Ye177dQ47G1wuQrKU71GIEcz1FalUe2rEao+MxlnsOWlkw7NZRIf8zT4L9INh1
         oHTg==
X-Gm-Message-State: AMke39nFd8q4HDuoZimXwU8OzNwfNRqe3iofggw5eOk+AmC2rBcC9B5FJZigj3T6BVO+iUcT4c8HYKd+ovQkAw==
X-Received: by 10.159.39.4 with SMTP id a4mr1184636uaa.104.1486642978113; Thu,
 09 Feb 2017 04:22:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.3.17 with HTTP; Thu, 9 Feb 2017 04:22:37 -0800 (PST)
In-Reply-To: <1486326077-17091-1-git-send-email-albeu@free.fr>
References: <1486326077-17091-1-git-send-email-albeu@free.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 9 Feb 2017 13:22:37 +0100
Message-ID: <CAOiHx=nwBgVnZp1x2TcDVNx1hA2KYwwQnYSbCsCOJpNo-SLJPg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Allow compressed images to be loaded at the usual address
To:     Alban <albeu@free.fr>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi,

On 5 February 2017 at 21:21, Alban <albeu@free.fr> wrote:
> From: Alban Bedel <albeu@free.fr>
>
> Normally compressed images have to be loaded at a different address to
> allow the decompressor to run. This add an option to let vmlinuz copy
> itself to the correct address from the normal vmlinux address.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  arch/mips/Kconfig                |  8 ++++++++
>  arch/mips/boot/compressed/head.S | 13 +++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde..8074fc5 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2961,6 +2961,14 @@ choice
>                 bool "Extend builtin kernel arguments with bootloader arguments"
>  endchoice
>
> +config ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS
> +       bool "Load compressed images at the same address as uncompressed"
> +       depends on SYS_SUPPORTS_ZBOOT
> +       help
> +         vmlinux and vmlinuz normally have different load addresses, with
> +         this option vmlinuz expect to be loaded at the same address as
> +         vmlinux.
> +
>  endmenu

Okay, it took me a while to understand the intention of this change. I
thought it was for supporting the case that VMLINUZ_LOAD_ADDRESS ==
VMLINUX_LOAD_ADDRESS, but it is indented for  VMLINUZ_LOAD_ADDRESS !=
VMLINUX_LOAD_ADDRESS, but still being loaded at VMLINUX_LOAD_ADDRESS.

So I guess that this can only happen with vmlinuz.bin, as vmlinux's
ELF header will cause it to be loaded at the expected address (for
sane bootloaders at least).

>  config LOCKDEP_SUPPORT
> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index 409cb48..a215171 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -25,6 +25,19 @@ start:
>         move    s2, a2
>         move    s3, a3
>
> +#ifdef CONFIG_ZBOOT_VMLINUZ_AT_VMLINUX_LOAD_ADDRESS

With a bit of BAL trickery you could easily detect this at runtime and
then conditionally copy without requiring any additional config
symbols. Then you aren't limited to being executed from
VMLINUX_LOAD_ADDRESS.

> +       /* Move the text, data section and DTB to the correct address */
> +       PTR_LA  a0, .text
> +       PTR_LI  a1, VMLINUX_LOAD_ADDRESS
> +       PTR_LA  a2, _edata
> +0:
> +       lw      a3, 0(a1)
> +       sw      a3, 0(a0)
> +       addiu   a1, a1, 4
> +       bne     a2, a0, 0b
> +        addiu  a0, a0, 4
> +#endif
> +
>         /* Clear BSS */
>         PTR_LA  a0, _edata
>         PTR_LA  a2, _end

Regards
Jonas
