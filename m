Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 12:36:06 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25736 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022185AbXGILgE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 12:36:04 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l69BSIdj030863;
	Mon, 9 Jul 2007 12:28:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l69BSHJD030862;
	Mon, 9 Jul 2007 12:28:17 +0100
Date:	Mon, 9 Jul 2007 12:28:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add debugfs files to show fpuemu statistics
Message-ID: <20070709112817.GA30822@linux-mips.org>
References: <20070707.232149.25909198.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070707.232149.25909198.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 07, 2007 at 11:21:49PM +0900, Atsushi Nemoto wrote:

> Export contents of struct mips_fpu_emulator_stats via debugfs.

Thanks, queued.

One of my colleagues will probably very happy that these stats are finally
available again.

  Ralf
