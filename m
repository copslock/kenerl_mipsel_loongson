Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jan 2005 10:59:41 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:53717 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225716AbVA3K70>;
	Sun, 30 Jan 2005 10:59:26 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j0UAxP6t001508
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 30 Jan 2005 11:59:25 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j0UAxPQi001506;
	Sun, 30 Jan 2005 11:59:25 +0100
Date:	Sun, 30 Jan 2005 11:59:25 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: changes to drivers/scsi/sym53c8xx_defs.h in the mips tree
Message-ID: <20050130105925.GA1490@lst.de>
References: <20050129163746.GA21213@lst.de> <Pine.LNX.4.61L.0501292325490.29728@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0501292325490.29728@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Sun, Jan 30, 2005 at 01:18:52AM +0000, Maciej W. Rozycki wrote:
>  BTW, that SCSI_NCR_BIG_ENDIAN macro looks scary -- is the chip wired 
> incorrectly (i.e. with byte lanes swapped at PCI) or are i/o and/or mmio 
> operations simply broken for parisc?

Many parisc systems have a NCR720 on the HP GSC bus, which actually
is accessed as big endian.
