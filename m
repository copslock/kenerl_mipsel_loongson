Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2005 21:47:57 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:57103 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8224966AbVDZUrm>; Tue, 26 Apr 2005 21:47:42 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j3QKgAfg031907;
	Tue, 26 Apr 2005 16:42:10 -0400
In-Reply-To: <ecb4efd105042612586d43fcc5@mail.gmail.com>
References: <ecb4efd105042612586d43fcc5@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <322b387146f9931748c566c2f6352746@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: should the kernel be initializing the uarts on the Au1550?
Date:	Tue, 26 Apr 2005 16:47:43 -0400
To:	Clem Taylor <clem.taylor@gmail.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Apr 26, 2005, at 3:58 PM, Clem Taylor wrote:

> It seems that the kernel (2.6.10) isn't properly initializing the
> Au1550 serial ports.

What do you mean by "initializing"?

> .... Linux seems to need yamon to configure ....

Linux assumes yamon for the Db1xxx and Pb1xxx
boards will configure nearly all of the IO pins
properly.  This is quite the opposite of most embedded
systems that assume nothing and rely on the Linux
board startup functions to do this.

It is just historical, and could be changed.  First, we
need to add sufficient configuration information so
we know what IO is used (serial ports in this case).
Second we need the functions to do the proper
set up based upon the selected configuration.

Then, the discussions (arguments) start about what
should be further assumed about initialization :-)
My preference is that if we should do all of the
initialization and assume nothing, because we could
probably eliminate lots of board specific set up
files and use more common software.

Thanks.


	-- Dan
