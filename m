Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 00:02:56 +0100 (CET)
Received: from trinity.fluff.org ([89.16.178.74]:49095 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493285AbZKFXCt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Nov 2009 00:02:49 +0100
Received: from ben by trinity.fluff.org with local (Exim 4.69)
	(envelope-from <ben@trinity.fluff.org>)
	id 1N6XEw-0007wP-UI; Fri, 06 Nov 2009 22:25:06 +0000
Date:	Fri, 6 Nov 2009 22:25:06 +0000
From:	Ben Dooks <ben-linux@fluff.org>
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	baruch@tkos.co.il, ben-linux@fluff.org, linux-i2c@vger.kernel.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] i2c-designware updates
Message-ID: <20091106222506.GP23772@trinity.fluff.org>
References: <4AF419B6.1000802@necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AF419B6.1000802@necel.com>
X-Disclaimer: These are my views alone.
X-URL:	http://www.fluff.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@trinity.fluff.org
X-SA-Exim-Scanned: No (on trinity.fluff.org); SAEximRunCond expanded to false
Return-Path: <ben@trinity.fluff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben-linux@fluff.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 06, 2009 at 09:42:30PM +0900, Shinya Kuribayashi wrote:
> Hi Baruch and Ben,
>
> here's v2 patchset of DesignWare I2C driver (i2c-designware.c).
> I did all test I can do for now (including arbitration tests), and
> fixed more issues left in the v1 patchset.  I think now the driver is
> in reasonable shape for the mainline, and hope gets merged.
>
> The patches which already have Baruch's Acked-by: line are logically
> same as the previous v1 patches.  For the rest are revised version of
> v1 patches, or newly added in v2.

thanks, the first pass seems ok, will give a thorough review by next
week and get a branch with them on for -next submission.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
