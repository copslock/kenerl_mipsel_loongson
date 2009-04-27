Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 14:27:13 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:56025 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023330AbZD0N1F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Apr 2009 14:27:05 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n3RDR3IF016068
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Apr 2009 15:27:03 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id n3RDR3Bv016066;
	Mon, 27 Apr 2009 15:27:03 +0200
Date:	Mon, 27 Apr 2009 15:27:03 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
Message-ID: <20090427132703.GA16015@lst.de>
References: <E1LyQQX-00047N-6E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1LyQQX-00047N-6E@localhost>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Apr 27, 2009 at 06:59:17AM -0600, Shane McDonald wrote:
>  #ifdef CONFIG_SQUASHFS
> -#include <linux/squashfs_fs.h>
> +#include <linux/magic.h>
> +#include "../../../../fs/squashfs/squashfs_fs.h"
>  #endif

Sorry guys, this has zero business to be there.  Filesystem magic checks
of any sort don't belong into platform code.  Please kill that whole
get_ramroot piece of junk.
