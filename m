Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 09:04:16 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:41443 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20024270AbXIUIEH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 09:04:07 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l8L83oA5005132
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Sep 2007 10:03:51 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l8L83jIP005127;
	Fri, 21 Sep 2007 10:03:45 +0200
Date:	Fri, 21 Sep 2007 10:03:45 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	J??rn Engel <joern@logfs.org>, Christoph Hellwig <hch@lst.de>,
	linux-mips@linux-mips.org, Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>, dwmw2@infradead.org
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Message-ID: <20070921080345.GA4997@lst.de>
References: <200709201728.10866.technoboy85@gmail.com> <20070920193547.GA911@lst.de> <20070920200058.GB1692@lazybastard.org> <200709210409.23521.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709210409.23521.technoboy85@gmail.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Fri, Sep 21, 2007 at 04:09:22AM +0200, Matteo Croce wrote:
> I use little endian since 99% of AR7s are little endian. Dunno if
> le/be32_to_cpu does some runtime calculations. Do they?

They do runtime unless the argument is const.  If you say that you cant
change endianess of a given system during it's lifetime it's probably
fine to ignore the endianess issue and always use host endian without
any conversions.  In that case you'll need to remove the ifdef aswell,
though.
