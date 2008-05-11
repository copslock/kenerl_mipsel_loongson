Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2008 08:41:08 +0100 (BST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:58205 "EHLO
	services.gcu-squad.org") by ftp.linux-mips.org with ESMTP
	id S20023240AbYEKHlF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 May 2008 08:41:05 +0100
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Jv77K-00010A-7f
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	; Sun, 11 May 2008 10:41:14 +0200
Date:	Sun, 11 May 2008 09:40:48 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Brownell <david-b@pacbell.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexander Bigga <ab@mycable.de>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, i2c@lm-sensors.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80
Message-ID: <20080511094048.292c885d@hyperion.delvare>
In-Reply-To: <Pine.LNX.4.55.0805110045010.18978@cliff.in.clinika.pl>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<20080508093456.340a42b0@hyperion.delvare>
	<Pine.LNX.4.55.0805091917370.10552@cliff.in.clinika.pl>
	<20080509222754.03de1c54@hyperion.delvare>
	<Pine.LNX.4.55.0805100116290.10552@cliff.in.clinika.pl>
	<20080510103544.701c7b3f@hyperion.delvare>
	<Pine.LNX.4.55.0805110045010.18978@cliff.in.clinika.pl>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Maciej,

On Sun, 11 May 2008 02:59:34 +0100 (BST), Maciej W. Rozycki wrote:
> > Still not correct, sorry. The driver is still making unconditional
> > calls to i2c_smbus_read_byte_data() and i2c_smbus_write_byte_data(), so
> > the underlying adapter _must_ support I2C_FUNC_SMBUS_READ_BYTE_DATA and
> > I2C_FUNC_SMBUS_WRITE_BYTE_DATA (i.e. I2C_FUNC_SMBUS_BYTE_DATA), even if
> 
>  Well, as I understand the support for I2C_FUNC_SMBUS_I2C_BLOCK
> (read/write, as appropriate) implies I2C_FUNC_SMBUS_BYTE_DATA as the
> latter is a special case of the former, where the length of the transfer
> equals one.

In theory you are right, yes. But as I wrote before, functionality are
expressed in a boolean way, so adapters can't express their limitations
if there are any. Think of an adapter which could only transfer blocks
of even size, it would most certainly declare itself
I2C_FUNC_SMBUS_I2C_BLOCK capable (even though it can't do all of it)
but wouldn't declare I2C_FUNC_SMBUS_BYTE_DATA as it can't do it. This
is just an example of course, in practice I just can't remember of any
I2C or SMBus adapter not implementing I2C_FUNC_SMBUS_BYTE_DATA.

The bottom line is that you should never assume that support for a
given transaction type implies support for another transaction type.

>              But I agree -- in the light of what you wrote previously a
> bus adapter that supports say I2C_FUNC_SMBUS_READ_I2C_BLOCK is meant to
> have I2C_FUNC_SMBUS_READ_BYTE set as well, so no need to check for it
> here.
> 
>  If we agree on this one, I will retest and submit the whole batch again,
> updated as needed.

Yes, you code looks correct to me now, i2c-wise.

-- 
Jean Delvare
