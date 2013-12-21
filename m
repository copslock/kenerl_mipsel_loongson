Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Dec 2013 18:37:19 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60284 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816233Ab3LURhPmtx7m (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Dec 2013 18:37:15 +0100
Message-ID: <52B5D14A.3030504@phrozen.org>
Date:   Sat, 21 Dec 2013 18:35:06 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 12/18] MIPS: Netlogic: XLP9XX UART offset
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com> <1387624950-31297-13-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1387624950-31297-13-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 21/12/13 12:22, Jayachandran C wrote:
> Update IO offset of the early console UART.
>
> Signed-off-by: Jayachandran C<jchandra@broadcom.com>
> ---
>   arch/mips/include/asm/netlogic/xlp-hal/uart.h |    3 ++-
>   arch/mips/netlogic/common/earlycons.c         |    2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/netlogic/xlp-hal/uart.h b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
> index 86d16e1..a6c5442 100644
> --- a/arch/mips/include/asm/netlogic/xlp-hal/uart.h
> +++ b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
> @@ -94,7 +94,8 @@
>   #define nlm_read_uart_reg(b, r)		nlm_read_reg(b, r)
>   #define nlm_write_uart_reg(b, r, v)	nlm_write_reg(b, r, v)
>   #define nlm_get_uart_pcibase(node, inst)	\
> -		nlm_pcicfg_base(XLP_IO_UART_OFFSET(node, inst))
> +	nlm_pcicfg_base(cpu_is_xlp9xx() ?  XLP9XX_IO_UART_OFFSET(node) : \
> +						XLP_IO_UART_OFFSET(node, inst))

nitpick: i think this looks really ugly. maybe move the ()?():() logic 
to a define ?





>   #define nlm_get_uart_regbase(node, inst)	\
>   			(nlm_get_uart_pcibase(node, inst) + XLP_IO_PCI_HDRSZ)
>
> diff --git a/arch/mips/netlogic/common/earlycons.c b/arch/mips/netlogic/common/earlycons.c
> index 1902fa2..769f930 100644
> --- a/arch/mips/netlogic/common/earlycons.c
> +++ b/arch/mips/netlogic/common/earlycons.c
> @@ -37,9 +37,11 @@
>
>   #include<asm/mipsregs.h>
>   #include<asm/netlogic/haldefs.h>
> +#include<asm/netlogic/common.h>
>
>   #if defined(CONFIG_CPU_XLP)
>   #include<asm/netlogic/xlp-hal/iomap.h>
> +#include<asm/netlogic/xlp-hal/xlp.h>
>   #include<asm/netlogic/xlp-hal/uart.h>
>   #elif defined(CONFIG_CPU_XLR)
>   #include<asm/netlogic/xlr/iomap.h>
