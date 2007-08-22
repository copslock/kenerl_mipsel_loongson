Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Aug 2007 19:15:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34764 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022879AbXHVSPf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Aug 2007 19:15:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7MIFYU4004376;
	Wed, 22 Aug 2007 19:15:34 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MIFWMI004375;
	Wed, 22 Aug 2007 19:15:32 +0100
Date:	Wed, 22 Aug 2007 19:15:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Glauber de Oliveira Costa <glommer@gmail.com>
Cc:	Chris Wedgwood <cw@f00f.org>, Adrian Bunk <bunk@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: RFC: drop support for gcc < 4.0
Message-ID: <20070822181532.GB3362@linux-mips.org>
References: <20070821132038.GA22254@ff.dom.local> <20070821093103.3c097d4a.randy.dunlap@oracle.com> <20070821173550.GC30705@stusta.de> <20070821182505.GA20968@puku.stupidest.org> <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 21, 2007 at 05:41:04PM -0300, Glauber de Oliveira Costa wrote:

> Last time I tried a mips build, it would fail the compile unless I was
> using _exactly_ 3.4.4 (I didn't tried older versions, but did try
> 3.4.6, for ex.). So I also think the 3.4 series will still have to be
> around for a while.

I don't know what broken MIPS platform you've tried.  I keep changing
between compiler versions all the time just so I can ensure builds with
older compilers keep working until we officially deciede to drop support
for them.  So the minimum compiler version for 32-bit MIPS kernels is
gcc 3.2 and for 64-bit kernel gcc 3.3.

But for sake of sanity and productivity I definately don't mind dumping
support for gcc < 4.0 or maybe even 4.1.  And while we're at it, let's
deprecate ancient binutils version as well.  A minimum version of 2.17
would be nice as I could get rid of lads of .word sillyness which is
needed to support older binutils.

  Ralf
