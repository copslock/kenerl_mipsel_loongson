Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 10:58:42 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:64269 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133627AbWBQK6d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 10:58:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1HB5EPL017167;
	Fri, 17 Feb 2006 11:05:14 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1GNOkmP028613;
	Thu, 16 Feb 2006 23:24:46 GMT
Date:	Thu, 16 Feb 2006 23:24:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] make I/O helpers more customizable
Message-ID: <20060216232446.GA27840@linux-mips.org>
References: <20060217.013624.04769497.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217.013624.04769497.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 17, 2006 at 01:36:24AM +0900, Atsushi Nemoto wrote:

> 1. Move ioswab*() and __mem_ioswab*() to mangle-port.h.  Now io.h is
> clean from CONFIG_SGI_IP22.
> 
> 2. Pass a virtual address to *ioswab*().  Then we can provide
> mach-specific *ioswab*() and can do every evil thing based on its
> argument.  It could be useful on machines which have regions with
> different endian conversion scheme.
> 
> 3. Call __swizzle_addr*() _after_ adding mips_io_port_base.  This
> unifies the meaning of the argument of __swizzle_addr*() (always
> virtual address).  Then mach-specific __swizzle_addr*() can do every
> evil thing based on the argument.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Looks nice.  This this is more of a cleanup so I queued it for 2.6.17.

  Ralf
