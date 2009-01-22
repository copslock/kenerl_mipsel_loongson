Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2009 19:13:04 +0000 (GMT)
Received: from orbit.nwl.cc ([91.121.169.95]:20943 "EHLO mail.nwl.cc")
	by ftp.linux-mips.org with ESMTP id S21103573AbZAVTMg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2009 19:12:36 +0000
Received: from base (localhost [127.0.0.1])
	by mail.nwl.cc (Postfix) with ESMTP id F05AF400E106;
	Thu, 22 Jan 2009 20:12:30 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Dmitry Torokhov <dtor@mail.ru>
Cc:	linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: Driver for the S1 button of rb532
Date:	Thu, 22 Jan 2009 20:12:06 +0100
X-Mailer: git-send-email 1.5.6.4
Message-Id: <20090122191230.F05AF400E106@mail.nwl.cc>
Return-Path: <n0-1@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips


Hi,

I've written a polled input device driver for the S1 button built into
the Routerboard 532. Sadly, the gpio-keys driver can't be used, as it
turns on the GPIO as interrupt source (which then has to stay configured
for this use), which would render the serial console unusable as it uses
the same pin in alternate function mode.

I've split up the changes into two parts to divide BSP changes from the
actual driver.

Greetings, Phil
