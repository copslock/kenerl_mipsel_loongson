Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2004 01:48:13 +0000 (GMT)
Received: from pD95629F8.dip.t-dialin.net ([IPv6:::ffff:217.86.41.248]:35604
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224917AbUKKBsI>; Thu, 11 Nov 2004 01:48:08 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAB1m6JD030065;
	Thu, 11 Nov 2004 02:48:06 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAB1lxHF030064;
	Thu, 11 Nov 2004 02:47:59 +0100
Date: Thu, 11 Nov 2004 02:47:59 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: linux-mips@linux-mips.org, libc-alpha@sources.redhat.com,
	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS/Linux: Kernel vs libc struct siginfo discrepancy
Message-ID: <20041111014759.GA29699@linux-mips.org>
References: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411101657420.11408@perivale.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 10, 2004 at 05:18:02PM +0000, Maciej W. Rozycki wrote:

> http://www.linux-mips.org/cvsweb/linux/include/asm-mips/siginfo.h.diff?r1=1.4&r2=1.5&only_with_tag=MAIN
> 
> dated back to Aug 1999 (!), the definitions of struct siginfo in Linux and 
> GNU libc differ to each other.  While it's the kernel that is at fault by 
> changing its ABI, at this stage it may be more acceptable to update glibc 
> as it's not the only program interfacing to Linux (uClibc?).  It doesn't 

uClibc copies it's headers from glibc it seems.  The change in 1999 was
quite intensional because back then there was no SA_SIGINFO using libc for
MIPS yet.

  Ralf
