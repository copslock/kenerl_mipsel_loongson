Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 16:48:50 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:65210 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901165Ab2IBOsm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 16:48:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 676FC78D;
        Sun,  2 Sep 2012 16:48:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id LddwGxuBLPtn; Sun,  2 Sep 2012 16:48:36 +0200 (CEST)
Received: from [192.168.178.21] (ppp-88-217-76-199.dynamic.mnet-online.de [88.217.76.199])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 2733C78C;
        Sun,  2 Sep 2012 16:48:36 +0200 (CEST)
Message-ID: <504371CE.2040707@metafoo.de>
Date:   Sun, 02 Sep 2012 16:48:46 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120724 Icedove/3.0.11
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH 1/3] MIPS: JZ4740: Break circular header dependency
References: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de> <1346579550-5990-2-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1346579550-5990-2-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/02/2012 11:52 AM, Thierry Reding wrote:
> When including irq.h, arch/mips/jz4740/irq.h will be selected as the
> first candidate. This header does not include the proper definitions
> (most notably NR_IRQS) required by subsequent headers. To solve this
> arch/mips/jz4740/irq.h can be deleted and its contents can be moved
> into arch/mips/include/asm/mach-jz4740/irq.h, which will then be
> correctly included.
> 

Where exactly did you have this problem? arch/mips/jz4740/ should not be in the
include path, so "#include <irq.h>" should not cause arch/mips/jz4740/irq.h to
be included.

> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  arch/mips/include/asm/mach-jz4740/irq.h |  5 +++++
>  arch/mips/jz4740/irq.h                  | 23 -----------------------
>  2 files changed, 5 insertions(+), 23 deletions(-)
>  delete mode 100644 arch/mips/jz4740/irq.h
> 
> diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/include/asm/mach-jz4740/irq.h
> index 5ad1a9c..aa6fd90 100644
> --- a/arch/mips/include/asm/mach-jz4740/irq.h
> +++ b/arch/mips/include/asm/mach-jz4740/irq.h
> @@ -54,4 +54,9 @@
>  
>  #define NR_IRQS (JZ4740_IRQ_ADC_BASE + 6)
>  
> +struct irq_data;
> +
> +extern void jz4740_irq_suspend(struct irq_data *data);
> +extern void jz4740_irq_resume(struct irq_data *data);
> +
>  #endif
> diff --git a/arch/mips/jz4740/irq.h b/arch/mips/jz4740/irq.h
> deleted file mode 100644
> index f75e39d..0000000
> --- a/arch/mips/jz4740/irq.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify it
> - *  under  the terms of the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the License, or (at your
> - *  option) any later version.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - *
> - */
> -
> -#ifndef __MIPS_JZ4740_IRQ_H__
> -#define __MIPS_JZ4740_IRQ_H__
> -
> -#include <linux/irq.h>
> -
> -extern void jz4740_irq_suspend(struct irq_data *data);
> -extern void jz4740_irq_resume(struct irq_data *data);
> -
> -#endif
