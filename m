Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 21:39:29 +0100 (BST)
Received: from p508B7731.dip.t-dialin.net ([IPv6:::ffff:80.139.119.49]:4694
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225221AbUJFUjZ>; Wed, 6 Oct 2004 21:39:25 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i96KdODq004244;
	Wed, 6 Oct 2004 22:39:24 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i96KdOqM004243;
	Wed, 6 Oct 2004 22:39:24 +0200
Date: Wed, 6 Oct 2004 22:39:24 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Clark Williams <williams@redhat.com>
Cc: MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Asm hack for GCC 3.4 changes
Message-ID: <20041006203924.GC11293@linux-mips.org>
References: <1097076486.3185.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097076486.3185.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 06, 2004 at 10:28:06AM -0500, Clark Williams wrote:

> This is a patch I use on MIPS trees to deal with the changes in the way
> GCC 3.4 handles the 'accum' pseudo register in inline asms. I originally
> just applied it to time.c, but then I noticed that cpu-bugs64.c had an
> inline asm that referenced 'accum', so I lifted the conditional macro
> def to cpu.h, which was the only common header between time.c and
> cpu-bugs64.c. Not really sure it's appropriate for cpu.h, but I didn't
> want to create a new header.
> 
> Hope it's useful.

I was actually waiting for somebody else to commit a similar but more
complete patch into CVS.  His patch was a little more complete but your's
is a bit more stylish ...

Thanks,

  Ralf
