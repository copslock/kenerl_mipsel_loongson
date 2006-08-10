Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2006 15:29:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:22790 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20043560AbWHJO3H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Aug 2006 15:29:07 +0100
Received: (qmail 9890 invoked by uid 1000); 10 Aug 2006 16:29:03 +0200
Date:	Thu, 10 Aug 2006 16:29:03 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] 2/7 AU1100 MMC support
Message-ID: <20060810142903.GB9844@roarinelk.homelinux.net>
References: <20060809210843.GC13145@enneenne.com> <44DB34C2.3090302@ru.mvista.com> <20060810133658.GZ342@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810133658.GZ342@enneenne.com>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Rodolfo,

On Thu, Aug 10, 2006 at 03:36:58PM +0200, Rodolfo Giometti wrote:
> Again as above. For my specific board I use:
> 
>    #if defined(CONFIG_MIPS_DB1200)
>        data = bcsr->sig_status & val;
>    #elif defined(CONFIG_MIPS_MYBOARD)
>        specific code...
>    #endif
> 
> Maybe we should modify my solution including other DB1x00 boards
> ifdef. However, the important thing is to protect againt variable
> "bcsr" if a specific board doesn't support it.

FWIW, I think the whole Db/Pb board specific mess should be removed
from the driver entirely and placed in the respective boards' code.
The board should then pass on a struct to the driver with hooks
into those functions (like in arch/arm/mach-pxa/corgi.c).

It is on my list of things to fix for a later time. If noone beats me
to it, I'm going to do it, but it may take a while since I'm working
on other things.

Thanks,

-- 
 ml.
