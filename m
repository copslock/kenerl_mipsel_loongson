Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 17:06:30 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:14067 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225309AbTHSQG0>;
	Tue, 19 Aug 2003 17:06:26 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA02269;
	Tue, 19 Aug 2003 09:06:20 -0700
Subject: Re: GPIO support for db1100
From: Pete Popov <ppopov@mvista.com>
To: Yasushi SHOJI <Yasushi.SHOJI@atmark-techno.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030819015408.312713E614@dns1.atmark-techno.com>
References: <20030819015408.312713E614@dns1.atmark-techno.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1061309193.1488.450.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Aug 2003 09:06:33 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-08-18 at 18:54, Yasushi SHOJI wrote:
> Steve and all,
> 
> I'd like to add gpio support to db1100 and/or au1100.
> 
> since there already is au1000_gpio.c in driver/char, should I go
> fixing and renaming au1000_gpio.c to au1x00_gpio.c or create
> au1100_gpio.c and asm-mips/au1100_gpio.h?

Why do you need to rename the file? The only way to do that with cvs is
to delete it and add the new file, and then you lose all cvs log info.
It would have been nice to have named the file au1x00_gpio instead of
au1000_gpio, but I don't think that's critical to using the driver.

Pete
