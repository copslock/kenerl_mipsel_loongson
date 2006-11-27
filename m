Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2006 19:44:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:897 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038630AbWK0Toe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Nov 2006 19:44:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kARJiP80022257;
	Mon, 27 Nov 2006 19:44:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kARJiH7F022256;
	Mon, 27 Nov 2006 19:44:17 GMT
Date:	Mon, 27 Nov 2006 19:44:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Azer, William" <Bill.Azer@drs-ss.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: pci_ids.h
Message-ID: <20061127194417.GA22048@linux-mips.org>
References: <DEB94D90ABFC8240851346CFD4ACFF14C5590E@gamd-ex-001.ss.drs.master>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEB94D90ABFC8240851346CFD4ACFF14C5590E@gamd-ex-001.ss.drs.master>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 27, 2006 at 02:27:50PM -0500, Azer, William wrote:

> I am using the Tundra Tsi148 device and the Tundra PCI vendor code has
> been de-listed in "include/linux/pci_ids.h" and it is still listed in
> "/usr/share/misc/pci.ids" (with more detail) used by lspci.
> 
> Is there any reason why this may have been?

All PCI device and vendor IDs that are not being used by in-kernel drivers
have been deleted from pci_ids.h.  pci.ids is a separate project from the
kernel and not affected by this decission.

  Ralf
