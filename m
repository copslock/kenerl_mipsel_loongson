Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 00:14:06 +0100 (BST)
Received: from p508B5DDF.dip.t-dialin.net ([IPv6:::ffff:80.139.93.223]:55893
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225842AbUGLXOC>; Tue, 13 Jul 2004 00:14:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6CNDx8U014071;
	Tue, 13 Jul 2004 01:13:59 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6CNDxXt014070;
	Tue, 13 Jul 2004 01:13:59 +0200
Date: Tue, 13 Jul 2004 01:13:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <KevinK@mips.com>
Cc: S C <theansweriz42@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Strange, strange occurence
Message-ID: <20040712231359.GC6176@linux-mips.org>
References: <BAY2-F27mxl2RtYP35u0000d191@hotmail.com> <020201c46859$fa6b98b0$0deca8c0@Ulysses> <021201c4685f$2925ee30$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021201c4685f$2925ee30$0deca8c0@Ulysses>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 13, 2004 at 12:25:37AM +0200, Kevin D. Kissell wrote:

> Hmm.  On closer examination, there *is* a bug in the current r4k_flush_icache_range(),
> in that it computes its cache flush loop for the I-cache based on the D-cache line size.
> Those line sizes are *usually* the same.  By any chance are they different for the
> TX49 family?  If the icache line is longer than the dcache line, there should be no
> functional problem, just some wasted cycles.  But if the dcache line were, say, 
> twice the length of the Icache line, only half of the icache lines would be invalidated...

Whoops.  Fixing ...

  Ralf
