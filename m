Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 16:05:45 +0000 (GMT)
Received: from p508B6CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.108.197]:51591
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225432AbTLMQFo>; Sat, 13 Dec 2003 16:05:44 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBDG5boK020431;
	Sat, 13 Dec 2003 17:05:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBDG5a89020430;
	Sat, 13 Dec 2003 17:05:36 +0100
Date: Sat, 13 Dec 2003 17:05:36 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213160536.GA13271@linux-mips.org>
References: <20031213114134.GA9896@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213114134.GA9896@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 13, 2003 at 11:41:34AM +0000, Peter Horton wrote:

> The current MIPS 2.4 kernel (from CVS) currently allows fixed shared
> mappings to violate D-cache aliasing constraints.
> 
> The check for illegal fixed mappings is done in
> arch_get_unmapped_area(), but these mappings are granted in
> get_unmapped_area() and arch_get_unmapped_area() is never called.
> 
> A quick look at sparc and sparc64 seem to show the same problem.

Ehh...  <asm/pgtable.h> defines HAVE_ARCH_UNMAPPED_AREA therefore
get_unmapped_area calls the arch's version of arch_get_unmapped_area
instead of the generic version in mm/mmap.c

  Ralf
