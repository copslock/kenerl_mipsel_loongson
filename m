Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 15:06:56 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:60362 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20023123AbXIYOGy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 15:06:54 +0100
Received: (qmail 4800 invoked by uid 507); 25 Sep 2007 22:04:12 +0800
Received: from unknown (HELO ?127.0.0.1?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 25 Sep 2007 22:04:12 +0800
Message-ID: <46F91334.6080005@ict.ac.cn>
Date:	Tue, 25 Sep 2007 21:55:00 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: About openoffice linux/mips porting
References: <46F90261.1000003@lemote.com> <Pine.LNX.4.64N.0709251406220.23669@blysk.ds.pg.gda.pl> <46F90841.1040903@ict.ac.cn> <20070925133812.GB2333@networkno.de>
In-Reply-To: <20070925133812.GB2333@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips


>   
>>>  Hmm, why would anyone need to have asm snippets in a document processing 
>>> suite?  And it looks like the bits are ABI-dependent, so at least three 
>>> variations (if the changes are endianness-safe) would be required to 
>>> handle all the ABIs that we support.
>>>   
>>>       
>> Openoffice wants to be able to interact with plugins written in many 
>> languages, instead of writting a module for each possible combination it 
>> chooses the so called bridge: every language interact with a common middle 
>> language.
>>     
>
> So we have now foreign function interfaces for at least OpenOffice, Mozilla,
> Clisp and GCC's libffi. libffi recently got support for N32/N64 ABIs, and
> is the only solution which isn't bound to a specific application (as long
> as GCC is used).
>
> Using libffi from Openoffice looks like the best long-term approach 
> to me.
>   
Good to know the library:) 
I am not very familiar with the ABI details so the code is more or less 
only a hack to get the most part work.
Maybe the occasional crashes of our OOo are related to the bugs.
>
> Thiemo
>
>
>
>
>   
