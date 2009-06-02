Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 18:59:57 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45716 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022186AbZFBR7u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 18:59:50 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n52HxRUw005119;
	Tue, 2 Jun 2009 18:59:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n52HxR3c005117;
	Tue, 2 Jun 2009 18:59:27 +0100
Date:	Tue, 2 Jun 2009 18:59:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Imre Kaloz <kaloz@openwrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Honor CONFIG_CMDLINE on SiByte
Message-ID: <20090602175927.GE32078@linux-mips.org>
References: <1243945334-5090-1-git-send-email-kaloz@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243945334-5090-1-git-send-email-kaloz@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 02, 2009 at 02:22:14PM +0200, Imre Kaloz wrote:

> The SiByte platform code doesn't honor the CONFIG_CMDLINE kernel
> option. This patch fixes this issue.
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/mips/sibyte/common/cfe.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
> index 3de30f7..97e997e 100644
> --- a/arch/mips/sibyte/common/cfe.c
> +++ b/arch/mips/sibyte/common/cfe.c
> @@ -293,7 +293,11 @@ void __init prom_init(void)
>  			 * It's OK for direct boot to not provide a
>  			 *  command line
>  			 */
> +#ifdef CONFIG_CMDLINE
> +			strlcpy(arcs_cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> +#else
>  			strcpy(arcs_cmdline, "root=/dev/ram0 ");
> +#endif

I rather think the strcpy should go instead.  Hardwiring an option doesn't
seem a good idea.

  Ralf
