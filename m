Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 16:29:07 +0100 (BST)
Received: from ftp.linux-mips.org ([IPv6:::ffff:62.254.210.162]:2719 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225513AbTIVP2m>; Mon, 22 Sep 2003 16:28:42 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8MFSZXR007276
	for <linux-mips@linux-mips.org>; Mon, 22 Sep 2003 08:28:35 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8L9LmIS001730;
	Sun, 21 Sep 2003 02:21:48 -0700
Date: Sun, 21 Sep 2003 02:21:48 -0700
From: Ralf Baechle <ralf@linux-mips.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org
Subject: Re: ddb5477 fixes for 2.6
Message-ID: <20030921092148.GD1578@linux-mips.org>
References: <20030918163344.GA22013@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918163344.GA22013@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 18, 2003 at 12:33:44PM -0400, Daniel Jacobowitz wrote:

> Here's just enough to make the ddb5477 compile and boot.  The defconfig has
> lost the onboard network card, and you also need to turn on CONFIG_EMBEDDED
> to turn off CONFIG_VT.  Otherwise, conswitchp is uninitialized, causing a
> crash.  If I initialize it to &dummy_con, serial consoles stop working
> (???).

I'm not exactly happy about the way various unrelated options are lumped
together behind CONFIG_EMBEDDED; it seems worse than the problem it's
meant to solve ...

> Userspace doesn't work - lots of scripts segfault, portmap times out, there
> are a number of other glitches.  init=/bin/bash hangs.  But at least it's
> progress.
> 
> I update CFLAGS for gcc 3.3/binutils 2.14.  I think asking people to use
> vaguely modern tools for 2.6 is reasonable.  And the old flags don't work
> any more.  This should work with 3.2 too.

As long as current gcc stays as slow as it is I'm going to stick to
something old.  And I'm not alone.

> The PCI and ac97 changes are pretty mindless merge work.
> 
> Ralf, this re-adds CONFIG_PCI_AUTO.  Do you know where it went? :)  Probably
> a lot of other boards are sad about its disappearance also.

CONFIG_PCI_AUTO went the way to /dev/zero; it not only made the PCI
maintainers make funny sounds it simply seemed superfluous - the PCI
code is supposed to be able to fully configure a PCI bus itself if only
it's used properly.

  Ralf
