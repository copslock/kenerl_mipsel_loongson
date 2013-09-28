Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 19:05:25 +0200 (CEST)
Received: from smtp-out-202.synserver.de ([212.40.185.202]:1052 "EHLO
        smtp-out-200.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6817088Ab3I1RFVpLLRE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 19:05:21 +0200
Received: (qmail 31884 invoked by uid 0); 28 Sep 2013 17:05:18 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 31865
Received: from ppp-88-217-85-219.dynamic.mnet-online.de (HELO ?192.168.178.23?) [88.217.85.219]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 28 Sep 2013 17:05:17 -0000
Message-ID: <52470CBB.30406@metafoo.de>
Date:   Sat, 28 Sep 2013 19:07:07 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130922 Icedove/17.0.9
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: JZ4740: reuse UART0 address macro for vmlinuz debug
 port
References: <1380383374-28406-1-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1380383374-28406-1-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38049
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

On 09/28/2013 05:49 PM, Antony Pavlov wrote:
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>

Looks good.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  arch/mips/boot/compressed/uart-16550.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
> index c01d343..869172d 100644
> --- a/arch/mips/boot/compressed/uart-16550.c
> +++ b/arch/mips/boot/compressed/uart-16550.c
> @@ -19,8 +19,8 @@
>  #endif
>  
>  #ifdef CONFIG_MACH_JZ4740
> -#define UART0_BASE  0xB0030000
> -#define PORT(offset) (UART0_BASE + (4 * offset))
> +#include <asm/mach-jz4740/base.h>
> +#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
>  #endif
>  
>  #ifdef CONFIG_CPU_XLR
> 
