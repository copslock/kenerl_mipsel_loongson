Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 03:25:49 +0100 (BST)
Received: from lazybastard.de ([212.112.238.170]:9631 "EHLO
	longford.lazybastard.org") by ftp.linux-mips.org with ESMTP
	id S20023948AbXIUCZR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 03:25:17 +0100
Received: from joern by longford.lazybastard.org with local (Exim 4.50)
	id 1IYY8c-00010f-TY; Fri, 21 Sep 2007 04:21:03 +0200
Date:	Fri, 21 Sep 2007 04:20:59 +0200
From:	=?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	=?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>,
	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>, dwmw2@infradead.org
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Message-ID: <20070921022059.GG1692@lazybastard.org>
References: <200709201728.10866.technoboy85@gmail.com> <20070920193547.GA911@lst.de> <20070920200058.GB1692@lazybastard.org> <200709210409.23521.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200709210409.23521.technoboy85@gmail.com>
User-Agent: Mutt/1.5.9i
Return-Path: <joern@lazybastard.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joern@logfs.org
Precedence: bulk
X-list: linux-mips

On Fri, 21 September 2007 04:09:22 +0200, Matteo Croce wrote:
> 
> I use little endian since 99% of AR7s are little endian. Dunno if
> le/be32_to_cpu does some runtime calculations. Do they?

Only if they have to convert endianness.  And even in that case I doubt
that you will notice it in any benchmarks.

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams
