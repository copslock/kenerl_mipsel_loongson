Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 14:31:22 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:8881 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20025205AbYFPNbU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 14:31:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5GDUoN2029327;
	Mon, 16 Jun 2008 14:30:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5GDUoAL029320;
	Mon, 16 Jun 2008 14:30:50 +0100
Date:	Mon, 16 Jun 2008 14:30:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] malta_mtd.c: add MODULE_LICENSE
Message-ID: <20080616133049.GA24056@linux-mips.org>
References: <20080615161321.GB7865@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080615161321.GB7865@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jun 15, 2008 at 07:13:21PM +0300, Adrian Bunk wrote:

> This patch adds the missing MODULE_LICENSE("GPL").
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

NACK.  This file is only a module because 2.6.20 wouldn't build otherwise.
That's long fixed.

  Ralf
