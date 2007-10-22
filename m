Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 22:04:04 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:12686 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021471AbXJVVEC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 22:04:02 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9ML41vZ021061;
	Mon, 22 Oct 2007 22:04:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9ML40LJ021060;
	Mon, 22 Oct 2007 22:04:00 +0100
Date:	Mon, 22 Oct 2007 22:04:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Make c0_compare_int_usable faster
Message-ID: <20071022210400.GB20038@linux-mips.org>
References: <20071023.011416.61947729.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023.011416.61947729.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 01:14:16AM +0900, Atsushi Nemoto wrote:

> Use delta value based on its speed for faster probing.

Still the same issue, it breaks with Qemu.  You probably don't see this
if you're testing on a desktop where the TSC is used for timing but on
a laptop it breaks big time.  I need to increase the shift value to at
least like 15 to get it to work more or less reliably with Qemu, so a
somewhat different approach is needed.

  Ralf
