Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jan 2005 16:38:04 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:24510 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225274AbVA2Qht>;
	Sat, 29 Jan 2005 16:37:49 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j0TGbl6t021247
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Jan 2005 17:37:47 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j0TGbkjX021245;
	Sat, 29 Jan 2005 17:37:46 +0100
Date:	Sat, 29 Jan 2005 17:37:46 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	carstenl@mips.com
Cc:	linux-mips@linux-mips.org
Subject: changes to drivers/scsi/sym53c8xx_defs.h in the mips tree
Message-ID: <20050129163746.GA21213@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

Hi Carsten,

do you remember what your changes to drivers/scsi/sym53c8xx_defs.h in
the mips tree are supposed to help with?

sym53c8xx_defs.h is only used for the ncr53c8xx driver, which despite
the name is only for NCR53c720 chips these days (supported on parisc,
and eisa/mca).  It has correct big endian support for parisc alrady.

Also the patch duplicates your changelog and copyright entry that's
in the file already.
