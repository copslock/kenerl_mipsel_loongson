Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 21:26:48 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:60806 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20038916AbWJCU0o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 21:26:44 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id 203DB3B8FE;
	Tue,  3 Oct 2006 13:20:58 -0700 (PDT)
Subject: Re: Roll-your-own Toolchain Builds
From:	Jim Wilson <wilson@specifix.com>
To:	Pak Woon <pak.woon@nec.com.au>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4522175B.80901@nec.com.au>
References: <20061002231432.733374f7.yoichi_yuasa@tripeaks.co.jp>
	 <20061002151800.GA25180@linux-mips.org>
	 <200610030144.k931i4TD002658@mbox32.po.2iij.net>
	 <4522175B.80901@nec.com.au>
Content-Type: text/plain
Date:	Tue, 03 Oct 2006 13:25:47 -0700
Message-Id: <1159907147.23111.14.camel@dhcp-128-107-166-62.cisco.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Tue, 2006-10-03 at 17:55 +1000, Pak Woon wrote:
> I am trying to roll-my-own toolchain by following the instructions 
> outlined in http://www.linux-mips.org/wiki/Toolchains. I have 
> encountered the "cannot create executables" / "crt01.o: No such file" 

This is lacking the details and context necessary to understand what is
going on.  What exactly command did you type?  What exactly was the
error you got?  What was the make output leading up to the error?

Thinking about this a bit, I think the problem you ran into here is that
the instructions given on the web site are for building a kernel only
compiler.  This is not a compiler that you can use for building
applications, as there is no glibc.  This is also not a compiler that
you can use for building gcc libraries.

So the problem here is that gcc-4.x contains more libraries than
gcc-3.x, including some written in C.  The instructions say to use
--enable-languages=c when configuring, and then type make all.  This
will work in gcc-3.x as there are no libraries for the C front end.
This will not work for gcc-4.x, as there is at least one library for the
C front end, namely mudflap.  So I am guessing you got the error while
configuring libmudflap.

The solution is to use "make all-gcc" instead of "make all" when
building gcc.  This will build only the compiler (and libgcc), without
any of the target libraries, that are unneeded for a kernel compiler.
If this works, perhaps the instructions on the wiki should be changed.
Using "make all-gcc" should work for all gcc versions.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
