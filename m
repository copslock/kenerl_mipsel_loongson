Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 17:50:02 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:24331 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225308AbVDEQtr>; Tue, 5 Apr 2005 17:49:47 +0100
Received: from [192.168.87.101] (pool-151-203-225-221.bos.east.verizon.net [151.203.225.221])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j35GkTqB008058;
	Tue, 5 Apr 2005 12:46:29 -0400
In-Reply-To: <200504041717.29098.eckhardt@satorlaser.com>
References: <200504041717.29098.eckhardt@satorlaser.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <de11cd376cdc88e9c292ae7e204e2de9@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: Au1100 FB driver uplift for 2.6
Date:	Tue, 5 Apr 2005 12:49:41 -0400
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Apr 4, 2005, at 11:17 AM, Ulrich Eckhardt wrote:

> Am I on the wrong way or should I just reimplement it and send a patch?

If you an test it, do it and send a patch.

> [2] Based on DB1100. Are there any pointers on how to port to a new 
> board,
> btw?

One of the discussion items is always how to keep a "generic"
driver and still provide unique setup/control for different types of
boards.  I guess if we can discuss other board ports, it will be
more clear how to do this.

Thanks.


	-- Dan
