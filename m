Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 19:50:57 +0200 (CEST)
Received: from p508B69CC.dip.t-dialin.net ([80.139.105.204]:38800 "EHLO
	p508B69CC.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1123253AbSJYRu4>; Fri, 25 Oct 2002 19:50:56 +0200
Received: from sccrmhc01.attbi.com ([IPv6:::ffff:204.127.202.61]:14738 "EHLO
	sccrmhc01.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSJYRuu>; Fri, 25 Oct 2002 19:50:50 +0200
Received: from lucon.org ([12.234.88.146]) by sccrmhc01.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021025175035.HITW27756.sccrmhc01.attbi.com@lucon.org>;
          Fri, 25 Oct 2002 17:50:35 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 289E32C4EC; Fri, 25 Oct 2002 10:50:34 -0700 (PDT)
Date: Fri, 25 Oct 2002 10:50:34 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021025105034.A16528@lucon.org>
References: <3DB97381.8070501@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB97381.8070501@realitydiluted.com>; from sjhill@realitydiluted.com on Fri, Oct 25, 2002 at 11:38:25AM -0500
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 11:38:25AM -0500, Steven J. Hill wrote:
> Greetings.
> 
> I'm doing something stupid here, so please help me out. I am trying
> to create a shared library with gcc passing parameters to the linker
> and it is not working.
> 
> I compiled all the object files with '-mips2' and then I attempt to
> create the shared library with:
> 
>     mipsel-linux-gcc -shared -Wl,-Amips2,-soname,libz.so.1 \
>        -o libz.so.1.1.4 adler32.o compress.o crc32.o gzio.o \
>        uncompr.o deflate.o trees.o zutil.o inflate.o infblock.o \
>        inftrees.o infcodes.o infutil.o inffast.o
> 
> The object files are all mips2, but the generated '.so' object
> is mips1?! What am I not understanding? I am using binutils-2.13,
> gcc-3.2 and uClibc-0.9.15. The use of uClibc is not the problem.
> 

That is a bug in the FSF binutils. I believe I fixed it in my Linux
binutils:

http://sources.redhat.com/ml/binutils/2001-10/msg00526.html

Please try my Linux binutils. 


H.J.
