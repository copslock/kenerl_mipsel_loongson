Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2005 19:25:03 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:13269 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S3466664AbVKYTYp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2005 19:24:45 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1EfjEU-0001am-Os; Fri, 25 Nov 2005 14:27:42 -0500
Date:	Fri, 25 Nov 2005 14:27:42 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix gdb-stub for kernel compiled with higher ISA level
Message-ID: <20051125192742.GA6013@nevyn.them.org>
References: <20051124.165043.112050815.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124.165043.112050815.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 24, 2005 at 04:50:43PM +0900, Atsushi Nemoto wrote:
> The modern gdb seems to require 64bit values in remote packet for
> 32bit kernel which is compiled with -march=mips3, etc.

FYI, it is a known limitation in GDB that it can't cope with either
format, and I hope to fix it sometime soon.  It's definitely a bug that
it expects 64-bit registers for mips3 32-bit binaries; I think the
change in question was crazy...

You can "set architecture mips:isa32" before connecting to get around
this.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
