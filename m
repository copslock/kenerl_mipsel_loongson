Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 15:16:33 +0100 (BST)
Received: from p508B58B4.dip.t-dialin.net ([IPv6:::ffff:80.139.88.180]:64430
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225370AbTIKOQd>; Thu, 11 Sep 2003 15:16:33 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8BEGVLT015881;
	Thu, 11 Sep 2003 16:16:31 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8BEGTxF015880;
	Thu, 11 Sep 2003 16:16:29 +0200
Date:	Thu, 11 Sep 2003 16:16:29 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: mips64 _access_ok fix
Message-ID: <20030911141629.GB15365@linux-mips.org>
References: <20030911.124350.41627177.nemoto@toshiba-tops.co.jp> <20030911.134323.03974731.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911.134323.03974731.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 11, 2003 at 01:43:23PM +0900, Atsushi Nemoto wrote:

> I know this fix is not complete.  __access_ok(0, 0, __access_mask)
> will return 0.
> 
> I could not find out good expression (i.e. no conditional branch) to
> handle this case.
> 
> I suppose nobody do take care of this since addr 0 is invalid pointer
> anyway.

That behaviour of __access_ok() is actually ok;  __access_ok only needs
to return non-zero only for addresses >= TASK_SIZE.  For two reason
the case you're mentioning is not a problem.  As you say 0 is (usually)
a bad pointer value so if the kernel tries to dereference it, an
TLB exception is going to happen and the exception handling code will
deal with the case.  Second the size argument is zero and after all
that means the kernel won't touch the address range anyway because
hey, it's zero-length!

  Ralf
