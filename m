Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 May 2003 02:09:56 +0100 (BST)
Received: from p508B5484.dip.t-dialin.net ([IPv6:::ffff:80.139.84.132]:35287
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225200AbTECBJy>; Sat, 3 May 2003 02:09:54 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h4319Ym24702;
	Sat, 3 May 2003 03:09:34 +0200
Date: Sat, 3 May 2003 03:09:34 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Keith Owens <kaos@sgi.com>
Cc: Michael Anburaj <michaelanburaj@hotmail.com>,
	linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board -problems :(
Message-ID: <20030503030934.B1756@linux-mips.org>
References: <BAY1-F28gEpTX5V3Gyk00001423@hotmail.com> <8921.1051849093@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8921.1051849093@kao2.melbourne.sgi.com>; from kaos@sgi.com on Fri, May 02, 2003 at 02:18:13PM +1000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 02, 2003 at 02:18:13PM +1000, Keith Owens wrote:

> You have to specify ARCH=mips on _all_ make commands, not just make
> *config.  Do 'make ARCH=mips' for the second one.

In the MIPS kernel source I've hardwired ARCH=mips.  He'd either have
to pass something like CROSS_COMPILE=mips-linux- or set the config
option CONFIG_CROSSCOMPILE.

  Ralf
