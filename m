Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 10:55:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:20195 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20034501AbXJOJzi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 10:55:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9F9taYn028989;
	Mon, 15 Oct 2007 10:55:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9F9ta7s028983;
	Mon, 15 Oct 2007 10:55:36 +0100
Date:	Mon, 15 Oct 2007 10:55:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: -git mips defconfig compile error
Message-ID: <20071015095535.GB9896@linux-mips.org>
References: <20071014131948.GF4211@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071014131948.GF4211@stusta.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 14, 2007 at 03:19:48PM +0200, Adrian Bunk wrote:

> Commit 05dc8c02bf40090e9ed23932b1980ead48eb8870 causes the following 
> compile error with the mips defconfig:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/video/logo/logo.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c: In function 'fb_find_logo':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: 'mips_machgroup' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: (Each undeclared identifier is reported only once
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: for each function it appears in.)
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/video/logo/logo.c:91: error: 'MACH_GROUP_SGI' undeclared (first use in this function)
> make[4]: *** [drivers/video/logo/logo.o] Error 1
> 
> <--  snip  -->
> 
> It seems the drivers/net/jazzsonic.c and drivers/video/logo/logo.c parts 
> that are part of the corresponding commit in the mips git tree got lost
> somewhere.

The logo.c bit I've sent out a few weeks ago so I'm just waiting for that
patch to resurface at the other end of the wormhole.

The jazzsonic breakage was caused by the not very well done "[NET]:
Introduce and use print_mac() and DECLARE_MAC_BUF()" patch aka
0795af5729b18218767fab27c44b1384f72dc9ad.

(No need to mail me about build failures of default configurations; there
is an autobuilder building them regularly ...)

  Ralf
