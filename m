Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2007 14:25:59 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:15836 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20023882AbXHCNZ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2007 14:25:57 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l73DPoA5022044
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Aug 2007 15:25:51 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l73DPo2b022041;
	Fri, 3 Aug 2007 15:25:50 +0200
Date:	Fri, 3 Aug 2007 15:25:50 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 4/5] Use -Werror on TX39/TX49 boards
Message-ID: <20070803132550.GA21454@lst.de>
References: <20070802.233617.70476666.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070802.233617.70476666.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 11:36:17PM +0900, Atsushi Nemoto wrote:
> Now these directories can be built cleanly.

Please don't.  Adding -Werror is a complete pain in the ass for people
using new compilers or when we get things like __deprecated or
__warn_unused warnings from headers.  We've dropped it again from
the various placed that had introduced this.
