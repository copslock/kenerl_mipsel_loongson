Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 00:39:33 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:36899
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3465640AbWBLVZn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Feb 2006 21:25:43 +0000
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 12 Feb 2006 13:31:51 -0800
Message-ID: <43EFA945.1030906@avtrex.com>
Date:	Sun, 12 Feb 2006 13:31:49 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Tomasz Chmielewski <mangoo@wpkg.org>
CC:	linux-mips@linux-mips.org
Subject: Re: native gcc for mipsel / uClibc (building or binaries)?
References: <43EF7C06.3080006@wpkg.org>
In-Reply-To: <43EF7C06.3080006@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2006 21:31:51.0780 (UTC) FILETIME=[BCE1C240:01C6301B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10409
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Tomasz Chmielewski wrote:
> I'm trying to cross-compile gcc to work on mipsel / uClibc, to run there 
> natively (that is, I want to compile on this mipsel / uClibc machine).
> 
> So far I have a cross compiler that builds binaries for mipsel/uClibc on 
> a x86 machine.
> 
> 
> According to crosstool HOWTO, "to do a Canadian Cross build with 
> crosstool, you have to run it three times:
> 
>    1. once to build a toolchain that runs on the build system and 
> generates code for the host system
>    2. once to build a toolchain that runs on the build system and 
> generates code for the target system
>    3. once to build a toolchain that runs on the host system and 
> generates code for the target system".
> 
> So I guess the first step is behind me, but I'm not sure how to do steps 
> 2 and 3.
> 
> Anyone knows how to do it?
> Or perhaps, there are already gcc binaries available for mipsel / uClibc?
> 

I have done it for mipsel-linux-glibc, however until last week gcc had 
no support for uClibc, so it will probably not work with uClibc without 
some patching to gcc.

The basic idea is that once you have a working cross toolchain just 
configure gcc and binutils with: --build=i686-pc-linux-glibc 
--target=mipsel-linux --host=mipsel-linux.  This will produce a native 
toolchain.  You will have to copy the compile time portions of the C 
library (include files and link time libraries) to the target, then you 
should be all set.

David Daney.
