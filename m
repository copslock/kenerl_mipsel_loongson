Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Oct 2002 23:06:24 +0200 (CEST)
Received: from p508B69CC.dip.t-dialin.net ([80.139.105.204]:64912 "EHLO
	p508B69CC.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1124126AbSJYVGX>; Fri, 25 Oct 2002 23:06:23 +0200
Received: from sccrmhc02.attbi.com ([IPv6:::ffff:204.127.202.62]:15824 "EHLO
	sccrmhc02.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S867025AbSJYVGQ>; Fri, 25 Oct 2002 23:06:16 +0200
Received: from lucon.org ([12.234.88.146]) by sccrmhc02.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021025210600.OIHG3104.sccrmhc02.attbi.com@lucon.org>;
          Fri, 25 Oct 2002 21:06:00 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id C23E82C4EC; Fri, 25 Oct 2002 14:05:59 -0700 (PDT)
Date: Fri, 25 Oct 2002 14:05:59 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Dennis Newbold <dennisn@pe.net>
Cc: linux-mips@linux-mips.org
Subject: Re: GCC generating wrong assembly code?
Message-ID: <20021025140559.E19165@lucon.org>
References: <Pine.GSO.3.96.1021025110042.28181A-101000@shell1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021025110042.28181A-101000@shell1>; from dennisn@pe.net on Fri, Oct 25, 2002 at 11:30:36AM -0700
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 25, 2002 at 11:30:36AM -0700, Dennis Newbold wrote:
> Dear Linux-mips list members:
> 
>      I'm trying to build gcj (GNU Java ahead-of-time compiler) from
> the sources.  It ran for quite awhile, and then on a particular file,
> it got about 20 "Error: branch out of range" errors from the gas
> assembler.  I'm hoping that someone on this list that understands gcc
> and mips assembler better than I can suggest a command-line switch or
> some other way to get gcc to generate code which does not result in
> this error.
> 
> Details:  source file, and assembler output file are in the attached zip
> file.  Command line used to invoke gcc is:
> 
> gcc -c -g -DIN_GCC -W -Wall -Wwrite-strings -Wstrict-prototypes
> -Wmissing-prototypes -Wtraditional -fno-common -DHAVE_CONFIG_H -I.
> -I../../gcc/gcc -I../../gcc/gcc/config -I../../gcc/include
> ../../gcc/gcc/expr.c
> 
> Assembly output file was produced using the above command line, replacing
> "-c" with "-S".
> 
> I'm building it with  gcc 2.95.3 and GNU make vers. 3.75 on a Linux-mips
> system. The configure script says that the cpu type is
> mipsel-pc-linux-gnu.  In any case, the processor is the QED (now
> PMC-Sierra) RM5230.
> 
> Also, if anyone has successfully built gcj for a MIPS system, and would
> mind sending me a copy of the binary executable(s), that would work too.
> 

The gcc 3.2 mips/mipsel binary rpms for RedHat 7.3 are at

ftp://ftp.linux-mips.org/pub/linux/mips/redhat/7.3/test/

They come from my RedHat 8.0 MIPS port. The simple install instructions
are in INSTALL. I am interested in any feedbacks.

gcj is in there.


H.J.
