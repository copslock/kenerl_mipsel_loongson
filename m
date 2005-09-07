Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 15:47:32 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:30158 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225267AbVIGOrO>; Wed, 7 Sep 2005 15:47:14 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1ED0Ng-0000M8-QH; Wed, 07 Sep 2005 08:54:28 -0500
Subject: Re: MIPS SF toolchain
In-Reply-To: <1126098584.12696.19.camel@localhost.localdomain>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Date:	Wed, 7 Sep 2005 08:54:28 -0500 (CDT)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1ED0Ng-0000M8-QH@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> Can somebody tell me, what is the right way to make a soft float
> toolchain. I tried with crosstool with different flags for configure
> and gcc, but the resulting binaries still contains the FP instructions, 
> like swc1.
> 
Here are my RPMS and SRPMS for soft float MIPS toolchains. They are a
bit old, but you can at least see the detailed steps necessary to do
it properly. These use uClibc and not glibc however.

-Steve

ftp://ftp.realitydiluted.com/linux/MIPS/toolchains/uclibc-swfp/
