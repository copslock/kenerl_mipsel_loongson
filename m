Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 09:20:05 +0000 (GMT)
Received: from smtp002.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.126]:19097
	"HELO smtp002.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8224929AbVCUJTu>; Mon, 21 Mar 2005 09:19:50 +0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp002.bizmail.yahoo.com with SMTP; 21 Mar 2005 09:19:47 -0000
Message-ID: <423E91B3.4000302@embeddedalley.com>
Date:	Mon, 21 Mar 2005 01:19:47 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Michael Stickel <michael@cubic.org>
CC:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org> <423E7B9D.3040908@cubic.org>
In-Reply-To: <423E7B9D.3040908@cubic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7482
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> Even if I don't make me a lot of friends, the au1x00 driver seems to be 
> a hack.

Well, it basically is.

> Most of the difference seems to be the PCI stuff, that has been removed 
> and the access method.

There were a bunch of differences including how you program the baud rate, the 
addresses of the registers, and if I remember correctly, additional/different 
registers. To cleanly get the au1x support into the 8250 driver, some additional 
abstraction was necessary and I just never had the time to do it.

Pete
