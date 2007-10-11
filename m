Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 16:26:31 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:11222 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20021969AbXJKP0W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 16:26:22 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id C349A48C39;
	Thu, 11 Oct 2007 17:25:55 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IfzvT-0001wy-D0; Thu, 11 Oct 2007 16:26:15 +0100
Date:	Thu, 11 Oct 2007 16:26:15 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] Add __initbss section
Message-ID: <20071011152615.GE3379@networkno.de>
References: <470DF25E.60009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470DF25E.60009@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
[snip]
> Also not that with the current patchset applied, there are now 2
> segments that need to be loaded, hopefully it won't cause any issues
> with any bootloaders out there that would assume that an image has
> only one segment...

This breaks at least conversion to ECOFF as used on DECstations.
Srec might also be affected, I'm not sure about that.


Thiemo
