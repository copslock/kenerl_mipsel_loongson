Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 00:59:07 +0000 (GMT)
Received: from rrcs-64-183-102-11.west.biz.rr.com ([64.183.102.11]:25533 "EHLO
	jg555.com") by ftp.linux-mips.org with ESMTP id S20021869AbXCMA7D
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 00:59:03 +0000
Received: from [192.168.55.157] ([::ffff:192.168.55.157])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 12 Mar 2007 17:57:56 -0700
  id 00014011.45F5F717.000077E0
Message-ID: <45F5F709.6060707@jg555.com>
Date:	Mon, 12 Mar 2007 17:57:45 -0700
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Building 64 bit kernel on Cobalt
References: <45EB53D5.8060007@jg555.com>	 <20070304232731.GA25039@linux-mips.org> <45EFA92C.3070203@jg555.com> <cda58cb80703080448yca7fa21xb005e0685d42d318@mail.gmail.com> <45F0359A.105@jg555.com>
In-Reply-To: <45F0359A.105@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Jim Gifford wrote:
> Franck Bui-Huu wrote:
>> Hi,
>>
>> On 3/8/07, Jim Gifford <maillist@jg555.com> wrote:
>>> Ralf Baechle wrote:
>>> > On Sun, Mar 04, 2007 at 03:18:45PM -0800, Jim Gifford wrote:
>>> >
>>> >
>>> >> Last working Kernel was 2.6.19 series.
>>> >>
>>
>> It seems that I broke things again :(
>>
>>> >> Some changes from 2.6.19 and the 2.6.20 make it impossible to 
>>> build a 64
>>> >> bit kernel to boot on the cobalt. Ya, I know why, building a N32
>>> >> actually but need a 64 bit kernel in order to do that. Anyone got 
>>> any
>>> >> suggestions. Looking through the difference between the kernels to
>>> >> figure this out, but it's like looking for a needle in a 
>>> haystack. Any
>>> >> suggestions as to a starting point?
>>> >>
>>> >
>>> > Try git-bisect to track down the changeset that broke things.
>>> >
>>> >   Ralf
>>> >
>>> >
>>> We got it nailed down to arch/mips/kernel /setup.c. But we have not
>>> isolated which change is actually causing it.
>>>
>>
>> Do you use any initrd ? If so how do you pass its address to the 
>> kernel ?
> No.
>>
>> What is your kernel load address ?
> Not sure
>>
>> can you send your .config file you're using ?
> I'll send it to you later, since I'm not at the office right now.
>>
>>> We do know that reverting back to the 2.6.19.x arch/mips/kernel 
>>> /setup.c
>>> will fix the issue. We will continue to dwindle it down until we 
>>> come up
>>> with the offender.
>>>
>>>
>>
>> What did the console say ? If nothing early console may help if 
>> available.
> All I get is this
> inflate: decompressing
> elf64: 00080000 - 0037701f (ffffffff.80326000) (ffffffff.80000000)
> elf64: ffffffff.80080000 (80080000) 2957446t + 151450t
> net: interface down
>
>>
>> thanks
>
>
Frank any ideas on a solution?
