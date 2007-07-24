Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 16:03:36 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64922 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023036AbXGXPDe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jul 2007 16:03:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6OF3XZ9021748;
	Tue, 24 Jul 2007 16:03:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6OF3WOp021747;
	Tue, 24 Jul 2007 16:03:32 +0100
Date:	Tue, 24 Jul 2007 16:03:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix marge error due to conflict in
	arch/mips/kernel/head.S
Message-ID: <20070724150332.GA20621@linux-mips.org>
References: <20070723.000734.08075709.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070723.000734.08075709.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 23, 2007 at 12:07:34AM +0900, Atsushi Nemoto wrote:

> __INIT directive just before kernel_entry was dropped for most
> (i.e. BOOT_RAW=n) platforms by merge accident (perhaps).  This patch
> fixes it and get rid of this warning:

Whatever the reason - applied.

Thanks,

   Ralf
