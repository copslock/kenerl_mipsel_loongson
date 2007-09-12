Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 11:42:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25226 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021563AbXIMKmS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 11:42:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8CNFblP010879;
	Thu, 13 Sep 2007 00:15:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8CNFaLt010878;
	Thu, 13 Sep 2007 00:15:36 +0100
Date:	Thu, 13 Sep 2007 00:15:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: IP22 64bit kernel
Message-ID: <20070912231536.GI4571@linux-mips.org>
References: <20070911213048.GA20579@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070911213048.GA20579@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 11, 2007 at 11:30:48PM +0200, Thomas Bogendoerfer wrote:

> I finally figured out, why 64bit SGI IP22 kernels are broken (at
> least when booted with SGI sash). Looks like sash jumps to an uncached
> XPHYS address instead of the KSEG0 address indicated by the ELF start.
> This messes up bogomips calculation.
> 
> I found an interesting piece of code in head.S:
> 
>         .macro  ARC64_TWIDDLE_PC
> #if defined(CONFIG_ARC64) || defined(CONFIG_MAPPED_KERNEL)
>         /* We get launched at a XKPHYS address but the kernel is linked
>  * to
>            run at a KSEG0 address, so jump there.  */
>         PTR_LA  t0, \@f
>         jr      t0
> \@:
> #endif
>         .endm
> 
> 
> Enabling this for (CONFIG_SGI_IP22 && CONFIG_64BIT) fixes the boot problem.
> It's not big deal to add this, but I'm wondering why we not just always
> use this macro ? What platforms do it break with it ?

I don't think any will break - it's just one of those "optimizations".

  Ralf
