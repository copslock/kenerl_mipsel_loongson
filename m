Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 00:06:24 +0100 (BST)
Received: from p508B65B8.dip.t-dialin.net ([IPv6:::ffff:80.139.101.184]:14276
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225245AbTD0XGW>; Mon, 28 Apr 2003 00:06:22 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3RN6CA13639;
	Mon, 28 Apr 2003 01:06:12 +0200
Date: Mon, 28 Apr 2003 01:06:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Subject: Re: ioctl32 enhancement
Message-ID: <20030428010612.C13382@linux-mips.org>
References: <20030425.212123.92588585.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030425.212123.92588585.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Fri, Apr 25, 2003 at 09:21:23PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 25, 2003 at 09:21:23PM +0900, Atsushi Nemoto wrote:

> I added some entries in arch/mips64/ioctl32.c.
> 
> The handler for TIOCGSERIAL is required by BusyBox.  Some serial
> drivers using generic serial_struct need it (sgiserial does not).  I
> think this patch does not harm sgiserial.
> 
> The loop ioctls (LOOP_GET_STATUS, LOOP_SET_STATUS) are required for
> some tools. (including Debian installer)
> 
> The mtd ioctls are useful on embedded systems.

Not only :-)

I've applied this patch to 2.4 only; 2.5 the whole emulation stuff is
being turned upside down anyway.

  Ralf
