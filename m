Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 15:12:30 +0100 (BST)
Received: from p508B6D44.dip.t-dialin.net ([IPv6:::ffff:80.139.109.68]:49382
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225227AbTFBOM2>; Mon, 2 Jun 2003 15:12:28 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h52ECObY028498;
	Mon, 2 Jun 2003 07:12:25 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h52ECMLA027859;
	Mon, 2 Jun 2003 16:12:22 +0200
Date: Mon, 2 Jun 2003 16:12:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Keith Owens <kaos@sgi.com>
Cc: ilya@theIlya.com, linux-mips@linux-mips.org
Subject: Re: Yet another fix
Message-ID: <20030602141222.GA25568@linux-mips.org>
References: <20030602045700.GI3035@gateway.total-knowledge.com> <5368.1054560466@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5368.1054560466@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 02, 2003 at 11:27:46PM +1000, Keith Owens wrote:

> Not in 2.4.20 nor 2.4.21-rc6 from Marcelo, must be a mips local change.
> I strongly suggest that you get rid of it, there is no good reason to
> emulate the 32 bit module syscalls on a 64 bit machine.  modutils is
> pure Linux and there is absolutely no justification for emulating 32
> bit versions of modutils when the user can install the 64 bit version
> of modutils instead.  32 bit emulation is a crutch to let binary only
> programs work when you do not have the source to rebuild to 64 bit, by
> definition we have the source to modutils.

Until very recently there was no 64-bit userland.

> IA64 and x86_64 make no attempt to emulate 32 bit modutils.  sparc64,
> ppc64 and s390x all pass the data straight to the 64 bit kernel code,
> they require the user space modutils to supply 64 bit data.  Emulation
> is a waste of time.

The code simply does the sparc64 thing.  Heck, it is the sparc64 code
with minor changes.

  Ralf
