Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 17:53:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45233 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022950AbXJ2Rww (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 17:52:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9THqSd0009533;
	Mon, 29 Oct 2007 17:52:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9THpRhs009471;
	Mon, 29 Oct 2007 17:51:27 GMT
Date:	Mon, 29 Oct 2007 17:51:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Add len and addr validation for MAP_FIXED
	mappings.
Message-ID: <20071029175127.GC3953@linux-mips.org>
References: <472427CC.4000406@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472427CC.4000406@avtrex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 27, 2007 at 11:10:20PM -0700, David Daney wrote:

> mmap with MAP_FIXED was not validating the addr and len parameters.
> This leads to the failure of GCC's gcc.c-torture/execute/loop-2[fg].c
> testcases when using the o32 ABI on a 64 bit kernel.
> 
> These testcases try to mmap 65536 bytes at 0x7fff8000 and then access
> all the memory.  In 2.6.18 and 2.6.23.1 (and likely other versions as
> well) the kernel maps the requested memory, but since half of it is
> above 0x80000000 a SIGBUS is generated when it is accessed.
> 
> This patch moves the len validation above the MAP_FIXED processing so
> that it is always validated.  It also adds validation to the addr
> parameter for MAP_FIXED mappings.

Thanks, applied.

  Ralf
