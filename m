Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 14:46:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22691 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039032AbXKZOqa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 14:46:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAQEjiGX021476;
	Mon, 26 Nov 2007 14:45:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAQEjhEa021475;
	Mon, 26 Nov 2007 14:45:43 GMT
Date:	Mon, 26 Nov 2007 14:45:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, manoj.ekbote@broadcom.com,
	mark.e.mason@broadcom.com
Subject: Re: BigSur: oops loading ramdisk
Message-ID: <20071126144543.GA19679@linux-mips.org>
References: <20071125125229.GJ20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071125125229.GJ20922@deprecation.cyrius.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 25, 2007 at 01:52:29PM +0100, Martin Michlmayr wrote:

> With a 32 bit kernel (current git) on BigSur, I get an oops while
> trying to load the ramdisk:
> 
> Linux version 2.6.24-rc3-g2ffbb837-dirty (tbm@em64t) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #4 Sun Nov 25 12:44:26 UTC 2007

I've just modified the memory initialization code significantly to add
support for ZONE_DMA32 for the Sibyte boxes, so could you retest?

Thanks,

  Ralf
