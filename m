Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 02:36:36 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:3924 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1495728AbZLVBgU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 02:36:20 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAFmxL0urRN+K/2dsb2JhbADAI5ZBhC4E
X-IronPort-AV: E=Sophos;i="4.47,434,1257120000"; 
   d="scan'208";a="123481544"
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-5.cisco.com with ESMTP; 22 Dec 2009 01:36:13 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id nBM1aD89010716;
        Tue, 22 Dec 2009 01:36:13 GMT
Date:   Mon, 21 Dec 2009 17:36:13 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/5] MIPS: remove unused powertv platform_die()
Message-ID: <20091222013613.GD24784@dvomlehn-lnx2.corp.sa.net>
References: <20091218212917.f42e8180.yuasa@linux-mips.org> <20091218213018.79a9fc11.yuasa@linux-mips.org> <20091218213346.01f63eac.yuasa@linux-mips.org> <20091218213632.7d5b0037.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091218213632.7d5b0037.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 18, 2009 at 09:36:32PM +0900, Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/powertv/powertv_setup.c |   21 ---------------------
>  1 files changed, 0 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/mips/powertv/powertv_setup.c b/arch/mips/powertv/powertv_setup.c
> index bd8ebf1..698b1ea 100644
> --- a/arch/mips/powertv/powertv_setup.c
> +++ b/arch/mips/powertv/powertv_setup.c
> @@ -64,9 +64,6 @@
>  #define REG_SIZE	"4"		/* In bytes */
>  #endif
>  
> -static struct pt_regs die_regs;
> -static bool have_die_regs;
> -
>  static void register_panic_notifier(void);
>  static int panic_handler(struct notifier_block *notifier_block,
>  	unsigned long event, void *cause_string);
> @@ -218,24 +215,6 @@ static int panic_handler(struct notifier_block *notifier_block,
>  	return NOTIFY_DONE;
>  }
>  
> -/**
> - * Platform-specific handling of oops
> - * @str:	Pointer to the oops string
> - * @regs:	Pointer to the oops registers
> - * All we do here is to save the registers for subsequent printing through
> - * the panic notifier.
> - */
> -void platform_die(const char *str, const struct pt_regs *regs)
> -{
> -	/* If we already have saved registers, don't overwrite them as they
> -	 * they apply to the initial fault */
> -
> -	if (!have_die_regs) {
> -		have_die_regs = true;
> -		die_regs = *regs;
> -	}
> -}
> -
>  /* Information about the RF MAC address, if one was supplied on the
>   * command line. */
>  static bool have_rfmac;
> -- 
> 1.6.5.7
> 
> 
Looks good, thanks!
Reviewed-by: David VomLehn (dvomlehn@cisco.com)
