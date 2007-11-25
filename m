Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 14:40:28 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:8455 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S20033936AbXKYOkU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2007 14:40:20 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 883BCD8E3; Sun, 25 Nov 2007 14:39:43 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CF64A544F2; Sun, 25 Nov 2007 15:39:31 +0100 (CET)
Date:	Sun, 25 Nov 2007 15:39:31 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	manoj.ekbote@broadcom.com, mark.e.mason@broadcom.com
Subject: Re: BigSur: io_map_base not set for PCI bus 0000:00
Message-ID: <20071125143931.GR20922@deprecation.cyrius.com>
References: <20071125142603.GQ20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071125142603.GQ20922@deprecation.cyrius.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2007-11-25 15:26]:
> io_map_base of root PCI bus 0000:00 unset.  Trying to continue but you better
> fix this issue or report it to linux-mips@linux-mips.org or your vendor.
> Kernel panic - not syncing: To avoid data corruption io_map_base MUST be set with multiple PCI domains.
> 
> CFE says:
> PCI[0] bus 0 slot 1/0: unknown vendor 0x1106 product 0x3249 (RAID mass storage, rev 0x50)

With a different card, I get:

PCI[0] bus 0 slot 1/0: unknown vendor 0x1095 product 0x0680 (RAID mass storage, rev 0x02)
...
nbd: registered device at major 43
sil680: 133MHz clock.
scsi0 : pata_sil680
scsi1 : pata_sil680
ata1: PATA max UDMA/133 irq 8
ata2: PATA max UDMA/133 irq 8
ata1.00: ATA-6: SAMSUNG SV1021H, PJ100-13, max UDMA/33
ata1.00: 19932192 sectors, multi 0: LBA
ata1.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SV1021H  PJ10 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 19932192 512-byte hardware sectors (10205 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 19932192 512-byte hardware sectors (10205 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: unknown partition table

... but then it hangs here.

The first card (that failed) is a SATA/PATA PCI card, this one is an old IDE
PCI card.  I think they conform to different PCI specs.  Another difference
is that CFE knows that my old IDE card is a PCIIDE card ("PCIIDE: 1
controllers found") whereas it doesn't find a PCIIDE controller for the newer
card (I think CFE hard codes PCI devices so this is hardly surprising).
Maybe the problem is that CFE didn't properly initialize the card?
-- 
Martin Michlmayr
http://www.cyrius.com/
