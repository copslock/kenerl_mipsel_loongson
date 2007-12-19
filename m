Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Dec 2007 00:38:30 +0000 (GMT)
Received: from srv5.dvmed.net ([207.36.208.214]:55949 "EHLO mail.dvmed.net")
	by ftp.linux-mips.org with ESMTP id S28575968AbXLSAiW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Dec 2007 00:38:22 +0000
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1J4mwz-0007uV-S3; Wed, 19 Dec 2007 00:38:18 +0000
Message-ID: <476867F5.3070006@pobox.com>
Date:	Tue, 18 Dec 2007 19:38:13 -0500
From:	Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [UPDATED PATCH] SGISEEQ: use cached memory access to make driver
 work on IP28
References: <20071202103312.75E51C2EB5@solo.franken.de> <47671FEE.90103@pobox.com> <20071218103006.GA18598@alpha.franken.de>
In-Reply-To: <20071218103006.GA18598@alpha.franken.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jgarzik@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgarzik@pobox.com
Precedence: bulk
X-list: linux-mips

Thomas Bogendoerfer wrote:
> On Mon, Dec 17, 2007 at 08:18:38PM -0500, Jeff Garzik wrote:
>>> Changes to last version:
>>> - Use inline functions for dma_sync_* instead of macros (suggested by Ralf)
>>> - added Kconfig change to make selection for similair SGI boxes easier
>> hrm, could you rediff?  it doesn't seem to apply
> 
> sure, against which tree ? I tried netdev-2.6 and it applies without fuzz...

It needs to be the 'upstream' branch of netdev-2.6.

The default netdev-2.6.git branch, master, is a 100% vanilla duplicate 
of Linus's git repository.

(this permits a common practice of presenting logs and diffs using git's 
branch..branch notation)

	Jeff
