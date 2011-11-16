Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 14:23:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42605 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903809Ab1KPNW6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 14:22:58 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAGDMw4N011743;
        Wed, 16 Nov 2011 13:22:58 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAGDMvM1011741;
        Wed, 16 Nov 2011 13:22:57 GMT
Date:   Wed, 16 Nov 2011 13:22:57 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: enable oprofile support on lantiq targets
Message-ID: <20111116132257.GB11111@linux-mips.org>
References: <1314185769-16745-1-git-send-email-blogic@openwrt.org>
 <1314185769-16745-2-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314185769-16745-2-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13383

On Wed, Aug 24, 2011 at 01:36:09PM +0200, John Crispin wrote:

> This patch sets the performance counters irq and HAVE_OPROFILE flag.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/Kconfig      |    1 +
>  arch/mips/lantiq/irq.c |    5 +++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index d300c2b..f748550 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -230,6 +230,7 @@ config LANTIQ
>  	select SWAP_IO_SPACE
>  	select BOOT_RAW
>  	select HAVE_CLK
> +	select HAVE_OPROFILE
>  	select MIPS_MACHINE
>  
>  config LASAT

This is already being in the "config MIPS" section at the top of
arch/mips/Kconfig.

  Ralf
