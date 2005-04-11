Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2005 13:47:03 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:44830 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226104AbVDKMqt>; Mon, 11 Apr 2005 13:46:49 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3BCkhc1019749;
	Mon, 11 Apr 2005 13:46:43 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3BCkhnf019748;
	Mon, 11 Apr 2005 13:46:43 +0100
Date:	Mon, 11 Apr 2005 13:46:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH Cobalt 3/3] add PCI retry error handler
Message-ID: <20050411124643.GB19115@linux-mips.org>
References: <20050410131137.GA20709@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410131137.GA20709@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 10, 2005 at 02:11:37PM +0100, Peter Horton wrote:

> Add PCI retry error handler. We can drop the check for the device #6
> from pci_range_ck() as we now get a diagnostic message and the kernel
> continues the boot.

Applied,

  Ralf
