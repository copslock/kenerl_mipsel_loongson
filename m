Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 22:27:50 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40585 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20021775AbXEWV1t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 22:27:49 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l4NLU92F020566;
	Wed, 23 May 2007 22:30:09 +0100
Date:	Wed, 23 May 2007 22:30:08 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Roman Zippel <zippel@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	akpm@osdl.org, rmk@arm.linux.kernel.org, spyro@f2s.com,
	starvik@axis.com, ysato@users.sourceforge.jp,
	"Luck, Tony" <tony.luck@intel.com>, takata@linux-m32r.org,
	chris@zankel.net, uclinux-v850@lsi.nec.co.jp,
	kyle@parisc-linux.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] m68k: Enable arbitary speed tty support
Message-ID: <20070523223008.32f65e0a@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.64.0705232233360.10610@anakin>
References: <20070523174446.37abfa7a@the-village.bc.nu>
	<Pine.LNX.4.64.0705232117260.10610@anakin>
	<20070523205645.07b03581@the-village.bc.nu>
	<Pine.LNX.4.64.0705232233360.10610@anakin>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> Why not `#define termios2 ktermios' (or vice versa) on platforms where
> they are the same?

Because #define is a bit of a loose cannon when it comes to substitutions
and I didn't want nasty suprises. Also because ktermios may change in
future and I don't want to have to liase with 4 million port maintainers
when it does. The whole point of ktermios was to isolate the kernel and
user space views.

Alan
