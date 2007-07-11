Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2007 11:36:44 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:60620 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20022997AbXGKKgm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2007 11:36:42 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6BAafNK015950
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Jul 2007 12:36:41 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l6BAae1g015948;
	Wed, 11 Jul 2007 12:36:40 +0200
Date:	Wed, 11 Jul 2007 12:36:40 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Domen Puncer <domen.puncer@telargo.com>
Cc:	linuxppc-dev@ozlabs.org, David Brownell <david-b@pacbell.net>,
	Sylvain Munaut <tnt@246tNt.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] powerpc clk.h interface for platforms
Message-ID: <20070711103640.GB15536@lst.de>
References: <20070711093113.GE4375@moe.telargo.com> <20070711093220.GF4375@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070711093220.GF4375@moe.telargo.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Jul 11, 2007 at 11:32:20AM +0200, Domen Puncer wrote:
> clk interface for arch/powerpc, platforms should fill
> clk_functions.

Umm, this is about the fifth almost identical implementation of
the clk_ functions.  Please, please put it into common code.

And talk to the mips folks which just got a similar comment from me.
