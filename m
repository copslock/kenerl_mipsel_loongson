Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Feb 2008 22:47:30 +0000 (GMT)
Received: from bsdimp.com ([199.45.160.85]:5338 "EHLO harmony.bsdimp.com")
	by ftp.linux-mips.org with ESMTP id S20029916AbYBJWrV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 Feb 2008 22:47:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by harmony.bsdimp.com (8.14.2/8.14.1) with ESMTP id m1AMeUSC053761;
	Sun, 10 Feb 2008 15:40:30 -0700 (MST)
	(envelope-from imp@bsdimp.com)
Date:	Sun, 10 Feb 2008 15:44:01 -0700 (MST)
Message-Id: <20080210.154401.1655407815.imp@bsdimp.com>
To:	macro@linux-mips.org
Cc:	florian.fainelli@telecomint.eu, linux-mips@linux-mips.org
Subject: Re: early_ioremap for MIPS
From:	"M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
References: <200802071932.23965.florian.fainelli@telecomint.eu>
	<Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
X-Mailer: Mew version 5.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <Pine.LNX.4.64N.0802081058350.7017@blysk.ds.pg.gda.pl>
            "Maciej W. Rozycki" <macro@linux-mips.org> writes:
: On Thu, 7 Feb 2008, Florian Fainelli wrote:
: 
: > Is there any need for early_ioremap on MIPS ? Seems like only x86_64 is 
: > implementing it for now.
: 
:  There is hardly any need as generally KSEG0/KSEG1 and XPHYS mappings 
: fulfil the need and are always available, even before paging has been 
: initialised.  Some 32-bit systems with devices outside low 512MB of 
: physical address space could potentially benefit though.  I recall some 
: Alchemy systems may fall into this category.

The Acer Pica machines, as well as the Deskstation Tynes, had devices
mapped outside of this range...  Of course Ralf will be able to say
more, if he chooses to jump into the way-back machine...

Warner
