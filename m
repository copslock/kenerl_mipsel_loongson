Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 19:51:52 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:32013 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8226662AbVGLSvg>; Tue, 12 Jul 2005 19:51:36 +0100
Received: from [192.168.1.109] (adsl-71-128-175-242.dsl.pltn13.pacbell.net [71.128.175.242])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j6CIcsmN015946;
	Tue, 12 Jul 2005 14:38:55 -0400
In-Reply-To: <20050712181013.GC9234@gundam.enneenne.com>
References: <20050712142202.GB9234@gundam.enneenne.com> <20050712181013.GC9234@gundam.enneenne.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a2882b70a3d6c0f32728086e0c63764c@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: power management status for au1100
Date:	Tue, 12 Jul 2005 11:52:30 -0700
To:	Rodolfo Giometti <giometti@linux.it>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Jul 12, 2005, at 11:10 AM, Rodolfo Giometti wrote:

> Looking at linux-2.6.10 I notice that the function
> startup_match20_interrupt() has been mofified as follow:

This is an update AMD/Alchemy wanted so if you weren't using
power management the timer would be available for other uses.

> Where could be the problem in the new code?

I don't know.  I suspect some of it didn't get moved forward
properly.

> Should we come back to the old code? ;-p

Now that you know the reason for the change, perhaps we
should try to make it work properly :-)

Thanks.


	-- Dan
