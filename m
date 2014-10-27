Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 23:30:05 +0100 (CET)
Received: from mail-qg0-f41.google.com ([209.85.192.41]:65514 "EHLO
        mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011058AbaJ0WaC5-Cui (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 23:30:02 +0100
Received: by mail-qg0-f41.google.com with SMTP id q107so2560400qgd.14
        for <multiple recipients>; Mon, 27 Oct 2014 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5h+IuidmHwo8DU7hz8APS4mbhQaKKRrENDM87U7gmgs=;
        b=ez/m80o0xYk/5fZsvaDnp8RyZAplSQoDBuFdWu1WfiTr2BqdvpDR5iHkTX0hEUXcNK
         DozjZ2nZ8Ubz6HPJb6bE6QCRbnxvzm5Y2NQybcL4k5xvNoyIhbgE455R7ezwmKkchVQS
         zyHMVK8N7LtVc8D4lDCU/UUf7ikvCbaSAm2oTPafg2Z8arV92Xua4sHJnl1SQCB3gvBH
         xWf9igB1R2e+hQvq3wNkzY2DGVbIdWVz+0bV/LNV/eMHVIb9XNdEKovyX4TyT/CJ2C04
         p7sLoUhOkogCKT4ur2lz7bfsQ5P6UhRpkg/aWvxP9PkFwwMSjT04RYI8WpSfJn3H0DTf
         L9Ng==
X-Received: by 10.140.91.87 with SMTP id y81mr22855710qgd.52.1414448996919;
 Mon, 27 Oct 2014 15:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 27 Oct 2014 15:29:36 -0700 (PDT)
In-Reply-To: <1414445904-4781-3-git-send-email-abrestic@chromium.org>
References: <1414445904-4781-1-git-send-email-abrestic@chromium.org> <1414445904-4781-3-git-send-email-abrestic@chromium.org>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 27 Oct 2014 15:29:36 -0700
Message-ID: <CAJiQ=7Bk4jiByynau2nR_BO6o5Rg3LpumNpDOpb=UQaYQCSknQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip: mips-gic: Use __raw_{readl,writel} for GIC registers
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Oct 27, 2014 at 2:38 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> No byte swapping is necessary for accessing the GIC registers.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  drivers/irqchip/irq-mips-gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 61ac482..7ec3c18 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -37,12 +37,12 @@ static void __gic_irq_dispatch(void);
>
>  static inline unsigned int gic_read(unsigned int reg)
>  {
> -       return readl(gic_base + reg);
> +       return __raw_readl(gic_base + reg);
>  }
>
>  static inline void gic_write(unsigned int reg, unsigned int val)
>  {
> -       writel(val, gic_base + reg);
> +       __raw_writel(val, gic_base + reg);
>  }

Hi Andrew,

I just ran into a related problem on bcm3384, a big-endian platform on
which readl/writel perform extra endian swaps (CONFIG_SWAP_IO_SPACE).
My solution was twofold:

 - Change the irq_reg_{readl,writel} macros so that they can be
configured to use the __raw_ variants on individual platforms

 - Use irq_reg_{readl,writel} instead of directly invoking
__raw_{readl,writel} in our irqchip driver, so that the irqchip driver
code always uses the same I/O accessors as the helper functions we're
using from kernel/irq/generic-chip.c

The two commits are posted here:

https://github.com/cernekee/linux/commit/52923b7bbaf99385a813a6f54de6ff810e11638c
https://github.com/cernekee/linux/commit/371f990bd1b9e980ffbea63f6375d13156f3e731

I haven't submitted them yet since they need to be retested on our LE platforms.

Do you think a similar approach might be suitable for the irq-mips-gic driver?
