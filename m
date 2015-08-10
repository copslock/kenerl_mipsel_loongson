Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 20:11:29 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:62020 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010789AbbHJSL1MzBvK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Aug 2015 20:11:27 +0200
Received: from tock (unknown [85.176.44.210])
        (Authenticated sender: albeu)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4A6BB82291;
        Mon, 10 Aug 2015 20:04:58 +0200 (CEST)
Date:   Mon, 10 Aug 2015 20:11:14 +0200
From:   Alban <albeu@free.fr>
To:     Alexander Couzens <lynxis@fe80.eu>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: ath79: set irq ACK handler for
 ar7100-misc-intc irq chip
Message-ID: <20150810201114.468748de@tock>
In-Reply-To: <1438857805-18443-1-git-send-email-lynxis@fe80.eu>
References: <1438857805-18443-1-git-send-email-lynxis@fe80.eu>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Thu,  6 Aug 2015 12:43:24 +0200
Alexander Couzens <lynxis@fe80.eu> wrote:

A log message would be nice. IMHO it should mention that the ACK
callbacks have been missed when introducing OF support.

> Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
> ---
>  arch/mips/ath79/irq.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/ath79/irq.c b/arch/mips/ath79/irq.c
> index afb0096..dc76fa1 100644
> --- a/arch/mips/ath79/irq.c
> +++ b/arch/mips/ath79/irq.c
> @@ -303,13 +303,20 @@ static int __init ath79_misc_intc_of_init(
>  	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
>  	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
>  
> -

I would prefer to see this in another patch.


[...]

Alban
