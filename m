Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2004 01:31:30 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:32268
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8225241AbUJXAbZ>;
	Sun, 24 Oct 2004 01:31:25 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9O0VMA03330;
	Sat, 23 Oct 2004 17:31:24 -0700
Message-ID: <417AF7AF.9030400@embeddedalley.com>
Date: Sat, 23 Oct 2004 17:30:39 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bruno Randolf <520066427640-0001@t-online.de>
CC: linux-mips@linux-mips.org,
	"'Eric DeVolder'" <eric.devolder@amd.com>
Subject: Re: Hi-Speed USB controller and au1500
References: <20041023173352.90595.qmail@web81006.mail.yahoo.com> <200410232025.57107.bruno.randolf@4g-systems.biz>
In-Reply-To: <200410232025.57107.bruno.randolf@4g-systems.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Bruno Randolf wrote:
> On Saturday 23 October 2004 19:33, Pete Popov wrote:
> 
>>>maybe not everything ist fixed in AD stepping... we
>>>have observed that on our
>>>Au1500 AD board the internal USB host only works
>>>when we set CONFIG_NONCOHERENT_IO=y.
>>
>>Is this with 2.4 or 2.6? I haven't changed the
>>coherency defaults in 2.4. 
> 
> this is with 2.4.24 and with 2.4.27
> have not tried it with 2.6 yet.

I can confirm that 2.6 fails with usb storage stress tests as well. 
Guess I should have tested something other than keyboard and mouse.

Pete
