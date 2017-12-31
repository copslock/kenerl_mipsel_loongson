Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Dec 2017 12:17:54 +0100 (CET)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:35967
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990428AbdLaLRqQRRpe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Dec 2017 12:17:46 +0100
Received: by mail-wr0-x242.google.com with SMTP id u19so38513871wrc.3
        for <linux-mips@linux-mips.org>; Sun, 31 Dec 2017 03:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NdO+yV7BdmTLmYw67nv8JTnCI7xlNXd9RC4Nx5LaCwA=;
        b=UQ7o2bzjoI1LLPntDx1KFPq2a8rmjomyFeYAP3wxf+Ti9hv1z1cUxUFAB9Pbq1JkHd
         kzTO24XDcdsli8HELCJIbr2zd0lwUtwjMCp4F0zYuX1qPq98ECAOnckxxQwmmG9VYRMU
         L3M+xCH5E1PyWtD21xUh8BEEWAmZsN0fh7ARAKe9FrZekMeR+7/f7kLFDc1EdzfKolx1
         3TAiq9+Qwp8U6QN488YK7bqw4dvFj1BknZt6CB0rEDOQ+KUCsB7BwNlxW4vlgerwbXQu
         ivletE0J1ZDGh32QfNJZJt/L+sBsNfsy74W9xXZWtNzHIzxVZo/2DH6w97SKXiRcw5Kw
         8NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NdO+yV7BdmTLmYw67nv8JTnCI7xlNXd9RC4Nx5LaCwA=;
        b=KGiZxjX3Kri+nW/40QzACyRooLOccV/OlQCvbOo4a0FrMQIac6LoQLpPTWJyrLWueW
         mtqhimElb9W6Jes+O0EBRFDlAmM6ujUS/cedjMmQYnQnkFZp9/raHOc5QTS0hDBWuP9P
         hFJPdveXV6mrBKB3FTJXE/vj3G3NoRG6pafuAKqTv6S9F/z68Yh/9N7OPAWCdmoqWb3a
         QieQ3ftk4UQt2zUVLslkMDPG/roFlb1G7iC8Y/fbnZKZTbRXZStr3SoqVTFXSkWVX4SE
         mL3rtiOxiti6SEhF4yySklVKCN9vS5KqdwyBieo5P/iFp6uu1KryYTL1tuQf2YLNWxIZ
         jvHw==
X-Gm-Message-State: AKGB3mKohnPBoCzOJJLXTiU7S+9wKjVTLZvPFIVlm++KMM9M+Py0CRLB
        K2K5GDvIxP+PbLvLOdJJq0wtNw5tcvFkNKOqkCi8XQ==
X-Google-Smtp-Source: ACJfBotnYcyIRY3QG1iyD/F9TG315xjvmyrMnkjmTcp1/AucbvrpJne21c95zn7H4mZ7p4GBI9yihDWVCjthtdJj0Jk=
X-Received: by 10.223.191.2 with SMTP id p2mr25751736wrh.81.1514719060679;
 Sun, 31 Dec 2017 03:17:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.206 with HTTP; Sun, 31 Dec 2017 03:17:00 -0800 (PST)
In-Reply-To: <20171230182830.6496-2-jiaxun.yang@flygoat.com>
References: <20171226132339.7356-1-jiaxun.yang@flygoat.com>
 <20171230182830.6496-1-jiaxun.yang@flygoat.com> <20171230182830.6496-2-jiaxun.yang@flygoat.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Sun, 31 Dec 2017 12:17:00 +0100
Message-ID: <CAOFm3uFM+7n_YaKBkZV6jV4VHCBhtGhUTLbB4uedMaCa+nf3PA@mail.gmail.com>
Subject: Re: [PATCHv2 1/8] MIPS: Loongson64: cleanup all cs5536 files to use
 SPDX Identifier
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

On Sat, Dec 30, 2017 at 7:28 PM, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> To reduce unnecessary license text.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/loongson64/common/cs5536/Makefile       | 1 +
>  arch/mips/loongson64/common/cs5536/cs5536_acc.c   | 6 ++----
>  arch/mips/loongson64/common/cs5536/cs5536_ehci.c  | 6 ++----
>  arch/mips/loongson64/common/cs5536/cs5536_ide.c   | 6 ++----
>  arch/mips/loongson64/common/cs5536/cs5536_isa.c   | 6 ++----
>  arch/mips/loongson64/common/cs5536/cs5536_mfgpt.c | 6 ++----
>  arch/mips/loongson64/common/cs5536/cs5536_ohci.c  | 6 ++----
>  arch/mips/loongson64/common/cs5536/cs5536_pci.c   | 7 ++-----
>  8 files changed, 15 insertions(+), 29 deletions(-)
>
> diff --git a/arch/mips/loongson64/common/cs5536/Makefile b/arch/mips/loongson64/common/cs5536/Makefile
> index f12e64007347..b0c805a0dcc6 100644
> --- a/arch/mips/loongson64/common/cs5536/Makefile
> +++ b/arch/mips/loongson64/common/cs5536/Makefile
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
>  #
>  # Makefile for CS5536 support.
>  #
> diff --git a/arch/mips/loongson64/common/cs5536/cs5536_acc.c b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> index ab4d6cc57384..ba0474bb4a3d 100644
> --- a/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> +++ b/arch/mips/loongson64/common/cs5536/cs5536_acc.c
> @@ -1,3 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
>  /*
>   * the ACC Virtual Support Module of AMD CS5536
>   *
> @@ -7,10 +9,6 @@
>   * Copyright (C) 2009 Lemote, Inc.
>   * Author: Wu Zhangjin, wuzhangjin@gmail.com
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under  the terms of the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>   */

Did you CC the original authors? You would need their signoff or at
least an ack IMHO
-- 
Cordially
Philippe Ombredanne
