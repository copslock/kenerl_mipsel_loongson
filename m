Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 12:55:44 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42980 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026671AbXLNMxt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 12:53:49 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBECrX3w029660;
	Fri, 14 Dec 2007 12:53:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBE03mWZ019698;
	Fri, 14 Dec 2007 00:03:48 GMT
Date:	Fri, 14 Dec 2007 00:03:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Frank Rowand <frank.rowand@am.sony.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] RBTX4927: linux-2.6.24-rc4 hang on boot
Message-ID: <20071214000348.GA12983@linux-mips.org>
References: <1197386187.5610.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1197386187.5610.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 11, 2007 at 10:16:27AM -0500, Frank Rowand wrote:

> In linux-2.6.24-rc4 the Toshiba RBTX4927 hangs on boot.
> 
> The cause is that plat_time_init() from arch/mips/tx4927/common/tx4927_setup.c
> does not override the __weak plat_time_init() from arch/mips/kernel/time.c.
> This is due to a compiler bug in gcc 4.1.1.  The bug is reported to not exist
> in earlier versions of gcc, and to be fixed in 4.1.2.  The problem is that
> the __weak plat_time_init() is empty and thus gets optimized out of
> existence (thus the linker is never given the option to replace the
> __weak function).

You meant the call to plat_time_init() from time_init() gets optimized away.

> For more info on the gcc bug see
> 
>    http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27781
> 
> The attached patch is one workaround.  Another possible workaround
> would be to change the __weak plat_time_init() to be a non-empty
> function.

The __weak definition of plat_time_init was only ever meant to be a
migration helper to keep platforms that don't have a plat_time_init
compiling.  A few greps says that all platforms now supply their own
plat_time_init() so the weak definition is no longer needed.  So I
instead delete it.

  Ralf
