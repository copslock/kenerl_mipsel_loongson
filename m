Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2012 19:21:23 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:52172 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903511Ab2HGRVS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2012 19:21:18 +0200
Received: (qmail 29963 invoked by uid 2102); 7 Aug 2012 13:21:13 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2012 13:21:13 -0400
Date:   Tue, 7 Aug 2012 13:21:13 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Steven J. Hill" <sjhill@mips.com>
cc:     linux-usb@vger.kernel.org, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] usb: host: mips: sead3: Update for EHCI register structure.
In-Reply-To: <1344292171-3111-1-git-send-email-sjhill@mips.com>
Message-ID: <Pine.LNX.4.44L0.1208071320170.2400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
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

On Mon, 6 Aug 2012, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> One line fix after 'struct ehci_regs' definition was changed
> in commit a46af4ebf9ffec35eea0390e89935197b833dc61.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>  drivers/usb/host/ehci-sead3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
> index 58c96bd..0c9e43c 100644
> --- a/drivers/usb/host/ehci-sead3.c
> +++ b/drivers/usb/host/ehci-sead3.c
> @@ -40,7 +40,7 @@ static int ehci_sead3_setup(struct usb_hcd *hcd)
>  	ehci->need_io_watchdog = 0;
>  
>  	/* Set burst length to 16 words. */
> -	ehci_writel(ehci, 0x1010, &ehci->regs->reserved[1]);
> +	ehci_writel(ehci, 0x1010, &ehci->regs->reserved1[1]);
>  
>  	return ret;
>  }

Acked-by: Alan Stern <stern@rowland.harvard.edu>

I never thought to check if any of the platform drivers were actually 
using these reserved memory addresses.

Alan Stern
