Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Feb 2006 21:42:16 +0000 (GMT)
Received: from networks.syneticon.net ([213.239.212.131]:22674 "EHLO
	mail2.syneticon.net") by ftp.linux-mips.org with ESMTP
	id S8133496AbWBLVmG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 21:42:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail2.syneticon.net (Postfix) with ESMTP id AF93B3C71C;
	Sun, 12 Feb 2006 22:48:17 +0100 (CET)
Received: from mail2.syneticon.net ([127.0.0.1])
 by localhost (linux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04334-13; Sun, 12 Feb 2006 22:48:15 +0100 (CET)
Received: from [84.44.217.177] (xdsl-84-44-217-177.netcologne.de [84.44.217.177])
	by mail2.syneticon.net (Postfix) with ESMTP;
	Sun, 12 Feb 2006 22:48:14 +0100 (CET)
Message-ID: <43EFAD1D.9010100@wpkg.org>
Date:	Sun, 12 Feb 2006 22:48:13 +0100
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Mail/News 1.5 (X11/20060210)
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org> <43EFA945.1030906@avtrex.com>
In-Reply-To: <43EFA945.1030906@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: amavisd-new at syneticon.de
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

David Daney wrote:

> I have done it for mipsel-linux-glibc, however until last week gcc had 
> no support for uClibc, so it will probably not work with uClibc without 
> some patching to gcc.
> 
> The basic idea is that once you have a working cross toolchain just 
> configure gcc and binutils with: --build=i686-pc-linux-glibc 
> --target=mipsel-linux --host=mipsel-linux.  This will produce a native 
> toolchain.  You will have to copy the compile time portions of the C 
> library (include files and link time libraries) to the target, then you 
> should be all set.

Exactly that's my problem.

I have a compiler that generates binaries for mipsel/uclibc.

I compiled lots of software with it, so we can say it's functional.


Now, when I try to compile gcc (--build=i686-pc-linux-glibc
 > --target=mipsel-linux --host=mipsel-linux), it breaks, as during the 
build process gcc's ./configure has a schizophrenia: it tries to compile 
some parts for mipsel (as I'd expect), but it also tries to compile and 
execute the binaries during the build process.

This means, it creates some binaries/libs needed for the build process 
(like libiberty), then tries to run/use them, but as they are mipsel 
binaries, the build process breaks.

I tried that with gcc-4.0.2, and some earlier 3.3.6 and 3.4.5, without a 
success.


-- 
Tomasz Chmielewski
Software deployment with Samba
http://wpkg.org
