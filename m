Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:54:18 +0100 (MET)
Received: from cc260354-a.hnglo1.ov.home.nl ([IPv6:::ffff:213.51.105.170]:22767
	"EHLO duron.addesk.org") by ralf.linux-mips.org with ESMTP
	id <S868894AbSKZSLY>; Tue, 26 Nov 2002 19:11:24 +0100
Received: from duron.addesk.org (localhost.localdomain [127.0.0.1])
	by duron.addesk.org (8.12.5/8.12.5) with ESMTP id gAQIGBQZ001703;
	Tue, 26 Nov 2002 19:16:11 +0100
Received: (from turrican@localhost)
	by duron.addesk.org (8.12.5/8.12.5/Submit) id gAQIGB5p001700;
	Tue, 26 Nov 2002 19:16:11 +0100
X-Authentication-Warning: duron.addesk.org: turrican set sender to jongk@linux-m68k.org using -f
Subject: Re: cli/sti removal from wd33c93.c
From: Kars de Jong <jongk@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-m68k@lists.linux-m68k.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <20021125123750.A11523@linux-mips.org>
References: <20021125123750.A11523@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 19:16:10 +0100
Message-Id: <1038334570.1669.5.camel@duron.addesk.org>
Mime-Version: 1.0
Return-Path: <jongk@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jongk@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 2002-11-25 at 12:37, Ralf Baechle wrote:
> Below are patches to replace cli/sti and accomplices from the WD33c93
> driver.  Who is currently the maintainer of this driver?  Ok to send to
> Linus?

I kinda picked up where John Shifflett left it, to try and get it
working more reliably on the old MVME147 SBC I have access to at work.
Never tried it with anything beyond 2.4.19 though. Is the current 2.5
usable on m68k, anyone?
 
> 2.5 doesn't boot on MIPS yet so this patch is untested.  This patch gets
> it to build; it was written by Marc Zygnier and reviewed by me and we
> think it does the right thing.

The patch looks OK to me as well.


Kind regards,

Kars.
