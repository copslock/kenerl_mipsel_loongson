Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 18:27:16 +0100 (BST)
Received: from return.false.org ([66.207.162.98]:60301 "EHLO return.false.org")
	by ftp.linux-mips.org with ESMTP id S20021719AbXEWR1O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2007 18:27:14 +0100
Received: from return.false.org (localhost [127.0.0.1])
	by return.false.org (Postfix) with ESMTP id A36084B267;
	Wed, 23 May 2007 12:26:41 -0500 (CDT)
Received: from caradoc.them.org (dsl093-172-095.pit1.dsl.speakeasy.net [66.93.172.95])
	by return.false.org (Postfix) with ESMTP id 821D84B262;
	Wed, 23 May 2007 12:26:41 -0500 (CDT)
Received: from drow by caradoc.them.org with local (Exim 4.67)
	(envelope-from <drow@caradoc.them.org>)
	id 1Hqubg-00061H-TX; Wed, 23 May 2007 13:26:40 -0400
Date:	Wed, 23 May 2007 13:26:40 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, kraj@mvista.com,
	libc-ports@sourceware.org
Subject: Re: [PATCH] Fix some system calls with long long arguments
Message-ID: <20070523172640.GC29019@caradoc.them.org>
References: <20070315.103511.89758184.nemoto@toshiba-tops.co.jp> <20070316.015325.118975069.anemo@mba.ocn.ne.jp> <20070518.004613.128618652.anemo@mba.ocn.ne.jp> <20070518.004759.59650774.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070518.004759.59650774.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.15 (2007-04-09)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, May 18, 2007 at 12:47:59AM +0900, Atsushi Nemoto wrote:
> On Fri, 18 May 2007 00:46:13 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > I fixed N32/O32 readahead, sync_file_range, fadvise, fadvise64
> > syscalls on both kernel and glibc side.
> > 
> > Here is a kernel side fixes.
> 
> And here is glibc side fixes for posix_fadvise, posix_fadvise64,
> readahead, sync_file_range.  For O32, add a padding before a long long
> argument pair.  For N32, pass a long long value by one argument.  O32
> readahead borrows ARM EABI implementation.  N32 posix_fadvise64 use C
> implementation (instead of syscalls.list) for versioned symbols.

I see the kernel patch was already merged; I've added this to CVS.

-- 
Daniel Jacobowitz
CodeSourcery
