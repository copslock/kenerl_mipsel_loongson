Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2004 20:38:53 +0100 (BST)
Received: from p508B5E19.dip.t-dialin.net ([IPv6:::ffff:80.139.94.25]:22631
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226156AbUGFTit>; Tue, 6 Jul 2004 20:38:49 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i66Jcmkm010884;
	Tue, 6 Jul 2004 21:38:48 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i66Jcm26010883;
	Tue, 6 Jul 2004 21:38:48 +0200
Date: Tue, 6 Jul 2004 21:38:48 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Kunze <thomas.kunze@xmail.net>
Cc: linux-mips@linux-mips.org
Subject: Re: bootimage for RM300E ?
Message-ID: <20040706193848.GB10125@linux-mips.org>
References: <03b101c46351$96679c90$0200000a@ALEC> <1089123113.40eab32979315@www.x-mail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089123113.40eab32979315@www.x-mail.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 06, 2004 at 07:11:53AM -0800, Thomas Kunze wrote:

> ok i downloaded toolchain. 
> which kernel should i use? that one from kernel.org or from linux-mips.org ?

Wipe the word kernel.org from your brain ;-)

> what should be done next, after create a kernel ? 
> what do i need to create a bootimage for the RM300 ?
> how must this bootimage looks like ?

Just "make rm200_defconfig; make" which will build vmlinux.ecoff which is
the file which can be netbooted via bootp/tftp.  Same procedure as with
SGI machines basically so the usual howtos for SGI IP22 netbooting Linux
apply.

> any howto's ?

In the back of my brain.

  Ralf
