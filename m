Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2006 17:50:54 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:39345 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133582AbWFNQup (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2006 17:50:45 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FqYZk-000599-89; Wed, 14 Jun 2006 12:50:40 -0400
Date:	Wed, 14 Jun 2006 12:50:40 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	libc-ports@sourceware.org, linux-mips@linux-mips.org
Subject: Re: mips RDHWR instruction in glibc
Message-ID: <20060614165040.GA19480@nevyn.them.org>
References: <20060615.001238.65193088.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615.001238.65193088.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 15, 2006 at 12:12:38AM +0900, Atsushi Nemoto wrote:
> If a system call returned an error, glibc must save the result to
> errno, which is thread-local, so RDHWR used.  I can understand this
> scenario.  But it seems the RDHWR is often called on non-error cases.

Libc uses TLS for many things other than just errno.  The GCC port
knows how to generate the agreed-upon rdhwr instruction directly.

> For example, in the code below, RDHWR is placed _before_ checking the
> error.  I suppose these instructions were reordered by gcc's
> optimization, but the optimization would have large negative effect in
> this case.

You'd have to figure out how to get GCC not to eagerly schedule the
rdhwr.  This might be quite hard.  I don't know much about this part of
the scheduler.

-- 
Daniel Jacobowitz
CodeSourcery
