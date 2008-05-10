Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2008 08:08:17 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:62844 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20021567AbYEJHIO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 May 2008 08:08:14 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Juk81-0001W2-AP
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Sat, 10 May 2008 10:08:25 +0200
Date:	Sat, 10 May 2008 09:08:01 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Brownell <david-b@pacbell.net>, linux-mips@linux-mips.org,
	mgreer@mvista.com, rtc-linux@googlegroups.com,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-kernel@vger.kernel.org, i2c@lm-sensors.org, ab@mycable.de
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Message-ID: <20080510090801.74da049d@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805092202380.10552@cliff.in.clinika.pl>
References: <200805070120.03821.david-b@pacbell.net>
	<200805071625.20430.david-b@pacbell.net>
	<Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
	<200805090218.52570.david-b@pacbell.net>
	<Pine.LNX.4.55.0805092202380.10552@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

On Fri, 9 May 2008 22:22:11 +0100 (BST), Maciej W. Rozycki wrote:
> > >  You can issue a block read of up to 5 bytes (6 if you add the PEC byte
> > > which is not interpreted by the controller in any way).  And you can issue
> > > a block write of up to 4 bytes (5 with PEC).  That's clearly not enough
> > > for the m41t81 let alone a generic implementation.
> > 
> > Right.  Possibly worth updating i2c-sibyte to be able to perform
> > those calls through the "smbus i2c_block" calls; but maybe not.
> > (Those calls aren't true SMBus calls, but many otherwise-SMBus-only
> > controllers can handle them, hence the i2c_smbus_* prefix.)
> 
>  I am not sure such a limited functionality is worth the hassle of making 
> it available to clients in a reasonably clean way.  How common an 
> extension of this kind is among SMBus controllers?  I would say if there 
> are other controllers providing it (perhaps for a different range of 
> transfer lengths) and clients benefitting from it, it might be worth 
> adding it for this controller as well.  Otherwise perhaps let's wait till 
> somebody complains about the lack of this functionality?

The problem is that the interface for client drivers to query the
adapters capabilities is rather limited. There's just one bit for I2C
block read, so if an adapter has limitations in the size of requests it
can accept (beyond the traditional 32-byte limit that comes from SMBus)
it can't express it. This means that client drivers should expect
transaction requests to fail even if they checked that the transaction
type in question was supported. Most client drivers don't actually
expect that.

My advice would be to only bother implementing restricted support for a
transaction type if there's a big benefit in doing so. And then, double
check that all the client drivers that are likely to be used with the
adapter in question, are robust enough to deal with the restrictions
gracefully.

-- 
Jean Delvare
