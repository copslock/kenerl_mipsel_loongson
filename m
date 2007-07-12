Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 17:20:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46031 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022559AbXGLQUP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 17:20:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CG5C5d008066;
	Thu, 12 Jul 2007 17:05:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CG5Br8008058;
	Thu, 12 Jul 2007 17:05:11 +0100
Date:	Thu, 12 Jul 2007 17:05:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix gcc warning in arch/mips/pci/pci.c
Message-ID: <20070712160511.GA4787@linux-mips.org>
References: <20070713.011625.37531838.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070713.011625.37531838.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 13, 2007 at 01:16:25AM +0900, Atsushi Nemoto wrote:

> Now pcibios_map_irq() takes a const pointer.  Cast it to adapt
> pci_fixup_irqs().

I got a patch here to change pci_fixup_irqs to expect a const * as the
second argument but that still needs a little testing on other
architectures.

  Ralf
