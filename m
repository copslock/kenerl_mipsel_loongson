Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 02:17:39 +0100 (BST)
Received: from p508B5D71.dip.t-dialin.net ([IPv6:::ffff:80.139.93.113]:5063
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225233AbTGPBRh>; Wed, 16 Jul 2003 02:17:37 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6G1HZDB009486
	for <linux-mips@linux-mips.org>; Wed, 16 Jul 2003 03:17:35 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6G1HZFF009485
	for linux-mips@linux-mips.org; Wed, 16 Jul 2003 03:17:35 +0200
Date: Wed, 16 Jul 2003 03:17:35 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030716011734.GA9275@linux-mips.org>
References: <20030716010829Z8224802-1272+3435@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716010829Z8224802-1272+3435@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

You forgot to patch mips64 / 2.6 also.  *grrr*

  Ralf

On Wed, Jul 16, 2003 at 02:08:24AM +0100, sjhill@linux-mips.org wrote:
> From:	sjhill@linux-mips.org
> To:	linux-cvs@linux-mips.org
> Subject: CVS Update@-mips.org: linux 
> Date:	Wed, 16 Jul 2003 02:08:24 +0100
> 
> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	sjhill@ftp.linux-mips.org	03/07/16 02:08:24
> 
> Modified files:
> 	arch/mips/kernel: Tag: linux_2_4 setup.c time.c 
> 	arch/mips/mm   : Tag: linux_2_4 tlb-r4k.c 
> 	arch/mips/tx4927/common: Tag: linux_2_4 tx4927_irq.c 
> 	arch/mips/tx4927/toshiba_rbtx4927: Tag: linux_2_4 
> 	                                   toshiba_rbtx4927_irq.c 
> 	                                   toshiba_rbtx4927_prom.c 
> 	                                   toshiba_rbtx4927_setup.c 
> 	include/asm-mips: Tag: linux_2_4 au1000.h pci.h 
> 
> Log message:
> 	A bunch of small clean ups to remove compile warning messages.
> 

  Ralf
