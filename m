Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 02:22:25 +0000 (GMT)
Received: from [IPv6:::ffff:159.226.39.4] ([IPv6:::ffff:159.226.39.4]:32195
	"HELO mail.ict.ac.cn") by linux-mips.org with SMTP
	id <S8225199AbTCMCWY>; Thu, 13 Mar 2003 02:22:24 +0000
Received: (qmail 24841 invoked from network); 13 Mar 2003 02:03:37 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.150)
  by 159.226.39.4 with SMTP; 13 Mar 2003 02:03:37 -0000
Message-ID: <3E709EC2.7050501@ict.ac.cn>
Date: Thu, 13 Mar 2003 10:07:46 -0500
From: Zhang Fuxin <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020809
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: Richard Hodges <rh@matriplex.com>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Ranjan Parthasarathy <ranjanp@efi.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Disabling lwl and lwr instruction generation
References: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com> <20030313014338.C29568@linux-mips.org> <Pine.BSF.4.50.0303121647400.95890-100000@mail.matriplex.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips



Richard Hodges wrote:

>On Thu, 13 Mar 2003, Ralf Baechle wrote:
>
>  
>
>>On Wed, Mar 12, 2003 at 10:05:20AM -0800, Ranjan Parthasarathy wrote:
>>
>>    
>>
>>>Is there a way to tell gcc to not generate the lwl, lwr instructions?
>>>      
>>>
>>Gcc will only ever generate these instructions when __attribute__((unaligned))
>>is used.
>>    
>>
>
>I got lwl and lwr from a memcpy() with two void pointers...
>
>I quickly changed those to the (aligned) structure pointers instead, and
>then memcpy() changed to ordinary word loads and stores.
>
>So, is somebody starting a toolchain for that new Chinese CPU? :-)
>  
>

I don't hear about it,but it will happen soon or later:)

We work around lwl/lwr problem by modifying toolchain from H.J. Lu's rh 
port.

it seems that gcc will explicitly output lwl/lwr for unaligned block 
copy,in other cases it will generate
ulW macros for gas to handle.





>-Richard
>
>
>
>  
>
