Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 05:25:06 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:12988
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbTE0EZE>; Tue, 27 May 2003 05:25:04 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R4OibY014096;
	Mon, 26 May 2003 21:24:44 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R4OgqD014095;
	Tue, 27 May 2003 06:24:42 +0200
Date: Tue, 27 May 2003 06:24:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ben Collins <bcollins@debian.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix thinko in mips/mips64 sys_sysmips
Message-ID: <20030527042442.GB14012@linux-mips.org>
References: <20030526143755.GT2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526143755.GT2657@phunnypharm.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 26, 2003 at 10:37:55AM -0400, Ben Collins wrote:

> This has already been fixed in Linus' tree. Here's hoping it gets into
> 2.4 sometime soon. Note in the patch that "node" is the userspace
> pointer and "nodename" is the string where "node" was
> strncpy_from_user()'d to.
> 
> So it really should be using "nodename".

Thanks, applied.

This function being an afaik unused stoneage compatibility function is
a candidate to die anyway ...

  Ralf
