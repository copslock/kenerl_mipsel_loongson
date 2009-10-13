Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2009 10:01:45 +0200 (CEST)
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:45271 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492532AbZJMIBi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Oct 2009 10:01:38 +0200
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9D81LuC027880;
	Tue, 13 Oct 2009 17:01:21 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay11.aps.necel.com with ESMTP; Tue, 13 Oct 2009 17:01:21 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Tue, 13 Oct 2009 17:01:21 +0900
Message-ID: <4AD433D8.8090900@necel.com>
Date:	Tue, 13 Oct 2009 17:01:28 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Baruch Siach <baruch@tkos.co.il>
CC:	linux-i2c@vger.kernel.org, ben-linux@fluff.org,
	linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC] i2c-designware patches
References: <4AD3E974.8080200@necel.com> <20091013070412.GA9739@jasper.tkos.co.il>
In-Reply-To: <20091013070412.GA9739@jasper.tkos.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Baruch Siach wrote:
> On Tue, Oct 13, 2009 at 11:44:04AM +0900, Shinya Kuribayashi wrote:
>> Here're various improvements / bug-fixing patches for DW I2C driver.
>> I'm working with v2.6.27-based kernel, but they must work fine with the
>> latest mainline kernel.
>>
>> It's stil in RFC, and I'm working with it for some time.  Any comments
>> or suggestions are highly appreciated.  Then I'll respin and give it a
>> test, thanks.
>>
>> Baruch, I'd say the base driver is in good shape enogh, so I'm having
>> a fun with modifing the driver.  Thanks for the initial work.
> 
> Thanks. It is good to see that my work is actually useful for someone. I'll go 
> over this series in the coming days. Unfortunately I don't have the hardware 
> for testing anymore, but I'll try at least to compile test these patches.

No problem, I could do real tests on real hardwares, so just give me a
feedback.  Grammar corrections or rewording is also appriciated.

> By the way, what is the chip you work with?

I'd like to avoid specific comment on this.  I'm working with our big-
endian MIPS SoCs which are not in mainline.

-- 
Shinya Kuribayashi
NEC Electronics
