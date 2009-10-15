Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 05:37:55 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:49325 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491971AbZJODhs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 05:37:48 +0200
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n9F3bHoe007147;
	Thu, 15 Oct 2009 12:37:19 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay31.aps.necel.com with ESMTP; Thu, 15 Oct 2009 12:37:18 +0900
Received: from [10.114.180.134] ([10.114.180.134] [10.114.180.134]) by mbox02.aps.necel.com with ESMTP; Thu, 15 Oct 2009 12:37:18 +0900
Message-ID: <4AD698EE.4030608@necel.com>
Date:	Thu, 15 Oct 2009 12:37:18 +0900
From:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	Russell King - ARM Linux <linux@arm.linux.org.uk>
CC:	Ben Dooks <ben@fluff.org>, linux-arm-kernel@lists.infradead.org,
	linux-mips@linux-mips.org, baruch@tkos.co.il,
	linux-i2c@vger.kernel.org, ben-linux@fluff.org
Subject: Re: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
 I2C clock source
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com> <20091013224123.GB13398@fluff.org.uk> <4AD5514B.4090504@necel.com> <20091014191419.GB28948@n2100.arm.linux.org.uk>
In-Reply-To: <20091014191419.GB28948@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <shinya.kuribayashi@necel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi@necel.com
Precedence: bulk
X-list: linux-mips

Ben, Mark and Russell,

Russell King - ARM Linux wrote:
[ big snip ]
> I would strongly advise you to ensure that your implementation conforms
> to the intentions of the clk API

Thanks for kind explanations.  I'd like to give the clkdev a try.
-- 
Shinya Kuribayashi
NEC Electronics
