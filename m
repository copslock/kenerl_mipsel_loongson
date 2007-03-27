Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 00:53:33 +0100 (BST)
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38798 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20023050AbXC0Xxc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 00:53:32 +0100
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 868D9181C22;
	Wed, 28 Mar 2007 01:53:15 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 82839115B5F; Wed, 28 Mar 2007 01:53:00 +0200 (CEST)
Date:	Wed, 28 Mar 2007 01:53:00 +0200
From:	Adrian Bunk <bunk@stusta.de>
To:	"Robert P. J. Day" <rpjday@mindspring.com>, ralf@linux-mips.org
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org
Subject: Re: dead CONFIG variables in kernel Makefiles
Message-ID: <20070327235259.GL16477@stusta.de>
References: <Pine.LNX.4.64.0703261924470.26815@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703261924470.26815@CPE00045a9c397f-CM001225dbafb6>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 26, 2007 at 07:32:00PM -0400, Robert P. J. Day wrote:
> 
>   the output from a short script i wrote, locating all CONFIG_
> variables in makefiles that don't appear to exist in any Kconfig file
> anywhere in the source tree.
> 
>   first, from the drivers/ directory:
>...
> ===== ZS =====
> ./drivers/tc/Makefile:obj-$(CONFIG_ZS) += zs.o
>...

Ralf, is there any reason why the code for this driver is in Linus' 
tree, but the option (that is in the mips tree) is missing?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
