Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Feb 2014 21:35:52 +0100 (CET)
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:53603 "EHLO
        cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824815AbaBIUfuXWglx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Feb 2014 21:35:50 +0100
Received: from cpsps-ews24.kpnxchange.com ([10.94.84.190]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 21:35:44 +0100
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews24.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 21:35:44 +0100
Received: from [192.168.1.104] ([82.169.24.127]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Sun, 9 Feb 2014 21:35:44 +0100
Message-ID: <1391978143.25855.30.camel@x220>
Subject: Re: [PATCH 11/28] Remove ARCH_SUPPORTS_MSI
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Feb 2014 21:35:43 +0100
In-Reply-To: <1391971686-9517-12-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
         <1391971686-9517-12-git-send-email-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.3 (3.10.3-1.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Feb 2014 20:35:44.0383 (UTC) FILETIME=[818E00F0:01CF25D6]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
> The symbol is an orphan, get rid of it.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/mips/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 792bd22..5b08fe9 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -782,7 +782,6 @@ config NLM_XLP_BOARD
>  	select CEVT_R4K
>  	select CSRC_R4K
>  	select IRQ_CPU
> -	select ARCH_SUPPORTS_MSI
>  	select ZONE_DMA32 if 64BIT
>  	select SYNC_R4K
>  	select SYS_HAS_EARLY_PRINTK

I sent an identical patch (with a more verbose explanation) yesterday.
But I'm fine with this one too.


Paul Bolle
