Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 May 2004 08:18:28 +0100 (BST)
Received: from p508B5C6F.dip.t-dialin.net ([IPv6:::ffff:80.139.92.111]:51254
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbUEHHS1>; Sat, 8 May 2004 08:18:27 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i487IPxT029710;
	Sat, 8 May 2004 09:18:26 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i487IMjm029709;
	Sat, 8 May 2004 09:18:22 +0200
Date: Sat, 8 May 2004 09:18:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
Message-ID: <20040508071822.GA29554@linux-mips.org>
References: <20040507181031.F9702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507181031.F9702@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 07, 2004 at 06:10:31PM -0700, Jun Sun wrote:

> I got a bunch of segfaults which are due to HAS_LLSCD cpu operating
> on a semaphore which is aligned along 4-byte boundary instead of the
> desired 8-byte boundary.

Dare to give a complete version number?  I've dumped 2.4 on all my systems
months ago and never have seen this problem except with slab debugging
enabled - but that side effect of slab debugging is known since years.

  Ralf
