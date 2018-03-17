Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Mar 2018 12:44:07 +0100 (CET)
Received: from forward100o.mail.yandex.net ([37.140.190.180]:46762 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994657AbeCQLoA19AjM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Mar 2018 12:44:00 +0100
Received: from mxback19j.mail.yandex.net (mxback19j.mail.yandex.net [IPv6:2a02:6b8:0:1619::95])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 959792A24E53
        for <linux-mips@linux-mips.org>; Sat, 17 Mar 2018 14:43:54 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback19j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fLeDDWEG2t-hsqOjd2Z;
        Sat, 17 Mar 2018 14:43:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521287034;
        bh=ezIo7mlNks2QadI+fE/2vSq+a1SC62ujYrCISd8lXB0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References;
        b=J+xc9QJ5eZHrc2CIerg3De7N3hySxrI/oXYdLvh73cFkxZxbyrWgyIc4www7kpbZI
         f21anVoUSerc4XMQ6rQpG6JuxqBu8jx14a3ZVqvAfzCUNFAVxU67ejbtL2SpAH1cvL
         Pgty6ffxwr+5+y6IVVrNYgGOCjjDi6R70OSu+g+k=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id mnpNemM9Xq-hqQeuIbQ;
        Sat, 17 Mar 2018 14:43:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521287033;
        bh=ezIo7mlNks2QadI+fE/2vSq+a1SC62ujYrCISd8lXB0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References;
        b=T68FZ9p5PlsbF+2IY4CNjSKZzn//4KpM6TVspWMz5OE6gaGQ60QlCVs1gfPJmAMbt
         +6iFgNAW0VIkPKYlx1WoH60Naw7wGvBepUYRjzCsHwu/jh33o0JNAX1FkJ+R722HT9
         eMNLpvVP3faY3MJyeDdUQIYCIwr3Y87LtD8alW1s=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1521287028.20119.2.camel@flygoat.com>
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@linux-mips.org
Date:   Sat, 17 Mar 2018 19:43:48 +0800
In-Reply-To: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

在 2018-03-16五的 15:55 +0800，Huacai Chen写道：
> Call __stack_chk_guard_setup() in decompress_kernel() is too late
> that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
> 
> Original code comes from ARM but also used for MIPS and SH, so fix
> them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
> 
> V2: Fix build on ARM.
> V3: Fix build on SuperH.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

It works fine on MIPS(Loongson-3A3000) and arm (Allwinner H3)
platforms.

Thanks!
> ---
>  arch/arm/boot/compressed/head.S        | 4 ++++
>  arch/arm/boot/compressed/misc.c        | 7 -------
>  arch/mips/boot/compressed/decompress.c | 7 -------
>  arch/mips/boot/compressed/head.S       | 4 ++++
>  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
>  arch/sh/boot/compressed/head_64.S      | 4 ++++
>  arch/sh/boot/compressed/misc.c         | 7 -------
>  7 files changed, 20 insertions(+), 21 deletions(-)
> 
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>
