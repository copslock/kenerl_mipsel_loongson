Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 08:34:58 +0000 (GMT)
Received: from monty.telenet-ops.be ([195.130.132.56]:53383 "EHLO
	monty.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S21366151AbZAXIex (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jan 2009 08:34:53 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by monty.telenet-ops.be (Postfix) with SMTP id 5FB2C54007;
	Sat, 24 Jan 2009 09:34:52 +0100 (CET)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by monty.telenet-ops.be (Postfix) with ESMTP id 40DD65403D;
	Sat, 24 Jan 2009 09:34:46 +0100 (CET)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id n0O8Yj3l002485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 24 Jan 2009 09:34:45 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id n0O8YiMS002373;
	Sat, 24 Jan 2009 09:34:44 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sat, 24 Jan 2009 09:34:43 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Phil Sutter <n0-1@freewrt.org>
cc:	Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 2/2] input: add driver for S1 button of rb532
In-Reply-To: <20090122191216.15285400E106@mail.nwl.cc>
Message-ID: <Pine.LNX.4.64.0901240934040.13803@anakin>
References: <1232651528-19870-1-git-send-email-n0-1@freewrt.org>
 <1232651528-19870-2-git-send-email-n0-1@freewrt.org> <20090122191216.15285400E106@mail.nwl.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 22 Jan 2009, Phil Sutter wrote:
> Mikrotik's Routerboard 532 has two builtin buttons, from which one
> triggers a hardware reset. The other one is accessible through GPIO pin
> 1. Sadly, this pin is being multiplexed with UART0 input, so enabling it
> as interrupt source (as implied by the gpio-keys driver) is not possible
> unless UART0 has been turned off. The later one though is a rather bad
> idea as the Routerboard is an embedded device with only a single serial
> port, so it's almost always used as serial console device.
> 
> This patch adds a driver based on INPUT_POLLDEV, which disables the UART
> and reconfigures GPIO pin 1 temporarily while reading the button state.
> This procedure works fine and has been tested as part of another,
> unpublished driver for this device.

What happens when you receive UART input while the UART is disabled? Is it
lost?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
