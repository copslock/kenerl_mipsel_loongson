Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 18:07:32 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:13072 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225345AbVAUSH1>; Fri, 21 Jan 2005 18:07:27 +0000
Received: from [10.1.100.52] (mail.chipsandsystems.com [64.164.196.27])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j0LHnbfA012312;
	Fri, 21 Jan 2005 12:49:38 -0500
In-Reply-To: <ecb4efd10501210949db48ce1@mail.gmail.com>
References: <ecb4efd10501210949db48ce1@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4B9E0F1F-6BD7-11D9-B764-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: CONFIG_PM depends on CONFIG_MACH_AU1X00?
Date:	Fri, 21 Jan 2005 10:07:21 -0800
To:	Clem Taylor <clem.taylor@gmail.com>
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Jan 21, 2005, at 9:49 AM, Clem Taylor wrote:

> I was looking at the TOY (time of year stuff) in
> arch/mips/au1000/common/time.c and noticed that it depends on
> CONFIG_PM,

Well .... not exactly :-)

When you use the power management of the Au1xxx to enter
lower power modes, the CP0 counter stops as well.  We use the TOY
clock to keep track of system time and kernel timer interrupts
if this configuration option is selected.

The kernel timer code assumes it has access to the TOY when
CONFIG_PM is enabled.  If you intend to use TOY for something
else, make sure you don't cause trouble for the kernel timer functions.

Thanks.

	-- Dan
