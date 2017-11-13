Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 19:18:50 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:54363 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990427AbdKMSSlFSiSR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 19:18:41 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 13 Nov 2017 18:18:34 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 13 Nov
 2017 10:18:31 -0800
Date:   Mon, 13 Nov 2017 18:18:29 +0000
From:   James Hogan <james.hogan@mips.com>
To:     <justinpopo6@gmail.com>
CC:     <linux-mips@linux-mips.org>,
        <bcm-kernel-feedback-list@broadcom.com>, <f.fainelli@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH 1/1] BMIPS: Enable HARDIRQS_SW_RESEND
Message-ID: <20171113181829.GB31917@jhogan-linux.mipstec.com>
References: <20170524175516.13849-1-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20170524175516.13849-1-justinpopo6@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510597108-321459-22242-1691-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186883
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Wed, May 24, 2017 at 10:55:16AM -0700, justinpopo6@gmail.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> HW interrupts triggered when irq_disable() were being ignored. Enable
> resending HW interrupts as SW interrupts.
> 
> This was causing an issue where the interrupts waking the system up from
> a suspend state were not calling their interrupt handlers.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Applied, thanks

Cheers
James

> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2828ecde133d..349f9bdb655b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -230,6 +230,7 @@ config BMIPS_GENERIC
>  	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select HARDIRQS_SW_RESEND
>  	help
>  	  Build a generic DT-based kernel image that boots on select
>  	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
> -- 
> 2.12.2
> 
> 
