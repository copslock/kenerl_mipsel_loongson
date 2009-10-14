Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 06:19:48 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:49251 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492004AbZJNETk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 06:19:40 +0200
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9E4JERl023477;
	Wed, 14 Oct 2009 13:19:14 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay31.aps.necel.com with ESMTP; Wed, 14 Oct 2009 13:19:14 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Wed, 14 Oct 2009 13:19:14 +0900
Message-ID: <4AD5514B.4090504@necel.com>
Date:	Wed, 14 Oct 2009 13:19:23 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Ben Dooks <ben@fluff.org>
CC:	baruch@tkos.co.il, linux-i2c@vger.kernel.org, ben-linux@fluff.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
 I2C clock source
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com> <20091013224123.GB13398@fluff.org.uk>
In-Reply-To: <20091013224123.GB13398@fluff.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Ben Dooks wrote:
> On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
>> This driver is originally prepared for the ARM kernel where rich and
>> well-maintained "clkdev" clock framework is available, and clock name
>> might not be strictly required.  ARM's clkdev does slightly fuzzy
>> matching where it basically gives preference to "struct device" mathing
>> over "clock id".  As long as used for ARM machines, there's no problem.
>>
>> However, all users of this driver necessarily don't have the same clk
>> framework with ARM's, as the clk I/F implementation varies depending on
>> ARCHs and machines.
>>
>> This patch adds a clock name so that other users with simple/minimum/
>> limited clk support could make use of the driver.
> 
> You're meant to match with both the device and name, I belive the
> clkdev specification has always said this. I'm of the opinion if
> the clkdev implementation isn't getting this right, then it is the
> clkdev that should be fixed, not this driver.

Thanks both, Mark and Ben.  I do see your point, so would like to
fix my clk (not clkdev :-D) implementation accordingly, or keep the
fix local.  

# As you can imagine, my local clk implementation is based on
  "clk_id" name matching, which looks simple for me.

---

By the way, my original intention of the patch was slightly different;
I didn't intend to modify the driver for my clk framework.  Let me
explain a bit here.

The point is, we need to consider clk_get() implementation and
clk_get() user, separately.

* clk_get() implementation varies depending on ARCHs and machines.
  For whatever historical reasons, this is the present situation.

* And clk_get() is expected to pick up a clock source with:

 1) dev_id + clk_id ... strict matching condition (default)
 2) dev_id only ... fuzzy extension1 (clk_id can be regarded as wildcard)
 3) clk_id only ... fuzzy extension2 (dev_id can be regarded as wildcard)

  2) and 3) might be sort of ARM's clkdev extensions
  (I think it's useful), but that's not my point.
  I'll leave that alone for now.

  My point is that clk framework basically requires case 1).

* Then the driver is expected to supply necessary information to
  clk_get(), regardless of clk_get() implementation, or should I say,
  the driver should always supply both "dev_id" and "clk_id" whether
  they are used or not.

  This makes drivers much independent from the clk framework, IMHO.

* From the point of drivers, we're never interested in clk_get()
  implementation, and which matching pattern 1) - 3) is taken.

  Supplying only "dev_id" could be regarded as misuse of clk_get(),
  and will increase dependence on clk framework implementation.

* All other clk_get() users with one ID supplied, should be fixed as
  well.

I intended only to fix the driver in the right direction, so would
like to avoid discussion on clk framework implementation here.

Anyway, I'm going to drop this fix next time.  Thanks!
-- 
Shinya Kuribayashi
NEC Electronics
