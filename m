Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 17:03:44 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:3811 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20032498AbYAHRDf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jan 2008 17:03:35 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JCHrR-000468-00; Tue, 08 Jan 2008 18:03:33 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 62A5AC2F21; Tue,  8 Jan 2008 18:02:06 +0100 (CET)
Date:	Tue, 8 Jan 2008 18:02:06 +0100
To:	lovecentry <lovecentry@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kseg1 uncache access issue
Message-ID: <20080108170206.GA8777@alpha.franken.de>
References: <4783a652.1cef600a.2530.fffffe31@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4783a652.1cef600a.2530.fffffe31@mx.google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Jan 09, 2008 at 12:35:06AM +0800, lovecentry wrote:
> As we know in mips achitecture if current pc falls into kseg1 segment, any
> memory reference will bypass cache and fetch directly from dram. But for
> some prcoessor such like mips R10K it has off chip L2 cache. I haven't found

why do you think so ? R10k L2 cache controller is inside CPU and any
access with uncached attribute will go directly to memory. The only
systems, where this might be different are systems with caches unknown
to the cpu. But even those usually obey that uncached accesses are
going directly to memory.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
