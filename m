Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 06:50:02 +0000 (GMT)
Received: from out001.atlarge.net ([129.41.63.69]:48138 "EHLO
	out001.atlarge.net") by ftp.linux-mips.org with ESMTP
	id S20037863AbXBFGtz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 06:49:55 +0000
Received: from hpmailfe-01.atlarge.net ([10.100.60.156]) by out001.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Feb 2007 00:47:28 -0600
Received: from localhost ([213.250.36.225]) by hpmailfe-01.atlarge.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Feb 2007 00:47:27 -0600
Date:	Tue, 6 Feb 2007 07:49:17 +0100
From:	Domen Puncer <domen.puncer@telargo.com>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Embedding rootfs with kernel
Message-ID: <20070206064917.GJ4397@moe.telargo.com>
References: <45C7967E.1090505@pmc-sierra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45C7967E.1090505@pmc-sierra.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 06 Feb 2007 06:47:27.0797 (UTC) FILETIME=[AA94C650:01C749BA]
Return-Path: <domen.puncer@telargo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@telargo.com
Precedence: bulk
X-list: linux-mips

On 05/02/07 12:41 -0800, Marc St-Jean wrote:
> What is the MIPS-way of embedding the rootfs with the kernel?

For 2.6.x (on all? architectures) initramfs.


	Domen
