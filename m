Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Aug 2006 21:29:45 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58588 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S20037857AbWHLU3n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 12 Aug 2006 21:29:43 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.6/8.13.4) with ESMTP id k7CKo0Em011913;
	Sat, 12 Aug 2006 21:50:00 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k7CKo0Pq011912;
	Sat, 12 Aug 2006 21:50:00 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH] MIPS RM9K watchdog driver
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	thomas@koeller.dyndns.org
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200608121805.52358.thomas@koeller.dyndns.org>
References: <200608121805.52358.thomas@koeller.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 12 Aug 2006 21:49:59 +0100
Message-Id: <1155415799.24077.133.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Ar Sad, 2006-08-12 am 18:05 +0200, ysgrifennodd
thomas@koeller.dyndns.org:
> This is a driver for the on-chip watchdog device found on some
> MIPS RM9000 processors.
> 
> Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

Looks good now

Acked-by: Alan Cox <alan@redhat.com>
