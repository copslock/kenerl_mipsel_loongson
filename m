Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 00:50:57 +0000 (GMT)
Received: from p508B62C3.dip.t-dialin.net ([IPv6:::ffff:80.139.98.195]:44746
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225400AbTKDAup>; Tue, 4 Nov 2003 00:50:45 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id hA40oisY031706;
	Tue, 4 Nov 2003 01:50:44 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hA40oeKd031705;
	Tue, 4 Nov 2003 01:50:40 +0100
Date: Tue, 4 Nov 2003 01:50:39 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: lib.a
Message-ID: <20031104005039.GA27415@linux-mips.org>
References: <Pine.GSO.4.44.0311031717560.24745-100000@ares.mmc.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0311031717560.24745-100000@ares.mmc.atmel.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 03, 2003 at 05:22:42PM -0500, David Kesselring wrote:

> The function that I am missing (release_firmware) is compiled into
> lib/lib.a. and shows up in lib.a.flags. But it does not show up in vmlinux
> binary or the symbol table. I couldn't see that the generic Malta make
> file has any garbage collection on but I can't see where it is lost.
> What I get is unresolved symbols when I insmod my driver.
> Any ideas from the experts?

It's a library so if no reference is preceeding the library that member
won't be linked in.

  Ralf
