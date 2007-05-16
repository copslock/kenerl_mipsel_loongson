Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 15:21:47 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:32780 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023278AbXEPOVp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 May 2007 15:21:45 +0100
Received: (qmail 15469 invoked by uid 1000); 16 May 2007 16:20:38 +0200
Date:	Wed, 16 May 2007 16:20:38 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Jean Delvare <khali@linux-fr.org>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	Domen Puncer <domen.puncer@ultra.si>
Subject: Re: [PATCH 1/2] i2c-au1550: send i2c stop on error #2
Message-ID: <20070516142038.GA15418@roarinelk.homelinux.net>
References: <20070516053113.GA12986@roarinelk.homelinux.net> <20070516153822.176cbd68@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070516153822.176cbd68@hyperion.delvare>
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Jean,

On Wed, May 16, 2007 at 03:38:22PM +0200, Jean Delvare wrote:
> Hi Manuel,
> 
> 1* It looks to me like there are other error conditions which also
> cause the driver to leave without issuing a stop condition on the bus:
> if not all bytes of a write are acked by the target slave (in
> i2c_write) or if the master receives less bytes than expected (in
> i2c_read). I understand these are less likely to happen than the quick
> write case which bit you, but shouldn't these bugs be fixed as well?

Hm, didn't think about those (because I didn't hit them yet)
I'll fix them too of course. (I even started a complete rewrite of this
driver [using IRQ and DMA instead of polling] a few months back but got
stuck and instead fixed the bug that annoyed me the most)
 
> 2* In i2c_write and i2c_read, the stop bit is always sent together with
> the last byte, while your new code sends the stop bit on its own after
> the address byte. Is it OK? 

Well, no. However the quick probe does an i2c read IIRC so it should be
safe. I'll fix that too.

>                             I am wondering if your code isn't sending
> an extra (0) byte after the address when asked to send a zero-byte
> message. That would be bad. Do you have a bus analyzer or scope to
> check what exactly is being sent on the bus in this case?

Yes I have a scope. I'll improve the driver some more and then check
the actual data sent over the wires.

Thank you for your review, much appreciated!
	Manuel Lauss
