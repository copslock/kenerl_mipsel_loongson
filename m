Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 09:59:33 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:36381 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224903AbVDGI6e>; Thu, 7 Apr 2005 09:58:34 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j378wIAt003730;
	Thu, 7 Apr 2005 09:58:27 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j36KJFIQ005029;
	Wed, 6 Apr 2005 21:19:15 +0100
Date:	Wed, 6 Apr 2005 21:19:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: When code and comments disagree...
Message-ID: <20050406201914.GC4978@linux-mips.org>
References: <200504061700.53764.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504061700.53764.eckhardt@satorlaser.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 06, 2005 at 05:00:53PM +0200, Ulrich Eckhardt wrote:

> ... both are probably wrong, as the saying goes. I stumbled across this line 
> in arch/mips/au1000/common/reset.c:
> 
>    au_writel(0x00, 0xb1900100); /* sys_pininputen */
> 
> However, 0xb1900100 is SYS_TRIOUTCLR, while SYS_PININPUTEN is 0xb1900110... 
> Which one is right now?
> 
> Also, does the switch statement in that file make sense at all? I mean is it 
> possible to compile a kernel that runs on several Alchemy systems?

Technically it's certainly possible to share kernels for many of the
Linux/MIPS platforms but for an architecture that these days largely
powers embedded platforms a generic kernel is of much less usefullnes than
on PCs, for example.

  Ralf
