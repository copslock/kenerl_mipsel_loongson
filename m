Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 19:07:04 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:20491 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226727AbVGOSGp>; Fri, 15 Jul 2005 19:06:45 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6FI7xTx027662;
	Fri, 15 Jul 2005 19:07:59 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6FI7wKZ027661;
	Fri, 15 Jul 2005 19:07:58 +0100
Date:	Fri, 15 Jul 2005 19:07:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc:	ppopov@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050715180758.GL2799@linux-mips.org>
References: <20050714174806Z8226711-3678+3079@linux-mips.org> <20050716001621.6d9d607a.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050716001621.6d9d607a.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 16, 2005 at 12:16:21AM +0900, Yoichi Yuasa wrote:
> Date:	Sat, 16 Jul 2005 00:16:21 +0900
> From:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> To:	ppopov@linux-mips.org
> Cc:	yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
> Subject: Re: CVS Update@linux-mips.org: linux
> Content-Type: text/plain; charset=US-ASCII
> 
> Hi Pete,
> 
> On Thu, 14 Jul 2005 18:48:00 +0100
> ppopov@linux-mips.org wrote:
> 
> > 
> > Log message:
> > 	Philips PNX8550 support: MIPS32-like core with 2 Trimedias on it.
> 
> I think the following include path is better.

>  
> -#include <asm/mach-pnx8550/uart.h>
> +#include <uart.h>

What to use really depends on what you want.  I originally created the
mach-* directories to have a place platform-specific header files
instead of infinitely long #ifdef mess.  A buch of -I gcc options are
used to create a search path from the most specific to the most generic
files at the end.  If that's the intend, use the <file.h> form.  If
however the intend is to include a specific file then the prefered
form is <patch/mach-foo/file.h> which avoids the danger of accidently
picking up something else and also is slightly easier for the compiler.

  Ralf
