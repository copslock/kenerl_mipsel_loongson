Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 11:10:10 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:37273 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S28580152AbXARLJ6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 11:09:58 +0000
Received: from lagash (88-106-179-150.dynamic.dsl.as9105.com [88.106.179.150])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 2C7DBBACBB;
	Thu, 18 Jan 2007 12:05:34 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1H7V6S-0001pj-1M; Thu, 18 Jan 2007 11:06:44 +0000
Date:	Thu, 18 Jan 2007 11:06:43 +0000
To:	Daniel Laird <danieljlaird@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Install Headers Target
Message-ID: <20070118110643.GC23469@networkno.de>
References: <8426876.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8426876.post@talk.nabble.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Daniel Laird wrote:
> 
> I have been trying to build a kernel, toolchain and rootfs using buildroot.
> 
> Buildroot uses the install-headers target of the kernel to get the headers
> to build a toolchain.
> I tried to build a the uClibc-gcc toolchain combo was missing 2 header files
> to do the build.
> This I fixed by patching Kbuild in asm-mips dir
> See below:
> diff -urN overlay_orig/include/asm-mips/Kbuild
> overlay/include/asm-mips/Kbuild
> --- a/include/asm-mips/Kbuild	2007-01-17 12:57:20.000000000 +0000
> +++b/include/asm-mips/Kbuild	2007-01-17 12:53:46.000000000 +0000
> @@ -1,3 +1,3 @@
>  include include/asm-generic/Kbuild.asm
> 
> -header-y += cachectl.h sgidefs.h sysmips.h
> +header-y += asm.h cachectl.h regdef.h sgidefs.h sysmips.h
> 
> Is it possible for this to go in? (Any one any problems with this patch)
> Is this mailing list the correct one for this patch?

For a glibc configuration those files are provided by glibc. I think
uClibc should do the same, the files aren't Linux specific.


Thiemo
