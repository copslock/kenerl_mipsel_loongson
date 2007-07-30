Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 16:46:58 +0100 (BST)
Received: from real.realitydiluted.com ([66.43.201.61]:54996 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S20022987AbXG3Pqy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 16:46:54 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.67)
	(envelope-from <sjhill@real.realitydiluted.com>)
	id 1IFXRQ-0001Jj-ME; Mon, 30 Jul 2007 10:45:52 -0500
Date:	Mon, 30 Jul 2007 10:45:52 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
To:	Songmao Tian <tiansm@lemote.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Add errno definition to pm.h
Message-ID: <20070730154552.GA4937@real.realitydiluted.com>
References: <46AE05DE.1020109@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46AE05DE.1020109@lemote.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <sjhill@real.realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

On Mon, Jul 30, 2007 at 11:38:06PM +0800, Songmao Tian wrote:
> commit 296699de6bdc717189a331ab6bbe90e05c94db06 add
> static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> which need errno definition
> 
> Signed-off-by: Songmao Tian <tiansm@lemote.com>
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e52f6f8..48b71ba 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -25,6 +25,7 @@
> 
> #include <linux/list.h>
> #include <asm/atomic.h>
> +#include <asm/errno.h>
> 
You should be including <linux/errno.h> which then includes the
architecture-specific file. This patch should be rejected.

-Steve
