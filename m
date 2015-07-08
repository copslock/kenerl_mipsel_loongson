Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 20:28:37 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:35237 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010879AbbGHS2f7ZezM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jul 2015 20:28:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 7D7BB28BDA7;
        Wed,  8 Jul 2015 20:28:15 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AD65B28436A;
        Wed,  8 Jul 2015 20:28:12 +0200 (CEST)
Received: by qkbp125 with SMTP id p125so169330223qkb.2;
        Wed, 08 Jul 2015 11:28:24 -0700 (PDT)
X-Received: by 10.55.18.27 with SMTP id c27mr18554955qkh.84.1436380104722;
 Wed, 08 Jul 2015 11:28:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.82.200 with HTTP; Wed, 8 Jul 2015 11:28:05 -0700 (PDT)
In-Reply-To: <1436379071-31574-1-git-send-email-albeu@free.fr>
References: <1436379071-31574-1-git-send-email-albeu@free.fr>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 8 Jul 2015 20:28:05 +0200
Message-ID: <CAOiHx=kDKETVHDeNKM-_7nUZJmWHyPSyUSWfwLtsJA2HG+hV1A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: irq: Remove the include of drivers/irqchip/irqchip.h
To:     Alban Bedel <albeu@free.fr>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Wed, Jul 8, 2015 at 8:11 PM, Alban Bedel <albeu@free.fr> wrote:
> We shouldn't include irqchip.h from outside of the drivers/irqchip
> directory. The irq driver should idealy be there, however this not
> trivial at the moment. We still need to support platforms without DT
> support and the interface to the DDR controller still use a custom
> arch specific API.
>
> For now just redefine the IRQCHIP_DECLARE macro to avoid the cross
> tree include.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>

The define was moved into linux/irqchip.h in
91e20b5040c67c51aad88cf87db4305c5bd7f79d, so all you can/need to do is
...
> ---
>  arch/mips/ath79/irq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
> index afb0096..c5ad737 100644
> --- a/arch/mips/ath79/irq.c
> +++ b/arch/mips/ath79/irq.c
> @@ -17,7 +17,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_irq.h>
> -#include "../../../drivers/irqchip/irqchip.h"
>
>  #include <asm/irq_cpu.h>
>  #include <asm/mipsregs.h>

this removal ;)


Jonas
