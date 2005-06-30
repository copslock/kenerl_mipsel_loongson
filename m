Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 11:11:10 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:58903 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225722AbVF3KKy>; Thu, 30 Jun 2005 11:10:54 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j5UA75BP007516;
	Thu, 30 Jun 2005 11:07:05 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j5UA75k6007515;
	Thu, 30 Jun 2005 11:07:05 +0100
Date:	Thu, 30 Jun 2005 11:07:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: can't find interrupt number under /proc/interrupts for the pci multi-port on db1550
Message-ID: <20050630100705.GD2935@linux-mips.org>
References: <2db32b720506271706201a66fb@mail.gmail.com> <20050628211559.GA2879@linux-mips.org> <2db32b72050629152010dab81d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db32b72050629152010dab81d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 29, 2005 at 03:20:56PM -0700, rolf liu wrote:

> What is the function of serial_timer? it is just sitting there,
> generating timeout, periodically. Just to make sure the interrupt
> routine will be called periodically?

It's for interrupt-less ports.

  Ralf
