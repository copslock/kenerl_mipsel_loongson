Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 11:21:54 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:11950 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8224991AbVHAKVi>;
	Mon, 1 Aug 2005 11:21:38 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j71AOg6t010517
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 1 Aug 2005 12:24:43 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j71AOgcU010515;
	Mon, 1 Aug 2005 12:24:42 +0200
Date:	Mon, 1 Aug 2005 12:24:42 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [patch 05/15] Basic MIPS support
Message-ID: <20050801102442.GA10361@lst.de>
References: <resend.4.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.5.2972005.trini@kernel.crashing.org> <20050801101933.GC4205@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801101933.GC4205@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Aug 01, 2005 at 11:19:33AM +0100, Ralf Baechle wrote:
> Forwarding this as a heads up.  Who cares about kgdb may want to start
> working on the necessary bits as the patchset from below will be in 2.6.13.

I doubt it'll be in 2.6.13..
