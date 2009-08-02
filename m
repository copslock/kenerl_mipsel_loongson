Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2009 20:37:20 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42007 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492880AbZHBShN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Aug 2009 20:37:13 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n72Ibgwv009068;
	Sun, 2 Aug 2009 19:37:42 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n72IbeFZ009066;
	Sun, 2 Aug 2009 19:37:40 +0100
Date:	Sun, 2 Aug 2009 19:37:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] mtx-1: request button GPIO before setting its direction
Message-ID: <20090802183740.GA9058@linux-mips.org>
References: <200908012351.21059.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908012351.21059.florian@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 01, 2009 at 11:51:20PM +0200, Florian Fainelli wrote:
> From: Florian Fainelli <florian@openwrt.org>
> Date: Sat, 1 Aug 2009 23:51:20 +0200
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@googlemail.com>
> Subject: [PATCH] mtx-1: request button GPIO before setting its direction
> Content-Type: text/plain;
> 	charset="utf-8"
> 
> This patch fixes the following warning at boot time:
> WARNING: at drivers/gpio/gpiolib.c:83 0x8021d5e0()
> autorequest GPIO-207
> Modules linked in:
> Call Trace:[<8011e0ec>] 0x8011e0ec
> [<80110a28>] 0x80110a28
> [<80110a28>] 0x80110a28
> [..snip..]
> 
> The current code does not request the GPIO and attempts
> to set its direction, which is a violation of the GPIO API.
> This patch also unhardcode the GPIO we request and use
> the one we defined in the button driver.

Thanks, applied.

  Ralf
