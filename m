Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 18:51:17 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32962 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037562AbWHaRvP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 Aug 2006 18:51:15 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7VICrSV007470;
	Thu, 31 Aug 2006 19:12:54 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7VICrkX007469;
	Thu, 31 Aug 2006 19:12:53 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH] iso c90 fix for au1xxx-ide.c
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Daniel Mack <daniel@caiaq.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060831161444.GA10525@ipxXXXXX>
References: <20060831161444.GA10525@ipxXXXXX>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Thu, 31 Aug 2006 19:12:52 +0100
Message-Id: <1157047972.6271.304.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Iau, 2006-08-31 am 18:14 +0200, ysgrifennodd Daniel Mack:
> Hi,
> 
> this little patch makes gcc stop complaining about mixed 
> declarations and code when compiling drivers/ide/mips/au1xxx-ide.c.
> 
> It can also be found at 
> 
> 	http://caiaq.org/linux-mips/patches/au1xxx-ide_iso_c90.patch
> 
> Daniel
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

Acked-by: Alan Cox <alan@redhat.com>
