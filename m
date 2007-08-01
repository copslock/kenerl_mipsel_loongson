Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2007 12:52:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32980 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021794AbXHALwc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Aug 2007 12:52:32 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l71BqWMf020439
	for <linux-mips@linux-mips.org>; Wed, 1 Aug 2007 12:52:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l71BqVBG020438
	for linux-mips@linux-mips.org; Wed, 1 Aug 2007 12:52:31 +0100
Date:	Wed, 1 Aug 2007 12:52:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Modpost warning on Alchemy
Message-ID: <20070801115231.GA20323@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Somebody with a clue on the Alchemy stuff may want to look into this
mostpost warning:

  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x1e32dc): Section mismatch: reference to .init.text:add_wired_entry (between 'config_access' and 'config_write')
  LD      vmlinux

All the PCI config space accessors on Alchemy will call
arch/mips/pci/ops-au1000.c:config_access which in turn calls add_wired_entry
add_wired_entry in turn is an __init function so it's only a matter of
luck if the PCI code doesn't explode on Alchemy.

So could somebody Alchemist try to rewrite this to use ioremap() instead?

Thanks,

  Ralf
