Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 14:16:06 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39218 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024109AbZE0NP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 May 2009 14:15:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4RDFd3V006418;
	Wed, 27 May 2009 14:15:40 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4RDFZCu006416;
	Wed, 27 May 2009 14:15:35 +0100
Date:	Wed, 27 May 2009 14:15:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] rb532: fix irq number check in rb532_set_type
Message-ID: <20090527131535.GC7755@linux-mips.org>
References: <200905271414.07074.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200905271414.07074.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 27, 2009 at 02:14:06PM +0200, Florian Fainelli wrote:

> We only have 14 GPIO interrupt sources numbered
> from 0 to 13. Therefore the check against irq_nr
> in rb532_set_type is off-by-one. This fixes a mistake
> introduced by commit 1b4f571632ffb0caa4170d886694f2555c0d9a4b.

Thanks; I've folded this patch into your old patch.

A note on commit IDs on the -queue tree.  The -queue tree is really
maintained in quilt and respun every time I change any of the commits
on it.  This means the commit IDs will also change, so they should be
considered volatile.

  Ralf
