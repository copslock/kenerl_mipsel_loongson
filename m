Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2004 17:17:19 +0100 (BST)
Received: from p508B5AC4.dip.t-dialin.net ([IPv6:::ffff:80.139.90.196]:54347
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224987AbUE0P7t>; Thu, 27 May 2004 16:59:49 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4RFxmGg005006;
	Thu, 27 May 2004 17:59:48 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4RFxl12005005;
	Thu, 27 May 2004 17:59:47 +0200
Date: Thu, 27 May 2004 17:59:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bit arithmetics?
Message-ID: <20040527155947.GA4154@linux-mips.org>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com> <20040526203346.GA8430@linux-mips.org> <1085668313.20233.1249.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085668313.20233.1249.camel@avalon.france.sdesigns.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5205
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 27, 2004 at 04:31:53PM +0200, Emmanuel Michon wrote:

> On 64bit you substract 1ULL<<32
> 
> Substracting 1 is enough for it to be algorithmically correct even on
> 64bit

> Do you accept a patch with the version for CONFIG_LLSC = y using a
> substraction by 1?

This sounds wrong - the current algorithm is manipulating two 32-bit
variables held in a single register.  If you change the algorithm like
this you will manipulate the wrong variable.  Anyway, I don't see why the
code fails for you.  With CONFIG_CPU_HAS_LLSC set and CONFIG_CPU_HAS_LLDSCD
disabled it should just work for you.

The suggestion in my prevous mail was meant for a rewrite along the lines
of for example ppc64 - an algorithm that's mostly C and almost portable
even.

  Ralf
