Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 00:34:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51928 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010149AbbC3WeAJhClP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 00:34:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2UMY0lg016474;
        Tue, 31 Mar 2015 00:34:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2UMY0Q3016473;
        Tue, 31 Mar 2015 00:34:00 +0200
Date:   Tue, 31 Mar 2015 00:34:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Martin <paul.martin@codethink.co.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 10/10] MIPS: OCTEON: Fix Kconfig file typo
Message-ID: <20150330223400.GL3757@linux-mips.org>
References: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk>
 <1427731263-29950-11-git-send-email-paul.martin@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427731263-29950-11-git-send-email-paul.martin@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Mar 30, 2015 at 05:01:03PM +0100, Paul Martin wrote:

>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 68e64cb..c4d0229 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -780,7 +780,7 @@ config CAVIUM_OCTEON_SOC
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select EDAC_SUPPORT
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select SYS_SUPPORTS_HOTPLUG_CPU if CONFIG_CPU_BIG_ENDIAN
> +	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
>  	select SYS_HAS_EARLY_PRINTK
>  	select SYS_HAS_CPU_CAVIUM_OCTEON
>  	select SWAP_IO_SPACE

And this really should be folded into patch 9/10 - adding a bug, then
fixing it one commit later is silly.

Thanks for all the work on this series!

  Ralf
