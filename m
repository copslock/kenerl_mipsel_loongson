Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2007 16:05:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64225 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20028960AbXH1PFc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Aug 2007 16:05:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7SF5VVW017289;
	Tue, 28 Aug 2007 16:05:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7SF5V8V017282;
	Tue, 28 Aug 2007 16:05:31 +0100
Date:	Tue, 28 Aug 2007 16:05:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] PCI: Remove __devinit attribute from pcibios_fixup_bus.
Message-ID: <20070828150531.GG11607@linux-mips.org>
References: <S20023984AbXHXBUC/20070824012002Z+18840@ftp.linux-mips.org> <20070825.002328.108738360.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070825.002328.108738360.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 25, 2007 at 12:23:28AM +0900, Atsushi Nemoto wrote:

> On Fri, 24 Aug 2007 02:19:57 +0100, linux-mips@linux-mips.org wrote:
> > Author: Ralf Baechle <ralf@linux-mips.org> Thu Aug 23 14:12:56 2007 +0100
> > Commit: dda571e0032731ed05b65e365283c54522483b08
> > Gitweb: http://www.linux-mips.org/g/linux/dda571e0
> > Branch: master
> > 
> > Since 96bde06a2df1b363206d3cdef53134b84ff37813 pcibios_fixup_bus's caller
> > pci_scan_child_bus is no longer marked __devinit resulting in this modpost
> > warning if PCI && !HOTPLUG:
> 
> And pci_read_bridge_bases() called by pcibios_fixup_bus is still
> marked __devinit.
> 
> Should we drop __devinit from pci_read_bridge_bases() too?

I already sent such a patch to gregkh on 23/8, so it'll just take a little
bit until this patch has propagated to Linus.

  Ralf
