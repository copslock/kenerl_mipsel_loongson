Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 08:54:53 +0100 (BST)
Received: from p508B7CAD.dip.t-dialin.net ([IPv6:::ffff:80.139.124.173]:63456
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225464AbTJIHyq>; Thu, 9 Oct 2003 08:54:46 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h997sJNK006941;
	Thu, 9 Oct 2003 09:54:20 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h997sFXg006940;
	Thu, 9 Oct 2003 09:54:15 +0200
Date: Thu, 9 Oct 2003 09:54:15 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: durai <durai@isofttech.com>
Cc: mips <linux-mips@linux-mips.org>
Subject: Re: how to include mips assembly in c code?
Message-ID: <20031009075415.GB19372@linux-mips.org>
References: <007801c38e27$a1c81920$6b00a8c0@DURAI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007801c38e27$a1c81920$6b00a8c0@DURAI>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 09, 2003 at 11:08:56AM +0530, durai wrote:

> I am having the following assembly code and i wanted to call this function
> from a c code.
> can anybody tell me how to include this code in a c program?

Several solutions:

  #define sysWbFlush()	 do { (*(volatile unsigned int *)K1BASE) } while (0)

Or using your existing code:

  extern void sysWbFlush(void);

the call as

  sysWbFlush();

No point in using inline assembler for such a small fragment.

Anyway - I suggest you dump this code and look at <asm/wbflush.h>.

  Ralf
