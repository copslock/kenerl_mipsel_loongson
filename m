Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 13:56:36 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:31164 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20021877AbXJJM41 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2007 13:56:27 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id C9A079833B;
	Wed, 10 Oct 2007 12:55:54 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id B1E3298339;
	Wed, 10 Oct 2007 12:55:54 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.68)
	(envelope-from <drow@caradoc.them.org>)
	id 1Ifb6P-00052U-Ma; Wed, 10 Oct 2007 08:55:53 -0400
Date:	Wed, 10 Oct 2007 08:55:53 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ricardo Mendoza <ricmm@kanux.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: O2 KGDB problem
Message-ID: <20071010125553.GA18207@caradoc.them.org>
References: <470C8F8E.3010301@kanux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470C8F8E.3010301@kanux.com>
User-Agent: Mutt/1.5.15 (2007-04-09)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 10, 2007 at 04:38:38AM -0400, Ricardo Mendoza wrote:
> Been messing around with the O2 and KGDB and well, theres a problem that
> I don't quite know how to tackle, when building a 64-bit kernel with
> mips64 target toolchain and with CONFIG_BUILD_ELF64 and then trying to
> start remote gdb with that image I get a Segfault from gdb. What do you
> think is the cause of this?
> 
> I guess its just file format mixup confusing gdb? any pointer from a gdb
> guru
> towards making this work?

I believe a CVS snapshot of GDB will "work" but refuse to show you
line numbers, and if you use a CVS snapshot of gas too then things
will work OK.  gas was doing something horribly wrong to the
.debug_line sections it generated.

-- 
Daniel Jacobowitz
CodeSourcery
