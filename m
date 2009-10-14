Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:14:52 +0200 (CEST)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38131 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493679AbZJNTOq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:14:46 +0200
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arm.linux.org.uk; s=caramon; h=Date:From:To:Cc:Subject:
	Message-ID:References:MIME-Version:Content-Type:In-Reply-To:
	Sender; bh=0XDUO7zw2x/nDWfk/9gDegddscv/fovoeCR760Bp+kk=; b=EYMep
	UiEdyznjmQc4a8KfhGDteE3rQFdgREgA9m0WXyn+ibomkDCcDlxMQB3aXkyAfD/e
	DQR8PY6Q60k18wxbqfahZpsL/jV2oYvasiycUQIDtemtaCZoofsFaSxcuOiU/FNq
	I19Iv09qai1ZXWvNS53MD0MLdbF39M3f/p9WPM=
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1My9Ij-000554-Mk; Wed, 14 Oct 2009 20:14:22 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1My9Ih-0007ct-Qg; Wed, 14 Oct 2009 20:14:19 +0100
Date:	Wed, 14 Oct 2009 20:14:19 +0100
From:	Russell King - ARM Linux <linux@arm.linux.org.uk>
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	Ben Dooks <ben@fluff.org>, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, baruch@tkos.co.il,
	linux-i2c@vger.kernel.org, ben-linux@fluff.org
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
Message-ID: <20091014191419.GB28948@n2100.arm.linux.org.uk>
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com> <20091013224123.GB13398@fluff.org.uk> <4AD5514B.4090504@necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AD5514B.4090504@necel.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 01:19:23PM +0900, Shinya Kuribayashi wrote:
> # As you can imagine, my local clk implementation is based on
>  "clk_id" name matching, which looks simple for me.

... but totally wrong, and will eventually bite you.  Please use clkdev
and use the device names for the primary matching.  clkdev is what I see
as the de-facto implementation that should eventually become totally
arch independent (it is today, but lives in arch/arm for no real reason
other than my lazyness.)

> * And clk_get() is expected to pick up a clock source with:
>
> 1) dev_id + clk_id ... strict matching condition (default)
> 2) dev_id only ... fuzzy extension1 (clk_id can be regarded as wildcard)
> 3) clk_id only ... fuzzy extension2 (dev_id can be regarded as wildcard)
>
>  2) and 3) might be sort of ARM's clkdev extensions
>  (I think it's useful), but that's not my point.
>  I'll leave that alone for now.
>
>  My point is that clk framework basically requires case 1).

Incorrect.  There is no requirement for strict matching.  Think about
the situation where you have multiple different devices, and the SoC
designer has decided to tie all those clock signals to one clock source,
and this is the only clock in the system.

You might decide that your clk_get() implementation can just return that
single clock irrespective of the parameters passed.  That's a totally
legal clk API implementation.

Also, I refer you to the description of clk_get():

 * clk_get - lookup and obtain a reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock comsumer ID
 *
 * Returns a struct clk corresponding to the clock producer, or
 * valid IS_ERR() condition containing errno.  The implementation
 * uses @dev and @id to determine the clock consumer, and thereby
 * the clock producer.  (IOW, @id may be identical strings, but
 * clk_get may return different clock producers depending on @dev.)

Note the comment about identical IDs returning different producers.

> * Then the driver is expected to supply necessary information to
>  clk_get(), regardless of clk_get() implementation, or should I say,
>  the driver should always supply both "dev_id" and "clk_id" whether
>  they are used or not.

Nope.  On several devices which only consume one clock signal, we
explicitly pass a NULL ID to absolutely prevent people going down
the road of matching only by "clk id" - it's been shown to be the
wrong approach, and leads people right down the path of passing
clock strings and pointers into drivers.

That's precisely what the clk API was designed to prevent - and
becomes all together unnecessary when the clk API is implemented
as I designed it - to match primerily by device ID.

> I intended only to fix the driver in the right direction, so would
> like to avoid discussion on clk framework implementation here.

I would strongly advise you to ensure that your implementation conforms
to the intentions of the clk API as I outline above to avoid problems
in the future.
