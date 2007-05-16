Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 19:20:31 +0100 (BST)
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:57359 "EHLO
	mallaury.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20023300AbXEPSU2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2007 19:20:28 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by mallaury.nerim.net (Postfix) with ESMTP id 4A0E44F3DB;
	Wed, 16 May 2007 20:19:43 +0200 (CEST)
Date:	Wed, 16 May 2007 20:20:01 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	i2c@lm-sensors.org, linux-mips@linux-mips.org,
	Domen Puncer <domen.puncer@ultra.si>
Subject: Re: [PATCH 1/2] i2c-au1550: send i2c stop on error #2
Message-ID: <20070516202001.7a7b2451@hyperion.delvare>
In-Reply-To: <20070516142038.GA15418@roarinelk.homelinux.net>
References: <20070516053113.GA12986@roarinelk.homelinux.net>
	<20070516153822.176cbd68@hyperion.delvare>
	<20070516142038.GA15418@roarinelk.homelinux.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

On Wed, 16 May 2007 16:20:38 +0200, Manuel Lauss wrote:
> > 2* In i2c_write and i2c_read, the stop bit is always sent together with
> > the last byte, while your new code sends the stop bit on its own after
> > the address byte. Is it OK? 
> 
> Well, no. However the quick probe does an i2c read IIRC so it should be
> safe. I'll fix that too.

From an I2C perspective, zero-byte transactions can be both reads and
writes. So if you accidentally send one more byte on the bus after the
address, you are actually doing a 1-byte read or write. The variant
used by the Linux kernel for probing purposes is the "write" variant.

> >                             I am wondering if your code isn't sending
> > an extra (0) byte after the address when asked to send a zero-byte
> > message. That would be bad. Do you have a bus analyzer or scope to
> > check what exactly is being sent on the bus in this case?
> 
> Yes I have a scope. I'll improve the driver some more and then check
> the actual data sent over the wires.

OK, thanks. I have to admit I am a bit curious how (if) you can send a
stop transaction on error without sending an extra byte with this chip.

-- 
Jean Delvare
