Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 19:53:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2485 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021747AbXGaSxk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jul 2007 19:53:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6VIrcLs030796;
	Tue, 31 Jul 2007 19:53:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6VIrb4b030795;
	Tue, 31 Jul 2007 19:53:37 +0100
Date:	Tue, 31 Jul 2007 19:53:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc:	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 48] include/asm-mips/thread_info.h: kmalloc + memset
	conversion to kzalloc
Message-ID: <20070731185337.GA30328@linux-mips.org>
References: <200707311845.48807.m.kozlowski@tuxland.pl> <200707312048.42172.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707312048.42172.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 31, 2007 at 08:48:41PM +0200, Mariusz Kozlowski wrote:

Thanks, applied.
