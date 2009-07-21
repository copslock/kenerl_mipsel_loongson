Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 17:08:11 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:51336 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493073AbZGUPIE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Jul 2009 17:08:04 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6LF8J7O018851;
	Tue, 21 Jul 2009 16:08:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6LF8Cp6018849;
	Tue, 21 Jul 2009 16:08:12 +0100
Date:	Tue, 21 Jul 2009 16:08:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] ar7: fix build failures when CONFIG_SERIAL_8250 is
	not enabled
Message-ID: <20090721150811.GA18826@linux-mips.org>
References: <200907211237.39264.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907211237.39264.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 21, 2009 at 12:37:37PM +0200, Florian Fainelli wrote:

> This patch fixes the following build failure when CONFIG_SERIAL_8250
> is not enabled in the kernel configuration:
> arch/mips/ar7/built-in.o: In function `ar7_register_devices':
> platform.c:(.init.text+0x61c): undefined reference to `early_serial_setup'
> platform.c:(.init.text+0x61c): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'
> platform.c:(.init.text+0x68c): undefined reference to `early_serial_setup'
> platform.c:(.init.text+0x68c): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'

This patch rejects.

  Ralf
