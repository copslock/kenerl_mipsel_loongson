Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2007 19:57:10 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32180 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021385AbXIXS5I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Sep 2007 19:57:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8OIv6P1028443;
	Mon, 24 Sep 2007 19:57:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8OIv62b028442;
	Mon, 24 Sep 2007 19:57:06 +0100
Date:	Mon, 24 Sep 2007 19:57:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Johannes Dickgreber <tanzy@gmx.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Question:  sighand_cache is bigger than a page ( it has 4120
	byte) on MIPS64
Message-ID: <20070924185706.GA27812@linux-mips.org>
References: <46F8079F.40108@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F8079F.40108@gmx.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 24, 2007 at 08:53:19PM +0200, Johannes Dickgreber wrote:

> im running MIPS64 kernel on a SGI Octane with 1GByte.
> 
> The cache is that big, because _NSIG on Mips is set to 128.
> On all other arch it is only set to 64.
> Could MIPS use the lower Value ?

One of the historical sins.  Not easy to fix because it would break binary
compatibility.

  Ralf
