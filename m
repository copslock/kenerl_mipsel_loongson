Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 21:39:08 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:27908 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133623AbWB1VjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 21:39:00 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id D62C464D3D; Tue, 28 Feb 2006 21:46:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 9349281F5; Tue, 28 Feb 2006 22:46:36 +0100 (CET)
Date:	Tue, 28 Feb 2006 21:46:36 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: BCM91x80A/B PCI DMA problems
Message-ID: <20060228214636.GA6711@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Has anyone here successfully used a PCI IDE card on BCM91x80?
I immediately get lots of PCI DMA problems, e.g:


SiI680: IDE controller at PCI slot 0000:00:01.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 8
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPB3043ATU E, ATA DISK drive
isa bounce pool size: 16 pages
ide0 at 0x9000000031080080-0x9000000031080087,0x900000003108008a on irq 8
hda: max request size: 64KiB
hda: 8448300 sectors (4325 MB), CHS=8940/15/63, UDMA(33)
 hda:<4>hda: dma_timer_expiry: dma status == 0x22
hda: DMA timeout error
hda: dma timeout error: status=0x01 { Error }
hda: dma timeout error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=0
ide: failed opcode was: unknown
end_request: I/O error, dev hda, sector 0

-- 
Martin Michlmayr
http://www.cyrius.com/
