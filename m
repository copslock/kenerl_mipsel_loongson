Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Dec 2002 20:33:56 +0000 (GMT)
Received: from p508B4FAF.dip.t-dialin.net ([IPv6:::ffff:80.139.79.175]:38292
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225612AbSLWUdz>; Mon, 23 Dec 2002 20:33:55 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBNKXru01864;
	Mon, 23 Dec 2002 21:33:53 +0100
Date: Mon, 23 Dec 2002 21:33:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Julian Scheel <jscheel@activevb.de>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: Problems compiling MIPS64 kernel
Message-ID: <20021223213353.A753@linux-mips.org>
References: <200212231313.54593.jscheel@activevb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212231313.54593.jscheel@activevb.de>; from jscheel@activevb.de on Mon, Dec 23, 2002 at 01:13:54PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 23, 2002 at 01:13:54PM +0100, Julian Scheel wrote:

> after I got the mips-patched 2.4.20 kernel-sources now, I made a new try to 
> compile my mips64-kernel.
> As compiler I am using the SDE-GCC (www.algor.co.uk). make menuconfig works 
> well, but when I do "make vmlinux" I get following errors:

> especially the line "#error Use a Linux compiler or give up" surprised me?!
> Can someone help me a bit?

The SDE compiler sources can be configured to support Linux at compile
time but as it seems your compiler was configured for a different target.

  Ralf
