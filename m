Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 03:46:17 +0000 (GMT)
Received: from p508B6259.dip.t-dialin.net ([IPv6:::ffff:80.139.98.89]:25724
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225214AbUARDqJ>; Sun, 18 Jan 2004 03:46:09 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0I3k84P019665;
	Sun, 18 Jan 2004 04:46:08 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0I3k7Vu019664;
	Sun, 18 Jan 2004 04:46:07 +0100
Date: Sun, 18 Jan 2004 04:46:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adam Nielsen <a.nielsen@optushome.com.au>
Cc: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Message-ID: <20040118034607.GB1347@linux-mips.org>
References: <200401171711.34964@korath> <20040117163355.GE5288@linux-mips.org> <200401181119.15234@korath> <200401181154.22007@korath>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401181154.22007@korath>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 18, 2004 at 11:54:22AM +1000, Adam Nielsen wrote:

> > I'll try an older version of the binutils and see if that fixes it.
> 
> Well, I downgraded to binutils 2.13.2.1 and it got past the -mcpu error, but 
> now I get this error instead (I'm compiling a stock 2.6.0 kernel with gcc 
> 2.95.3):
> 
> include/asm/sgidefs.h:18: #error Use a Linux compiler or give up.
> 
> followed by hundreds of other various errors.  So I'm stuck again ;-)  Any 
> ideas?  I'm guessing I need to get a newer compiler...?

No, a Linux compiler, not the one from the corn flakes package ;-)

  Ralf
