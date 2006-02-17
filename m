Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 15:57:42 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:12038 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133657AbWBQP5d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 17 Feb 2006 15:57:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1HG4CgH025634;
	Fri, 17 Feb 2006 16:04:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1HG4CHH025633;
	Fri, 17 Feb 2006 16:04:12 GMT
Date:	Fri, 17 Feb 2006 16:04:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	joris lijssens <joris_lijssens1980@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch to increase stack size
Message-ID: <20060217160412.GE18396@linux-mips.org>
References: <20060216130236.72703.qmail@web36102.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216130236.72703.qmail@web36102.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 16, 2006 at 01:02:36PM +0000, joris lijssens wrote:

> I was wondering if there is a patch avaible to
> increase the stack size on a mips 2.6 linux kernel. I
> have found one for the i386 that sets the stack size
> from 4K to 16K. But I don't find anything for the mips
> kernel. I would like it if somebody has some info on
> this topic.

If anything the aim is to shrink the kernel stack further.  The larger
allocations are, then less likely they succeed.

32-bit MIPS kernels use 8kB stack,  64-bit uses 16kB stacks.

  Ralf
