Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 10:38:42 +0100 (BST)
Received: from fnoeppeil43.netpark.at ([217.175.205.171]:20680 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20045206AbYHEJig (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 10:38:36 +0100
Received: (qmail 26310 invoked from network); 5 Aug 2008 11:38:32 +0200
Received: from flagship.roarinelk.net (HELO ?192.168.0.197?) (192.168.0.197)
  by fnoeppeil43.netpark.at with SMTP; 5 Aug 2008 11:38:32 +0200
Message-ID: <48981F96.5040907@roarinelk.homelinux.net>
Date:	Tue, 05 Aug 2008 11:38:30 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
Organization: Private
User-Agent: Thunderbird 2.0.0.16 (X11/20080726)
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] [MIPS] Add USB device (OTG) support for Au1200 and Au1250
References: <> <1217881052-18797-1-git-send-email-khickey@rmicorp.com> <1217881052-18797-2-git-send-email-khickey@rmicorp.com>
In-Reply-To: <1217881052-18797-2-git-send-email-khickey@rmicorp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Kevin,

Kevin Hickey wrote:
> This patch adds support for the USB Device controller on the Au1200 and Au1250.

Awesome!


> With this patch, only basic device mode is supported; full On-The-Go
> functionality will be completed in a later release.  Two new drivers are
> included; au1200_udc is the USB Device Controller driver and au1200_otg is the
> portmux driver.  The portmux driver determines the mode of operation for the
> port based on software and hardware selectors.  Currently, it only supports
> device mode.
> 
> These drivers have been tested on a DB1200 board using the g_file_storage gadget.

Apart from the usual condingstyle nits (run it through scripts/checkpatch.pl please),
there's one thing: The GPIO code in the uoc header must go away.  Pass function
pointers to enable/disable VBUS through platform data, but don't modify GPIOs
directly (i.e. get rid of all code which assumes its running on DB1200).

You should also CC linux-usb ML.

Thanks,
	Manuel Lauss
