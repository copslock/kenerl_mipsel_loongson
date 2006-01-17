Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 13:01:42 +0000 (GMT)
Received: from smtp101.biz.mail.re2.yahoo.com ([68.142.229.215]:21585 "HELO
	smtp101.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465570AbWAQNBZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 13:01:25 +0000
Received: (qmail 56810 invoked from network); 17 Jan 2006 13:04:56 -0000
Received: from unknown (HELO ?192.168.2.27?) (dan@embeddedalley.com@69.21.252.132 with plain)
  by smtp101.biz.mail.re2.yahoo.com with SMTP; 17 Jan 2006 13:04:56 -0000
In-Reply-To: <38dc7fce0601162308m4f721bc8l548147643df81f87@mail.gmail.com>
References: <38dc7fce0601161940s5e4375dci798f66dff58d882@mail.gmail.com> <0879ce9aeb3034e5a7634c72e445fa6b@embeddedalley.com> <38dc7fce0601162308m4f721bc8l548147643df81f87@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7be90451d50dc2abeeae2310c16d3351@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: using the 36bit physical address on AMD AU1200
Date:	Tue, 17 Jan 2006 08:04:55 -0500
To:	Youngduk Goo <ydgoo9@gmail.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jan 17, 2006, at 2:08 AM, Youngduk Goo wrote:

> After setting, I could access DM9000 with the Base address 0xD0000000.
> In here, I have some more questions.
> 1. I set the 1 TLB entry, so others does not affect the address 
> translation.
>    so Whenever I use the 0xD0000000, it always converted to 0xD 0000 
> 0000
>    on the bootloader.
>    Am I right?

Yes, looks good.

> 2. On the linux, If I want to use ioremap for Dm9000, Do I need to set 
> the TLB
>     and do not need to change the ioremap source code ?

Make sure you have CONFIG_64BIT_PHYS_ADDR configured
and you are using a recent kernel.  No changes to any code and ioremap()
will ensure the TLB is set correctly.  Just use the virtual address
returned from ioremap().


	-- Dan
