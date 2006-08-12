Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 21:23:29 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58008 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037853AbWHLUX1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 21:23:27 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7CKhhmA011854;
	Sat, 12 Aug 2006 21:43:44 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7CKhh2Y011853;
	Sat, 12 Aug 2006 21:43:43 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200608121945.52202.thomas.koeller@baslerweb.com>
References: <200608102319.13679.thomas@koeller.dyndns.org>
	 <1155326835.24077.116.camel@localhost.localdomain>
	 <200608121945.52202.thomas.koeller@baslerweb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 12 Aug 2006 21:43:41 +0100
Message-Id: <1155415422.24077.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Sad, 2006-08-12 am 19:45 +0200, ysgrifennodd Thomas Koeller:
> On Friday 11 August 2006 22:07, Alan Cox wrote:
> > Also if this is a software watchdog why is it better than using
> > softdog ?
> >
> 
> This is _not_ a software watchdog. If the timer expires, an interrupt
> is generated, and the timer is reset to count through another cycle.
> If it expires again, it resets the CPU.

Ok thanks, then it does make sense for it to be in kernel.
