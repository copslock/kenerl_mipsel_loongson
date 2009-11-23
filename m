Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:42:26 +0100 (CET)
Received: from aeryn.fluff.org.uk ([87.194.8.8]:54213 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL)
	by eddie.linux-mips.org with ESMTP id S1493464AbZKWXue (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 00:50:34 +0100
Received: from ben by kira.home.fluff.org with local (Exim 4.69)
	(envelope-from <ben@fluff.org.uk>)
	id 1NCi4N-00022D-96; Mon, 23 Nov 2009 23:11:43 +0000
Date:	Mon, 23 Nov 2009 23:11:43 +0000
From:	Ben Dooks <ben-linux@fluff.org>
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	baruch@tkos.co.il, ben-linux@fluff.org, linux-i2c@vger.kernel.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] i2c-designware updates
Message-ID: <20091123231143.GA32202@fluff.org.uk>
References: <4AF419B6.1000802@necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AF419B6.1000802@necel.com>
X-Disclaimer: These are my own opinions, so there!
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <ben@fluff.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25109
X-Approved-By: ralf@linux-mips.org
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
> 
> There are 22 patches in total and might be slightly annoying.  I'll
> send subsequent patches only to linux-i2c.

These are all queued at:

	git://git.fluff.org/bjdooks/linux.git next-i2c-designware

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
