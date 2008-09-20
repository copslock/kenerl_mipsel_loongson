Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 08:56:33 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:22189 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S30623413AbYITH4a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 08:56:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8K7uSl4024212;
	Sat, 20 Sep 2008 09:56:29 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8K7uSmi024210;
	Sat, 20 Sep 2008 09:56:28 +0200
Date:	Sat, 20 Sep 2008 09:56:28 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Move headfiles to new location below arch/mips/include
Message-ID: <20080920075627.GA22985@linux-mips.org>
References: <48D4A761.7020706@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48D4A761.7020706@avtrex.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 20, 2008 at 12:33:53AM -0700, David Daney wrote:

> This patch on linux-queue:
> 
> commit 77f312878b8b76e96aa0e2f381582e9ea8239e71
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Tue Sep 16 19:48:51 2008 +0200
> 
>     MIPS: Move headfiles to new location below arch/mips/include
> 
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Seems to be a nop.  It doesn't look like any files got moved.

I respun the tree with a fixed patch.

  Ralf
