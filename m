Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 18:08:16 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:38832 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24145211AbYLESIH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2008 18:08:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mB5I86ef019657;
	Fri, 5 Dec 2008 18:08:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mB5I86th019655;
	Fri, 5 Dec 2008 18:08:06 GMT
Date:	Fri, 5 Dec 2008 18:08:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: xorg-server-1.5.2 doesn't work because of missing sysfs pci
	resource files
Message-ID: <20081205180806.GA19217@linux-mips.org>
References: <20081205154339.GA14327@adriano.hkcable.com.hk> <m3ljuumrjs.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ljuumrjs.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 05, 2008 at 06:59:35PM +0100, Arnaud Patard wrote:

Arnaud,

> > Then I tried to read kernel code. I found it seems that for mips linux to have
> > this file, HAVE_PCI_MMAP must be defined. However, it is currently not defined.
> >
> > Since I am not familiar with PCI, yet.
> > So could someone please shed some light on this?
> > Why HAVE_PCI_MMAP is not defined?
> 
> HAVE_PCI_MMAP must be defined when you have a pci_mmap_page_range()
> function (see Documentation/filesystems/sysfs-pci.txt) and we don't have
> a pci_mmap_page_range() on mips.

Correct - but if the code is not present the kernel does not use an
alternative implementation.  I just looked into implementing that and it
seems nothing that I could do quickly to still get it into 2.6.28, sorry ...

  Ralf
