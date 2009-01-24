Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 14:17:14 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:26289 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366074AbZAXORM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2009 14:17:12 +0000
Received: from mail.nwl.cc (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id D6A3F4E66C;
	Sat, 24 Jan 2009 15:17:05 +0100 (CET)
Received: from nuty (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 96C694CEAE;
	Sat, 24 Jan 2009 15:17:05 +0100 (CET)
Date:	Sat, 24 Jan 2009 15:20:27 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 2/2] input: add driver for S1 button of rb532
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>
References: <1232651528-19870-1-git-send-email-n0-1@freewrt.org> <1232651528-19870-2-git-send-email-n0-1@freewrt.org> <20090122191216.15285400E106@mail.nwl.cc> <Pine.LNX.4.64.0901240934040.13803@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0901240934040.13803@anakin>
User-Agent: Mutt/1.5.11
Message-Id: <20090124141705.96C694CEAE@mail.nwl.cc>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Sat, Jan 24, 2009 at 09:34:43AM +0100, Geert Uytterhoeven wrote:
> What happens when you receive UART input while the UART is disabled? Is it
> lost?

Yes, the input is lost, as well as any output sent by the device while
UART0 is disabled. I've tested this adding a msleep() of 5s in between
the calls to set_latch_u5() and increasing the delay between polls to
10s.

I've tried to reproduce this behaviour without the changes from above
using a loop flooding the output of the serial console with increasing
numbers, with somehow strange results. Instead of missing some output,
occasionally the log shows additional characters (some non-printable).
Also (seldomly) digits are replaced by other chars (also not necesarily
printable).

So I can at least assume the two drivers interfere with each other,
which could lead to bad results when using the UART for more advanced
stuff. Although it may be possible to introduce some kind of locking for
the serial output, I doubt this can be done with the input part, as the
device is turned off while polling so data shouldn't even reach the device.

Any ideas?

Greetings, Phil
