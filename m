Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2012 22:10:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12900 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903736Ab2FGUKx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2012 22:10:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fd10b200000>; Thu, 07 Jun 2012 13:12:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Jun 2012 13:10:21 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 7 Jun 2012 13:10:21 -0700
Message-ID: <4FD10AAD.3050307@cavium.com>
Date:   Thu, 07 Jun 2012 13:10:21 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] MIPS: OCTEON: Remove some unused OCTEON_IRQ_* definitions.
References: <1339098744-9874-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1339098744-9874-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2012 20:10:21.0618 (UTC) FILETIME=[911B8120:01CD44E9]
X-archive-position: 33602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Drat!  I missed one.

Sending a new patch.

David Daney


On 06/07/2012 12:52 PM, David Daney wrote:
> From: David Daney<david.daney@cavium.com>
>
> These are now unused.  Remove them.
>
> Signed-off-by: David Daney<david.daney@cavium.com>
> ---
>   arch/mips/include/asm/mach-cavium-octeon/irq.h |    7 -------
>   1 files changed, 0 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/include/asm/mach-cavium-octeon/irq.h b/arch/mips/include/asm/mach-cavium-octeon/irq.h
> index 4189920..0a47c9f 100644
> --- a/arch/mips/include/asm/mach-cavium-octeon/irq.h
> +++ b/arch/mips/include/asm/mach-cavium-octeon/irq.h
> @@ -26,9 +26,6 @@ enum octeon_irq {
>   	OCTEON_IRQ_WDOG15 = OCTEON_IRQ_WDOG0 + 15,
>   	OCTEON_IRQ_MBOX0 = OCTEON_IRQ_WDOG0 + 16,
>   	OCTEON_IRQ_MBOX1,
> -	OCTEON_IRQ_UART0,
> -	OCTEON_IRQ_UART1,
> -	OCTEON_IRQ_UART2,
>   	OCTEON_IRQ_PCI_INT0,
>   	OCTEON_IRQ_PCI_INT1,
>   	OCTEON_IRQ_PCI_INT2,
> @@ -38,8 +35,6 @@ enum octeon_irq {
>   	OCTEON_IRQ_PCI_MSI2,
>   	OCTEON_IRQ_PCI_MSI3,
>
> -	OCTEON_IRQ_TWSI,
> -	OCTEON_IRQ_TWSI2,
>   	OCTEON_IRQ_RML,
>   	OCTEON_IRQ_TIMER0,
>   	OCTEON_IRQ_TIMER1,
> @@ -47,8 +42,6 @@ enum octeon_irq {
>   	OCTEON_IRQ_TIMER3,
>   	OCTEON_IRQ_USB0,
>   	OCTEON_IRQ_USB1,
> -	OCTEON_IRQ_MII0,
> -	OCTEON_IRQ_MII1,
>   	OCTEON_IRQ_BOOTDMA,
>   #ifndef CONFIG_PCI_MSI
>   	OCTEON_IRQ_LAST = 127
