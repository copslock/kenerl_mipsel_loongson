Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2009 00:38:22 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:21141 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21366284AbZAVAiT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2009 00:38:19 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id 1D458400E106;
	Thu, 22 Jan 2009 01:38:14 +0100 (CET)
Date:	Thu, 22 Jan 2009 01:41:34 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rb532: remove unused rb532_gpio_set_func()
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net> <20081128194353.DC55A386DBBE@mail.ifyouseekate.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081128194353.DC55A386DBBE@mail.ifyouseekate.net>
User-Agent: Mutt/1.5.11
Message-Id: <20090122003814.1D458400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, Nov 28, 2008 at 08:46:29PM +0100, Phil Sutter wrote:
> Since disabling of the alternate function of a GPIO pin is being done
> implicitly when changing it's direction, the above mentioned function is
> not being called anymore and can be removed.

Please do not apply this patch. In fact, the function in question should
be exported as kernel symbol, as else there is no possibility for
drivers to turn on alternate function for a GPIO pin. This is of
particular use when trying to read the S1 button state, as the
corresponding GPIO pin is multiplexed with UART0 input.

Greetings, Phil
