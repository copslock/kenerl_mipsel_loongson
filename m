Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 12:01:13 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:30933 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8225334AbUJHLBI>; Fri, 8 Oct 2004 12:01:08 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i98AufGG027602;
	Fri, 8 Oct 2004 16:26:49 +0530
Message-ID: <4166721E.20207@procsys.com>
Date: Fri, 08 Oct 2004 16:25:26 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Daney <ddaney@avtrex.com>
CC: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - Unknown ABI problem
References: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF4D2@avtrex-server.hq.avtrex.com> <4164C1CF.6070708@procsys.com>
In-Reply-To: <4164C1CF.6070708@procsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

T. P. Saravanan wrote:

> OK. I will give the recent CVS version a try some time.
> -Sa.
>
The CVS version fails right at the configure stage itself.  It comes out 
with no
error, but no Makefile too.  Below is the transcript:

sara@eyeore: [over] ~/build/glibc/objdir7$ export CFLAGS="-mips32 
-fno-unit-at-a--time -O2 -g"
sara@eyeore: [over] ~/build/glibc/objdir7$ ../glibc_cvs/configure 
--prefix=/home/sara/usr/local --enable-add-ons=linuxthreads 
--with-headers=/home/sara/build/linux/linux-2.4.25mips/include
checking build system type... mipsel-unknown-linux-gnu
checking host system type... mipsel-unknown-linux-gnu
running configure fragment for add-on linuxthreads
sara@eyeore: [over] ~/build/glibc/objdir7$ make
make: *** No targets specified and no makefile found.  Stop.
sara@eyeore: [over] ~/build/glibc/objdir7$

I there something I missed?

-Sa.
