Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2004 07:20:50 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:57354
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224925AbUJ0GUp>;
	Wed, 27 Oct 2004 07:20:45 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9R6KeA02380;
	Tue, 26 Oct 2004 23:20:40 -0700
Message-ID: <417F3E14.8050207@embeddedalley.com>
Date: Tue, 26 Oct 2004 23:20:04 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colin <colin@realtek.com.tw>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Which MIPS kernel is good to start up? linux-mips.org or    Montavista?
References: <007801c4bb2a$9e7ded90$8b1a13ac@realtek.com.tw> <20041027031430.GC14668@linux-mips.org> <002601c4bbeb$c9ffcdf0$8b1a13ac@realtek.com.tw>
In-Reply-To: <002601c4bbeb$c9ffcdf0$8b1a13ac@realtek.com.tw>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

colin wrote:
> Dear Ralf,
> 
> 
>>The time where choosing 2.4 for new project still did make sense is over.

It may or may not be, that's not the point. You're not buying a kernel 
only when you go with a commercial distro. You're buying the entire 
cross dev environment, target packages, support, etc, etc. Figure out 
what it will cost you to support your engineers internally and maintain 
the distro yourself, research problems when you run into them, etc. If 
it's cheaper to do it internally, great. But most companies I've talked 
to that think they can do it cheaper internally are simply wrong. That's 
not to say that there's no place for "do it yourself" but weigh your 
options carefully.

Pete

> 
> 
> Why? Isn't it stable of Kernel 2.6 for MIPS?
> 
> Regards,
> Colin
> 
> ----- Original Message ----- 
> From: "Ralf Baechle" <ralf@linux-mips.org>
> To: "colin" <colin@realtek.com.tw>
> Cc: <linux-mips@linux-mips.org>
> Sent: Wednesday, October 27, 2004 11:14 AM
> Subject: Re: Which MIPS kernel is good to start up? linux-mips.org or
> Montavista?
> 
> 
> 
>>On Tue, Oct 26, 2004 at 03:08:34PM +0800, colin wrote:
>>
>>
>>>Hi all,
>>>We want to begin to put Linux to our new board with 4KEc CPU.
>>>Is it better to start porting from Montavista's Kernel, or from the one
> 
> of
> 
>>>linux-mips.org?
>>>I phoned the sales of Montavista and he told me the difference of these
> 
> 2
> 
>>>kernels are little, but their kernels have been tested a lot for
> 
> stability.
> 
>>A kernel isn't everything you'd get from Montavista; the comparison of
>>a site that's primarily geared towards development and a company that
>>is selling is probably not appropriate ...
>>
>>
>>>Naturally, we would like to choose the kernel version above 2.6.
>>
>>The time where choosing 2.4 for new project still did make sense is over.
>>
>>  Ralf
> 
> 
> 
