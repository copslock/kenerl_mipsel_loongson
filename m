Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 11:19:25 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32909 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492309AbZF0JTR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 11:19:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5R9Eh9i015035;
	Sat, 27 Jun 2009 10:14:44 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5R9EhaR015033;
	Sat, 27 Jun 2009 10:14:43 +0100
Date:	Sat, 27 Jun 2009 10:14:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Kaz Kylheku <KKylheku@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
Message-ID: <20090627091443.GC3235@linux-mips.org>
References: <20090624063453.GA16846@volta.aurel32.net> <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local> <20090626232432.GB3235@linux-mips.org> <20090627051026.GB18476@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090627051026.GB18476@hall.aurel32.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 27, 2009 at 07:10:26AM +0200, Aurelien Jarno wrote:

> Yes, booting on the IDE controller.

Chances are it's a bug in the PIO IDE driver or it's interaction with
update_mmu_cache().  If I'm right you should not see the issue if you
boot of another block device with DMA like a PCI PATA/SATA card.

Which generally is a sane thing to do - the onboard controller is a
quick hack to demonstrate the capabilities of the BCM1250's GPIO features;
in practical terms it totally sucks but I SATA card solves that.  If
you do that, get a 64-bit card.  32-bit DMA PCI cards have other issues
in Sibyte systems.

  Ralf
