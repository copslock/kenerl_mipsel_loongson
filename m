Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 06:20:15 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45834 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492234AbZJNEUG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 06:20:06 +0200
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9E4Jpne004718;
	Wed, 14 Oct 2009 13:19:51 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.36] [10.29.19.36]) by relay21.aps.necel.com with ESMTP; Wed, 14 Oct 2009 13:19:51 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Wed, 14 Oct 2009 13:19:51 +0900
Message-ID: <4AD5516F.6090302@necel.com>
Date:	Wed, 14 Oct 2009 13:19:59 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
CC:	baruch@tkos.co.il, linux-i2c@vger.kernel.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
	ben-linux@fluff.org
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
 I2C clock source
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com> <20091013095417.GB1230@sirena.org.uk>
In-Reply-To: <20091013095417.GB1230@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Mark Brown wrote:
> On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
>> This driver is originally prepared for the ARM kernel where rich and
>> well-maintained "clkdev" clock framework is available, and clock name
>> might not be strictly required.  ARM's clkdev does slightly fuzzy
>> matching where it basically gives preference to "struct device" mathing
>> over "clock id".  As long as used for ARM machines, there's no problem.
> 
>> However, all users of this driver necessarily don't have the same clk
>> framework with ARM's, as the clk I/F implementation varies depending on
>> ARCHs and machines.
> 
>> This patch adds a clock name so that other users with simple/minimum/
>> limited clk support could make use of the driver.
> 
> This seems like something that it'd be better to fix in the relevant
> clock frameworks in order to try to keep the API consistently usable
> between platforms.  The clkdev matching library that most of the ARM
> platforms use should be generic enough to be usable elsewhere, there
> is regular discussion of moving it somewhere more generic.

Before fixing the driver, I've checked various discussion archives on
clock framework, git log histories, and source codes of almost all ARM
common/mach/plat and SH variants, so I think I know enough backgrounds
on this.

-- 
Shinya Kuribayashi
NEC Electronics
