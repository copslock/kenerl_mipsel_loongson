Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2007 21:59:10 +0100 (BST)
Received: from gate.crashing.org ([63.228.1.57]:22743 "EHLO gate.crashing.org")
	by ftp.linux-mips.org with ESMTP id S20022163AbXHUU7H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2007 21:59:07 +0100
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7LKuqvQ003059;
	Tue, 21 Aug 2007 15:56:53 -0500
In-Reply-To: <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
References: <20070821132038.GA22254@ff.dom.local> <20070821093103.3c097d4a.randy.dunlap@oracle.com> <20070821173550.GC30705@stusta.de> <20070821182505.GA20968@puku.stupidest.org> <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ea37408ece5ef8d2382ad551f74912eb@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc:	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Randy Dunlap" <randy.dunlap@oracle.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	"Jarek Poplawski" <jarkao2@o2.pl>, "Adrian Bunk" <bunk@kernel.org>,
	"Chris Wedgwood" <cw@f00f.org>, linux-arch@vger.kernel.org,
	"Andrew Morton" <akpm@linux-foundation.org>
From:	Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: RFC: drop support for gcc < 4.0
Date:	Tue, 21 Aug 2007 22:56:52 +0200
To:	"Glauber de Oliveira Costa" <glommer@gmail.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <segher@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: segher@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

> Last time I tried a mips build, it would fail the compile unless I was
> using _exactly_ 3.4.4 (I didn't tried older versions, but did try
> 3.4.6, for ex.).

If 3.4.4 works where 3.4.6 doesn't, you should report this as a
bug; either here, or to the GCC team (but please be aware that the
3.4 series isn't supported anymore), or to whoever built that
compiler for you.

> So I also think the 3.4 series will still have to be
> around for a while.

Huh?  3.4 doesn't work for you, so that's why it should stay
a supported compiler?


Segher
