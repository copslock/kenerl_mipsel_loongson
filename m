Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 02:33:30 +0100 (BST)
Received: from p508B6792.dip.t-dialin.net ([IPv6:::ffff:80.139.103.146]:32234
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbTDIBd3>; Wed, 9 Apr 2003 02:33:29 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h391XMM13270;
	Wed, 9 Apr 2003 03:33:22 +0200
Date: Wed, 9 Apr 2003 03:33:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Erik J. Green" <erik@greendragon.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 64 to 32 bit jr
Message-ID: <20030409033322.B12708@linux-mips.org>
References: <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl> <1049727719.3e9192e77cc49@my.visi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1049727719.3e9192e77cc49@my.visi.com>; from erik@greendragon.org on Mon, Apr 07, 2003 at 03:01:59PM +0000
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 07, 2003 at 03:01:59PM +0000, Erik J. Green wrote:

> I am unable to arrange my addresses similarly neatly, mostly I think due to
> fighting with the toolchain I have.  Is it "legal" for me to load a
> kernel using the xkphys address and then do something like:

You may map the kernel into XKSEG (0xc000000000000000).  The kernel
already has an option for that, CONFIG_MAPPED_KERNEL.  It's used as a
ccNUMA optimization on large Origin configurations to map a local copy
of the kernel code to that address range.

  Ralf
