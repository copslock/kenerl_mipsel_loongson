Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 14:14:03 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:63134 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225313AbVAMON6>; Thu, 13 Jan 2005 14:13:58 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1Cp5jX-0006q9-5D; Thu, 13 Jan 2005 08:13:55 -0600
Subject: Re: unresolved (soft)float symbols
In-Reply-To: <IA9DY0$DCC07516FD959EE0729448D36856A324@scarlet.be>
To: Philippe De Swert <philippedeswert@scarlet.be>
Date: Thu, 13 Jan 2005 08:13:55 -0600 (CST)
CC: linux-mips <linux-mips@linux-mips.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1Cp5jX-0006q9-5D@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> The module builds fine also, but when insmodding I get the following error.
> 
> insmod: unresolved symbol __fixdfsi
> insmod: unresolved symbol __floatsidf
> insmod: unresolved symbol __muldf3
> insmod: unresolved symbol __adddf3
> 
This has nothing to do with floating point in the kernel. It does have
to do with your toolchain. My uClibc soft-float toolchains are a little
out of date, but you can see the exact steps I took to build the SWFP
toolchain for uClibc. Let us know how it goes.

-Steve

   ftp://ftp.realitydiluted.com/linux/MIPS/toolchains/uclibc-swfp
