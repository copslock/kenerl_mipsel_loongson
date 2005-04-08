Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 18:20:27 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:58764 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225417AbVDHRUM>; Fri, 8 Apr 2005 18:20:12 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1DJx9N-0000KA-M7; Fri, 08 Apr 2005 12:20:09 -0500
Subject: Re: NPTL
In-Reply-To: <4256BB4C.2020605@timesys.com>
To:	Greg Weeks <greg.weeks@timesys.com>
Date:	Fri, 8 Apr 2005 12:20:09 -0500 (CDT)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1DJx9N-0000KA-M7@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> I saw the kernel support patch (TLS) a while back and ment to ask what 
> state the gcc/glibc patches were in. Has either been picked up into the 
> gnu projects yet? If they're close I might try building a toolchain and 
> root file system with NPTL to try our test suite on.
> 
The kernel patch has not gone in and probably will not until a lot more
testing has been done. All of the changes to binutils, gcc and glibc
have been checked in and are available from HEAD of cvs for respective
repositories.

-Steve
