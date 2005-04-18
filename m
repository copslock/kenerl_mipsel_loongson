Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2005 12:54:58 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:51133 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225534AbVDRLyn>;
	Mon, 18 Apr 2005 12:54:43 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j3IBsg6t029142
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 13:54:42 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j3IBsg62029140;
	Mon, 18 Apr 2005 13:54:42 +0200
Date:	Mon, 18 Apr 2005 13:54:41 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [patch] some cleanups for Alchemy processors
Message-ID: <20050418115441.GA29116@lst.de>
References: <200504181137.49593.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504181137.49593.eckhardt@satorlaser.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2005 at 11:37:48AM +0200, Ulrich Eckhardt wrote:
>  * replace three evil macros used to alias fields of a structure 
>    with an anonymous union

In general we try to still support gcc 2.95 for compiling the kernel,
which doesn't support anonymous unions.
