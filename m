Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 12:36:59 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:54962
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225196AbTDVLg6>; Tue, 22 Apr 2003 12:36:58 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3MBagw17998;
	Tue, 22 Apr 2003 13:36:42 +0200
Date: Tue, 22 Apr 2003 13:36:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>, linux-mips@linux-mips.org
Subject: Re: [patch] TANBAC TB0226(NEC VR4131) for v2.5
Message-ID: <20030422133642.A15285@linux-mips.org>
References: <20030422191137.4ac88897.yuasa@hh.iij4u.or.jp> <86lly2ixxa.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86lly2ixxa.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Tue, Apr 22, 2003 at 01:17:21PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 01:17:21PM +0200, Juan Quintela wrote:

> yoichi> +static struct resource vr41xx_pci_mem_resource = {
> yoichi> +	"PCI memory space",
> yoichi> +	VR41XX_PCI_MEM_START,
> yoichi> +	VR41XX_PCI_MEM_END,
> yoichi> +	IORESOURCE_MEM
> yoichi> +};
> 
> Please, use C99 named initializers in the whole file.

I don't think there's much point in using ISO style initializers everywhere.
So far the convention is only to replace the GNU-style inializer.
We unfortunately have a few places where the code got inflated by at least
the factor of 3 because now some code uses the ISO initializers for
everything - for no good reason.

  Ralf
