Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 02:13:39 +0100 (BST)
Received: from p508B7013.dip.t-dialin.net ([IPv6:::ffff:80.139.112.19]:5796
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225531AbTJVBNh>; Wed, 22 Oct 2003 02:13:37 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9M1DSNK005469;
	Wed, 22 Oct 2003 03:13:28 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9M1DOrI005462;
	Wed, 22 Oct 2003 03:13:24 +0200
Date: Wed, 22 Oct 2003 03:13:24 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Jeff Dike <jdike@karaya.com>, linux-mips@linux-mips.org,
	user-mode-linux-devel@lists.sourceforge.net
Subject: Re: asm/smplock.h is dead
Message-ID: <20031022011324.GC2609@linux-mips.org>
References: <20031021230932.GM18370@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021230932.GM18370@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 22, 2003 at 12:09:32AM +0100, Matthew Wilcox wrote:

> Can you delete next time you merge?  Thanks.
> 
> $ find -type f |xargs grep smplock.h      
> ./arch/mips/sibyte/sb1250/bcm1250_tbprof.c:#include <asm/smplock.h>
> ./include/asm-h8300/smplock.h: * <asm/smplock.h>
> ./include/asm-um/smplock.h:#include "asm/arch/smplock.h"
> $ find -name smplock.h
> ./include/asm-h8300/smplock.h
> ./include/asm-mips/smplock.h
> ./include/asm-um/smplock.h
> 
> (the sibyte driver can just lose this line.  it doesn't do any SMP locking)

Thanks, zapped on MIPS.

  Ralf
