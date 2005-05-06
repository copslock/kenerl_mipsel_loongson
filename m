Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 15:55:01 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:37394 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225459AbVEFOyr>; Fri, 6 May 2005 15:54:47 +0100
Received: from [192.168.2.27] (h69-21-252-132.69-21.unk.tds.net [69.21.252.132])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j46EmAfg004926;
	Fri, 6 May 2005 10:48:11 -0400
In-Reply-To: <20050506142719.GA13148@enneenne.com>
References: <20050505155435.GA28227@enneenne.com> <1115311361.1614.6.camel@localhost.localdomain> <20050506142719.GA13148@enneenne.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <806d447ce4c6480116ebd3d9fbaeafc6@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	Pete Popov <ppopov@embeddedalley.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: USB hangs on AU1100
Date:	Fri, 6 May 2005 10:54:36 -0400
To:	Rodolfo Giometti <giometti@linux.it>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On May 6, 2005, at 10:27 AM, Rodolfo Giometti wrote:

> Yes, you was right, I missing to setup USB clock...

The other thing you have to always remember when comparing
operation to "... a board just like the Db1xxx ... " is that yamon does
lots and lots of set up for the board that Linux assumes will be
done.  We've discussed this in the past, I just wanted to mention
it again so it isn't forgotten. ;-)

Thanks.


	-- Dan
