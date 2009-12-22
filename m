Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2009 02:33:34 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:34016 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1494057AbZLVBd3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2009 02:33:29 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEACSwL0urRN+J/2dsb2JhbADAJ5ZAhC4E
X-IronPort-AV: E=Sophos;i="4.47,434,1257120000"; 
   d="scan'208";a="123480832"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 22 Dec 2009 01:33:20 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id nBM1XJHx006622;
        Tue, 22 Dec 2009 01:33:19 GMT
Date:   Mon, 21 Dec 2009 17:33:19 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/5]MIPS: remove unused powertv prom_getcmdline()
Message-ID: <20091222013319.GA24784@dvomlehn-lnx2.corp.sa.net>
References: <20091218212917.f42e8180.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091218212917.f42e8180.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 18, 2009 at 09:29:17PM +0900, Yoichi Yuasa wrote:
> Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  arch/mips/powertv/cmdline.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
> index 98d73cb..ee7ab47 100644
> --- a/arch/mips/powertv/cmdline.c
> +++ b/arch/mips/powertv/cmdline.c
> @@ -31,11 +31,6 @@
>   */
>  #define prom_argv(index) ((char *)(long)_prom_argv[(index)])
>  
> -char * __init prom_getcmdline(void)
> -{
> -	return &(arcs_cmdline[0]);
> -}
> -
>  void  __init prom_init_cmdline(void)
>  {
>  	int len;
> -- 
> 1.6.5.7
> 
> 

Looks good, thanks!
Reviewed-by: David VomLehn (dvomlehn@cisco.com)
