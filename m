Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2017 04:24:57 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:33839
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbdHUCYqo8OkC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2017 04:24:46 +0200
Received: by mail-io0-x241.google.com with SMTP id p141so2570652iop.1;
        Sun, 20 Aug 2017 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=L4G9PAfzE3hHiMIMZxVBehOTm8qw2HSMUj/89X6+uYA=;
        b=G3j63dAfn54ib2xjnQVAc1AEXN0rWPaaBKc4kAfvH9Ud2eDLHqdjCx5rTW2B2y5v6Z
         dZ2Gbkxsn0Bo7PlIclrT1x1WJr6gaeF/GYm1O2bzFCv2oZUiW6tJgJD7WKaUImlO0eiX
         ZpTPTXU/gJvy1WnPkhFuHSobA/zue+wCrGlow7gHrseWlf1XYx5tPsaWX1oPy8/Kzr0G
         9r5RWr1HCrs0/ib8eCJKUBVaG/YUOZBnv+aZgbTNVshQb1MV3C6HzLaU1W+0TtCvgQUg
         fhMjM40VXANpWTi22eH+PXHoCB8hcRrVy6CctB+zjaldNWNZ6DgpCjToLkHuuH+PdjFg
         1WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=L4G9PAfzE3hHiMIMZxVBehOTm8qw2HSMUj/89X6+uYA=;
        b=S+0vg//OkGikh6Uq+M9ojJWeKMBsWIpJGW6+i+yZgegGeWbcB+pOgsNBsV7vbdV7OG
         zVLmR+J4ITT1hkcwQ/HAW5hpYiY2Y8mfJcvPL7rARYfHSPczVDFhliHlOh0qUPJ42bzL
         k90Z42fxtFw/TVpyO5SJ93Nu14/KFyBjBwr2uxtEcuVDlYXZj56kgI1knhGONUQ19s/6
         jrc8rklKQQfy/VKoHaMg0qM907x+zSxSSBL5FUmwYzkaC85/DDDYfK78ZyLFn5zMyIi6
         1DXhp90C0/cTNPO7/j2mikpWIGyK31f2wv7TPA5R9N9l3pgw9YNKKRbKN4TMYcL9dtsw
         TifA==
X-Gm-Message-State: AHYfb5jdqiJBuyzprrhR+JlTme4awZvkJ04azkNDqa39P/nH/Y8OjBEh
        ZM6+bE9Fut4N81ClZTnUuEdlITHV+g==
X-Received: by 10.107.58.8 with SMTP id h8mr13872784ioa.22.1503282280228; Sun,
 20 Aug 2017 19:24:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.183.75 with HTTP; Sun, 20 Aug 2017 19:24:39 -0700 (PDT)
In-Reply-To: <lsq.1503062000.223402560@decadent.org.uk>
References: <lsq.1503061998.818387115@decadent.org.uk> <lsq.1503062000.223402560@decadent.org.uk>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 21 Aug 2017 10:24:39 +0800
X-Google-Sender-Auth: FJyDWwaD_PozqNezZBj6uNtSYrM
Message-ID: <CAAhV-H5r8Mv8YjBBBooXc4zmaZkNq9MHBpxtTZ4V-YozC8w4xQ@mail.gmail.com>
Subject: Re: [PATCH 3.16 032/134] MIPS: Loongson-3: Select MIPS_L1_CACHE_SHIFT_6
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, akpm@linux-foundation.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59718
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

3.16 doesn't need this, because 3.16 doesn't support Loongson-3 R2/R3.

Huacai

On Fri, Aug 18, 2017 at 9:13 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> 3.16.47-rc1 review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Huacai Chen <chenhc@lemote.com>
>
> commit 17c99d9421695a0e0de18bf1e7091d859e20ec1d upstream.
>
> Some newer Loongson-3 have 64 bytes cache lines, so select
> MIPS_L1_CACHE_SHIFT_6.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
> Cc: Fuxin Zhang <zhangfx@lemote.com>
> Cc: Zhangjin Wu <wuzhangjin@gmail.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/15755/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> [bwh: Backported to 3.16: adjust context]
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1193,6 +1193,7 @@ config CPU_LOONGSON3
>         select CPU_SUPPORTS_HUGEPAGES
>         select WEAK_ORDERING
>         select WEAK_REORDERING_BEYOND_LLSC
> +       select MIPS_L1_CACHE_SHIFT_6
>         help
>                 The Loongson 3 processor implements the MIPS64R2 instruction
>                 set with many extensions.
>
>
