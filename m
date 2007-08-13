Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 11:19:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40117 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022129AbXHMKTo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Aug 2007 11:19:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7DAJgrF007514;
	Mon, 13 Aug 2007 11:19:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7DAJfFx007513;
	Mon, 13 Aug 2007 11:19:41 +0100
Date:	Mon, 13 Aug 2007 11:19:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	joe@perches.com
Cc:	torvalds@linux-foundation.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Patrick Gefre <pfg@sgi.com>
Subject: Re: [PATCH] [261/2many] MAINTAINERS - IOC3 DRIVER
Message-ID: <20070813101941.GA6462@linux-mips.org>
References: <46bffa6e.aluJMNuvp11tc2XU%joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46bffa6e.aluJMNuvp11tc2XU%joe@perches.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 12, 2007 at 11:30:06PM -0700, joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6263958..207331c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2501,6 +2501,8 @@ P:	Ralf Baechle
>  M:	ralf@linux-mips.org
>  L:	linux-mips@linux-mips.org
>  S:	Maintained
> +F:	drivers/net/ioc3-eth.c
> +F:	drivers/serial/ioc3_serial.c

Although for the same multifunction device at this stage the IOC3 ethernet
and ioc3_serial are totally separate, so I suggest to add a separate
MAINTAINERS entry for ioc3_serial with Patrick Gefre <pfg@sgi.com> as the
maintainer.

  Ralf
