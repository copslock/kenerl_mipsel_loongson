Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 06:24:55 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:1811 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20040613AbXAXGYv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 06:24:51 +0000
Received: (qmail 6524 invoked by uid 1000); 24 Jan 2007 07:24:50 +0100
Date:	Wed, 24 Jan 2007 07:24:50 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Pierre Ossman <drzeus-mmc@drzeus.cx>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: au1xmmc R6 response support
Message-ID: <20070124062450.GA6519@roarinelk.homelinux.net>
References: <20070123100814.GA5001@roarinelk.homelinux.net> <45B65A73.90308@drzeus.cx> <20070124055202.GA6446@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070124055202.GA6446@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Wed, Jan 24, 2007 at 06:52:02AM +0100, Manuel Lauss wrote:
> On Tue, Jan 23, 2007 at 07:56:51PM +0100, Pierre Ossman wrote:
> > > here's a trivial patch which adds R6 reponse support to the au1xmmc
> > > driver. Fixes SD card detection / operation.
> > > 
> > NAK. MMC_RSP_R1 and MMC_RSP_R6 have the same value so this will break
> > the switch.
> 
> not in my version of 2.6.20-rc5 (and 2.6.19):
> 
> #define MMC_RSP_R1	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
> #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
> 
> Without the patch, SD card detection stops with CMD7 returning error.

Correction: it fails at SD_SEND_RELATIVE_ADDR (it's the only command
which request R6 response)

-- 
 ml.
