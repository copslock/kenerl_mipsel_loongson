Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Oct 2004 09:30:15 +0100 (BST)
Received: from imladris.demon.co.uk ([IPv6:::ffff:193.237.130.41]:42246 "EHLO
	phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225205AbUJCIaK>; Sun, 3 Oct 2004 09:30:10 +0100
Received: from hch by phoenix.infradead.org with local (Exim 4.42 #2 (Red Hat Linux))
	id 1CE1kV-0007Kb-15; Sun, 03 Oct 2004 09:29:43 +0100
Date: Sun, 3 Oct 2004 09:29:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Scott Feldman <sfeldma@pobox.com>
Cc: kernel-janitors@lists.osdl.org, stevel@mvista.com,
	source@mvista.com, linux-mips@linux-mips.org
Subject: Re: [Kernel-janitors] [PATCH 2/6] janitor: net/gt96100eth: pci_find_device to pci_get_device
Message-ID: <20041003092942.A28174@infradead.org>
References: <1096784371.3819.157.camel@sfeldma-mobl2.dsl-verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096784371.3819.157.camel@sfeldma-mobl2.dsl-verizon.net>; from sfeldma@pobox.com on Sat, Oct 02, 2004 at 11:19:31PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+2a8e9b96702c01185f4b+406+infradead.org+hch@phoenix.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 02, 2004 at 11:19:31PM -0700, Scott Feldman wrote:
> Replace pci_find_device with pci_get_device/pci_dev_put to plug
> race with pci_find_device.

Shouldn't this use pci_dev_present?
