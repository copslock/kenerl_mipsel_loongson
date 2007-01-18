Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 12:53:09 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:55698 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S28585417AbXARMxE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2007 12:53:04 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1H7WlJ-0001XV-MF
	for linux-mips@linux-mips.org; Thu, 18 Jan 2007 04:53:01 -0800
Message-ID: <8430190.post@talk.nabble.com>
Date:	Thu, 18 Jan 2007 04:53:01 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Install Headers Target
In-Reply-To: <8426876.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
References: <8426876.post@talk.nabble.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips




Daniel Laird wrote:
> 
> I have been trying to build a kernel, toolchain and rootfs using
> buildroot.
> 
> Buildroot uses the install-headers target of the kernel to get the headers
> to build a toolchain.
> I tried to build a the uClibc-gcc toolchain combo was missing 2 header
> files to do the build.
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
> 
> Hope it helps
> Daniel Laird
> 
> 
Ok, Must be because I am using a released version of uClibc (hence 0.9.28)
and therefore not picked up the necessary fixes.  This should go when 0.9.29
is released!!
Daniel 
-- 
View this message in context: http://www.nabble.com/Install-Headers-Target-tf3032928.html#a8430190
Sent from the linux-mips main mailing list archive at Nabble.com.
