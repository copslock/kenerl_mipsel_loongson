Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2005 12:23:59 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:21482 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133471AbVJJLXk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2005 12:23:40 +0100
Received: (qmail 5612 invoked by uid 507); 10 Oct 2005 11:15:33 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 10 Oct 2005 11:15:33 -0000
Message-ID: <434A4F27.6010301@ict.ac.cn>
Date:	Mon, 10 Oct 2005 19:23:19 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Carlo Perassi <carlo@linux.it>, linux-mips@linux-mips.org
Subject: Re: rfc about an uncommented string
References: <20051009134106.GB9091@voyager> <20051010111149.GC2661@linux-mips.org>
In-Reply-To: <20051010111149.GC2661@linux-mips.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

We are using 8172 for 2.4 kernels presently,although may drop it
sometime later.

I don't read the 2.6 code,but it seems it remains the same as the copy
in 2.4(except that #ifdef changes).I can't see why the code is broken?
In case you mean the ioport address,mips_io_port_base for that board is
0xa0000000, inb(0x14000060) is reading from 0xb4000060, which is correct
for it.

Ralf Baechle wrote:
> On Sun, Oct 09, 2005 at 03:41:06PM +0200, Carlo Perassi wrote:
> 
> 
>>Hi.
>>As suggested (*) by Arthur Othieno on the kernel-janitors mailing list,
>>I bounce here this email for collecting comments.
>>The old email refers to 2.6.13-rc6 but the code is still the same on
>>2.6.14-rc3.
>>Thank you.
>>
>>Hi.
>>
>>I'd like to collect some comments about the following code
>>segment I found in
>>linux-2.6.13-rc6/arch/mips/ite-boards/generic/it8172_setup.c
>>(the "^^^" sequence is not mine, it's in the code)
> 
> 
> I know, I put it there.  The code was obviously broken, so I place this
> hard to miss not right into the middle of it.  It's there since ages and
> nobody did complain.  So unless somebody complains - and that complaint
> better include some patches - I will delete support for the IT8172 and
> it's eval board.
> 
>   Ralf
> 
> 
> 
