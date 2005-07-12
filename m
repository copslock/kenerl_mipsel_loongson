Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 16:55:56 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:8205 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8226647AbVGLPzj>; Tue, 12 Jul 2005 16:55:39 +0100
Received: from [192.168.1.109] (adsl-71-128-175-242.dsl.pltn13.pacbell.net [71.128.175.242])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j6CFgvmN015581;
	Tue, 12 Jul 2005 11:42:58 -0400
In-Reply-To: <20050712142202.GB9234@gundam.enneenne.com>
References: <20050712142202.GB9234@gundam.enneenne.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8aee3747cc5c0d3ed94deb5b256bab94@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: power management status for au1100
Date:	Tue, 12 Jul 2005 08:56:31 -0700
To:	Rodolfo Giometti <giometti@linux.it>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jul 12, 2005, at 7:22 AM, Rodolfo Giometti wrote:

> I'm just looking at linux support for power management on au1100 CPU
> and I found that there are a lot of problems on enabling it... it
> seems that current support cames from 2.4 series.

I provided most of the recent generic updates for the Au1xxx power
management in the 2.4.  It's quite a challenge since you also need
hardware support for external peripheral control (which should be
in the drivers) and a cooperating boot rom for deep sleep.

> Is anybody dealing with it? I'd like to cooperate in order to have a
> functional support.

I'm sure there are some custom derivatives of this around.  I'm
not actively working on it since I don't have a project that requires
the features.  I don't really have the time to do so, either :-)

The one thing to keep in mind is we probably shouldn't promote
any of the variable processor frequency, as Alchemy has warned
they don't qualify parts at anything but their stated operating values.
You can run the processors at different frequencies, but this can
require different external components to support it, not something
we should be dynamically changing for a particular system design.

Thanks.


	-- Dan
