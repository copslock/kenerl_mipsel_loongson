Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 19:36:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51108 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040552AbXJQSgy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 19:36:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9HIaspB000828;
	Wed, 17 Oct 2007 19:36:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9HIasRM000827;
	Wed, 17 Oct 2007 19:36:54 +0100
Date:	Wed, 17 Oct 2007 19:36:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: IP22 64bit kernel
Message-ID: <20071017183654.GA687@linux-mips.org>
References: <20070911213048.GA20579@alpha.franken.de> <46E8E134.8000004@gentoo.org> <20070913155059.GA8790@linux-mips.org> <20070913182348.GA11473@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913182348.GA11473@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 08:23:48PM +0200, Thomas Bogendoerfer wrote:

> On Thu, Sep 13, 2007 at 04:50:59PM +0100, Ralf Baechle wrote:
> > The problem isn't limited to ARC firmware; basically any non-R8000 64-bit
> > system can be affected.  A kernel may be using either addresses in XKPHYS
> > or in CKSEG0 and the segment for which the kernel is linked is not
> > necessarily the same that the firmware will load it to.
> 
> here is a patch:
> 
> Always jump to the place where the kernel is linked to. This helps
> where the bootloaders/proms ignores the start address inside the ELF
> header.

Applied.

  Ralf
