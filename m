Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 10:10:21 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:21512 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022334AbXJYJKL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 10:10:11 +0100
Received: (qmail 27399 invoked by uid 1000); 25 Oct 2007 11:09:11 +0200
Date:	Thu, 25 Oct 2007 11:09:11 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	kaka <share.kt@gmail.com>
Cc:	directfb-users@directfb.org, directfb-dev@directfb.org,
	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	linux-fbdev-users@lists.sourceforge.net
Subject: Re: Updated:Error opening framebuffer device/Unknown symbol
Message-ID: <20071025090911.GA27179@roarinelk.homelinux.net>
References: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea8a9c90710250155h7534fdfajf7193921575e96fe@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 02:25:40PM +0530, kaka wrote:
> Hi All,
> 
> Thanks for the overhelming responses.
> I was able to remove the problem of Unknown symbols by linking the proper
> libraries. Now the problem got reduced to the following messages.
> 
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol free
> insmod: cannot insert `brcmstfb.ko': Unknown symbol in module (2): No such
> file or directory

kernel does not have the above mentioned functions, but you could
go over your code and replace all occurrences of the unknown symbols
with these:
printf -> printk
malloc -> kmalloc
free -> kfree

Pay attention to the different parameters used by some of those.

-- 
 ml.
