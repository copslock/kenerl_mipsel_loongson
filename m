Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2005 05:09:48 +0100 (BST)
Received: from webadmin.ru ([IPv6:::ffff:212.119.32.46]:52235 "EHLO
	mail.webadmin.ru") by linux-mips.org with ESMTP id <S8224981AbVICEJc>;
	Sat, 3 Sep 2005 05:09:32 +0100
Received: (qmail 95432 invoked by uid 89); 3 Sep 2005 04:16:00 -0000
Received: from localhost (HELO ?192.168.1.143?) (maxim@kde.ru@127.0.0.1)
  by localhost with SMTP; 3 Sep 2005 04:15:59 -0000
Message-ID: <43192384.6010308@kde.ru>
Date:	Sat, 03 Sep 2005 08:16:04 +0400
From:	Maxim Moroz <maxim@kde.ru>
User-Agent: Mozilla Thunderbird 1.0.6-1.1am (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: framebuffer for au1000 based board.
References: <43190B15.7080301@kde.ru> <e603bacb50427983d7330a58abccb4fa@embeddedalley.com>
In-Reply-To: <e603bacb50427983d7330a58abccb4fa@embeddedalley.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <maxim@kde.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim@kde.ru
Precedence: bulk
X-list: linux-mips

Dan Malek пишет:

>
> On Sep 2, 2005, at 10:31 PM, Maxim Moroz wrote:
>
>> Hello, I'm writing framebuffer (800x600@16bpp) for au1000 based board 
>> for latest linux-2.6.13 mips kernel.
>> video memory is located at address 0xbe00_0000.
>> The problem is that I cannot correctly mmap video memory to userspace.
>
>
> What happens if you just use /dev/mem and that address?
>
>> mmap was taken from au1500 lcd framebuffer driver(code follows)
>
>
> Bad choice. Neither the Au1000 nor the Au1500 have internal frame
> buffers, so in both cases these are going to be board specific devices.
> Since the Au1500 has a PCI bridge, I suspect that driver is designed
> to work with the 36-bit address from the Au1500 core. You are going
> to have to write a custom mmap() function that does the proper mapping
> for your board design. Also, the Au1000 had some challenging bus
> interface issues to things like graphics controllers and you have to
> choose the proper memory controller configuration and hardware
> design to even have a chance at this working.
>
> Good Luck, you may have lots of work ahead of you very specific
> to your board design :-)
>
>
> -- Dan

The choice is not bad. au1000 also has 36 bit addresses.
I was toooooo bad using address 0xbe00_0000.
changed to 0x1e00_0000 and got working video.
Thanks all who made such perfect port to au1x00 processors!
Really pleased to work with them... Heh.. Tried blackfin some time ago.
that was horrible :-D

He-he, board is almost working already.

Best Regards,
Maxim Moroz.
