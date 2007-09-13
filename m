Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 14:55:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:13506 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021900AbXIMNzZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 14:55:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DDtPGR018922;
	Thu, 13 Sep 2007 14:55:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DDtOVP018921;
	Thu, 13 Sep 2007 14:55:24 +0100
Date:	Thu, 13 Sep 2007 14:55:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	chris@mips.com, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
	argument.
Message-ID: <20070913135524.GB11396@linux-mips.org>
References: <20070904.000501.41013092.anemo@mba.ocn.ne.jp> <46DC2D2E.8080408@mips.com> <20070904125010.GA15630@linux-mips.org> <20070904.230202.41011018.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070904.230202.41011018.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 04, 2007 at 11:02:02PM +0900, Atsushi Nemoto wrote:

> Hmm, I see.  Then I think no_pci_device() can be used to avoid such
> case, as like as pci_find_subsys().
> 
> Anyway the commit 00cc123703425aa362b0af75616134cbad4e0689 may change
> ide numbering for swarm or au1xxx (if those platform did not have ISA
> brigdes).  How about this?
> 
> 
> Subject: No ide_default_io_base() if PCI IDE was not found
> 
> Revert b5438582090406e2ccb4169d9b2df7c9939ae42b and add
> no_pci_devices() check to avoid crash due to early calling of
> pci_get_class().
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks for you guys discussing it out ;-)   Applied, thanks.

  Ralf
