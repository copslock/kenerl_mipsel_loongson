Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jul 2016 16:02:49 +0200 (CEST)
Received: from mail-io0-f193.google.com ([209.85.223.193]:33990 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992585AbcGQOCmIcbbK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jul 2016 16:02:42 +0200
Received: by mail-io0-f193.google.com with SMTP id g86so9343299ioj.1;
        Sun, 17 Jul 2016 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vCyzfv76QrQ1ecyP+nKuMmKjFF1B4uSwrMbVxcc4n44=;
        b=o2hHsayp1b0i4bkuVsXi+Wm4PAVzYcGCQ2pQGzcytWqXQllld5HGSdf2uUrAg8CUAH
         gFP5jdALFOZJ0L5FEQnGkar0YY0KoTXCp/hlE1JMuXDCbLAMxMmZ/DRd1MpxhtdcUXec
         YlNym/jO2Z2jiTCmbFxKB8gNxpOADSh4+kE9Cqvbd50qL0KaAsXzZwjcyFnXfe58J48B
         fSLzBJUFtgDlbm//Q9azSvGQKF3dct1Ds6B8+nmSjkg80G8gOz2QWK10X5wi/m6thU6J
         +uaAn/xhENWGZC8cUdDL60iaPyo4xZOR/GgxNwbK+XAAs02OR4xNcVWF8h/kUXL+I21L
         fmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vCyzfv76QrQ1ecyP+nKuMmKjFF1B4uSwrMbVxcc4n44=;
        b=EAGIX049oO09908iBdqDoUDKO0P3380rrqr4EcaTEUIbHkb7IHyasteHwKglEGDg5t
         UgH48Y3mvBuWWgKF7hCFCK+XAZnbZn9/dwjsYfKtEXgBAbEKiidxamPQij6oEVTipvMn
         TXPMH4Aioed5IckBZIUg0yumfrP28BL+oB4xBFvEpR7sdDhV6kMkBim6E6hNHAVR03Lz
         EngIqZ/n6YIkohRT9f16st/sMr9WIhd8p4kIaoWBZ4TccROS4Gb398kVv0Jk9F8g8EF+
         tODjuz+LptoZICeI+NIqtnk244rTwpb3p6Vy7X2vKMpBuSvUac2vJU5z7F/aW6F0jBfs
         eClQ==
X-Gm-Message-State: ALyK8tI5wkQfwXqmsxm9TlfJc5vamBVA2Y+W8iDffD1mPATUudvIC8lwg+CbdCUF9WdPTcumJpj2FIr78sg7tg==
X-Received: by 10.107.152.149 with SMTP id a143mr17611047ioe.193.1468764156156;
 Sun, 17 Jul 2016 07:02:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.94.136 with HTTP; Sun, 17 Jul 2016 07:02:35 -0700 (PDT)
In-Reply-To: <1468292170-22812-233-git-send-email-sasha.levin@oracle.com>
References: <1468292170-22812-1-git-send-email-sasha.levin@oracle.com> <1468292170-22812-233-git-send-email-sasha.levin@oracle.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sun, 17 Jul 2016 22:02:35 +0800
X-Google-Sender-Auth: tQnGJpnsOpTF9K-iorIn-QaZ8v4
Message-ID: <CAAhV-H5JMQhz1v4UJZG+P6sTS2_OQJV00wTkDHSQHkeX=KroBA@mail.gmail.com>
Subject: Re: [added to the 4.1 stable tree] MIPS: Reserve nosave data for hibernation
To:     Sasha Levin <sasha.levin@oracle.com>
Cc:     stable <stable@vger.kernel.org>, stable-commits@vger.kernel.org,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <sjhill@realitydiluted.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54345
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

Hi, Sasha,

This patch should only be added to 4.2+.

Huacai

On Tue, Jul 12, 2016 at 10:55 AM, Sasha Levin <sasha.levin@oracle.com> wrote:
> From: Huacai Chen <chenhc@lemote.com>
>
> This patch has been added to the 4.1 stable tree. If you have any
> objections, please let us know.
>
> ===============
>
> [ Upstream commit a95d069204e178f18476f5499abab0d0d9cbc32c ]
>
> After commit 92923ca3aacef63c92d ("mm: meminit: only set page reserved
> in the memblock region"), the MIPS hibernation is broken. Because pages
> in nosave data section should be "reserved", but currently they aren't
> set to "reserved" at initialization. This patch makes hibernation work
> again.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Steven J . Hill <sjhill@realitydiluted.com>
> Cc: Fuxin Zhang <zhangfx@lemote.com>
> Cc: Zhangjin Wu <wuzhangjin@gmail.com>
> Cc: linux-mips@linux-mips.org
> Cc: stable@vger.kernel.org
> Patchwork: https://patchwork.linux-mips.org/patch/12888/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  arch/mips/kernel/setup.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index be73c49..49b5203 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -686,6 +686,9 @@ static void __init arch_mem_init(char **cmdline_p)
>         for_each_memblock(reserved, reg)
>                 if (reg->size != 0)
>                         reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
> +
> +       reserve_bootmem_region(__pa_symbol(&__nosave_begin),
> +                       __pa_symbol(&__nosave_end)); /* Reserve for hibernation */
>  }
>
>  static void __init resource_init(void)
> --
> 2.5.0
>
>
