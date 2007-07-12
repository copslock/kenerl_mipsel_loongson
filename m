Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:57:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:28576 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022561AbXGLQ54 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 17:57:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CGgrSH021226;
	Thu, 12 Jul 2007 17:42:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CGgqdQ021225;
	Thu, 12 Jul 2007 17:42:52 +0100
Date:	Thu, 12 Jul 2007 17:42:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Use NULL for pointer
Message-ID: <20070712164252.GA21194@linux-mips.org>
References: <20070713.014949.55147875.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713.014949.55147875.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 01:49:49AM +0900, Atsushi Nemoto wrote:

> This fixes a sparse warning:
> 
> arch/mips/kernel/traps.c:376:44: warning: Using plain integer as NULL pointer

Also applied.

  Ralf
