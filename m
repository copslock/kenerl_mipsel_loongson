Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Mar 2008 12:00:36 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20923 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S28592139AbYCOMAe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Mar 2008 12:00:34 +0000
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.14.2/8.13.8) with ESMTP id m2FBcquB003267;
	Sat, 15 Mar 2008 11:38:52 GMT
Date:	Sat, 15 Mar 2008 11:38:51 +0000
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/6]: AR7: serial hack
Message-ID: <20080315113851.6f86acff@the-village.bc.nu>
In-Reply-To: <200803141646.09645.technoboy85@gmail.com>
References: <200803120221.25044.technoboy85@gmail.com>
	<200803130138.55582.technoboy85@gmail.com>
	<20080313084526.GA6012@alpha.franken.de>
	<200803141646.09645.technoboy85@gmail.com>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.5; i386-redhat-linux-gnu)
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
X-archive-position: 18399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

> This is a bit better

NAK - especially as there has been a specific response about how to do
this without ifdef hacks in core code.

Alan
