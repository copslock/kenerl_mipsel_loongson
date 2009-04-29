Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2009 13:10:23 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:39964 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023672AbZD2MKQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Apr 2009 13:10:16 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n3TCAFIF014438
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Apr 2009 14:10:15 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id n3TCAF4R014436;
	Wed, 29 Apr 2009 14:10:15 +0200
Date:	Wed, 29 Apr 2009 14:10:14 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [MIPS] Remove the RAMROOT function for msp71xx
Message-ID: <20090429121014.GA14199@lst.de>
References: <E1LywHr-0006MX-S3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LywHr-0006MX-S3@localhost>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 05:00:27PM -0600, Shane McDonald wrote:
> The RAMROOT function was a successful but non-portable attempt to append
> the root filesystem to the end of the kernel image.  The preferred and
> portable solution is to use an initramfs instead.  This patch removes
> the RAMROOT functionality.
> 
> This patch has been compile-tested against the current HEAD.
> 
> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> ---
>  arch/mips/pmc-sierra/Kconfig            |   12 ------
>  arch/mips/pmc-sierra/msp71xx/msp_prom.c |   60 +------------------------------

Looks good to me, but now a build of drivers/mtd/maps/pmcmsp-ramroot.c
will fail.  Given that it's useless now you should probably remove it,
too.
