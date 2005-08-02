Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2005 13:55:37 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:24077 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225327AbVHBMzV>; Tue, 2 Aug 2005 13:55:21 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j72CgbmN005162;
	Tue, 2 Aug 2005 08:42:37 -0400
In-Reply-To: <2db32b7205080122114c1b5f07@mail.gmail.com>
References: <2db32b7205080122114c1b5f07@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <84b6c5684b91af184b4837b9d82120e8@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Is X Windows working on db1550 Now?
Date:	Tue, 2 Aug 2005 08:58:53 -0400
To:	rolf liu <rolfliu@gmail.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Aug 2, 2005, at 1:11 AM, rolf liu wrote:

> Even though running x on db1550 could be slow, still want to try it
> for fun. is the x windows already running on db1550?

The db1550 doesn't have a frame buffer, you would have to
attach some PCI graphics card.

> .... I saw there is a
> frame buffer driver for db board.

For the db1100, with it's internal frame buffer.

>  Not sure if it can support the x ?

I've run the MIPS binaries that are floating around the 'net
on the Au1500 with a SM501 PCI controller.  Performance
was quite good.


	-- Dan
