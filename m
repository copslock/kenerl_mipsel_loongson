Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 03:56:56 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:55229 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225348AbULBD4v>; Thu, 2 Dec 2004 03:56:51 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1CZi59-0003wh-Lu; Wed, 01 Dec 2004 21:56:42 -0600
Message-ID: <41AE9390.80705@realitydiluted.com>
Date: Wed, 01 Dec 2004 22:01:20 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Manish Lachwani <mlachwani@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] Broadcom SWARM IDE in 2.6
References: <20041130230022.GA17202@prometheus.mvista.com>
In-Reply-To: <20041130230022.GA17202@prometheus.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Manish Lachwani wrote:
> 
> I had sent an incomplete patch before. Please try out this new patch, attached.
> Let me know if it works
> 
Manish,

This patch worked, however you need to fix a compiler warning before I am
willing to commit it. Please get rid of the warning shown below and submit
a new patch. Thanks!

-Steve

*******************

CC      drivers/ide/ide-generic.o
In file included from drivers/ide/ide-generic.c:13:
include/linux/ide.h:277:1: warning: "ide_init_default_irq" redefined
In file included from include/asm/ide.h:11,
                  from include/linux/ide.h:271,
                  from drivers/ide/ide-generic.c:13:
include/asm-mips/mach-generic/ide.h:64:1: warning: this is the location of the 
previous definition
