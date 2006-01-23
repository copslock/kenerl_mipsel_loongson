Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:01:56 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13452 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S3458585AbWAWPBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 15:01:37 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k0NF67ob001968;
	Mon, 23 Jan 2006 15:06:07 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k0NF668v001967;
	Mon, 23 Jan 2006 15:06:06 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Cobalt IDE fix
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Stuart Longland <redhatter@gentoo.org>
Cc:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <43D42D23.8010908@gentoo.org>
References: <20060122235038.GA3501@colonel-panic.org>
	 <1137976937.24808.2.camel@localhost.localdomain>
	 <43D42D23.8010908@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 23 Jan 2006 15:06:05 +0000
Message-Id: <1138028765.24808.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Llu, 2006-01-23 at 11:10 +1000, Stuart Longland wrote:
> Actually... could a configure option in Kconfig be added to disable
> probing particular IDE busses?

ide0=noprobe

> > VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
> >     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
> > Probing IDE interface ide0...
> > hda: IRQ probe failed (0xfff0f5fc)

This is probing beause the IDE enable bits have not been set correctly
by the BIOS I think. Not much we can do if the BIOS says "yes there is a
drive" and there is not.
