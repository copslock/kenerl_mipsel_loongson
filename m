Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4SHI5nC026623
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 28 May 2002 10:18:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4SHI5LR026622
	for linux-mips-outgoing; Tue, 28 May 2002 10:18:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4SHHxnC026619
	for <linux-mips@oss.sgi.com>; Tue, 28 May 2002 10:17:59 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA30133;
	Tue, 28 May 2002 10:17:40 -0700
Message-ID: <3CF3BB4B.504@mvista.com>
Date: Tue, 28 May 2002 10:15:55 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alexandr Andreev <andreev@niisi.msk.ru>
CC: linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
References: <3CEEBBA9.5070809@niisi.msk.ru> <3CEEAC5F.6010802@mvista.com> <3CF2A17D.6050207@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alexandr Andreev wrote:

> Jun Sun wrote:
> 
>> I took a look of the arch_get_unmapped_area(),  and it looks fine to me.
>>
>> Can you try the following changes and let me know what happens?
>>
>> 1) change COLOUR_ALIGN
>> #define COLOUR_ALIGN(addr,pgoff)     addr
> 
> 
> OK, It works for me.
> 


That indicate the logic of function works.

So the problems might lie on something else:

1) some caller pass in non-zero addr but does not check the return addr and 
assume the addr remains the same.

2) given the reported toolchain, I will double-check to see if COLOUR_ALIGN() 
is compiled correctly.  It is mildly complex.


I would be also interested to know if removing filp condition would solve your 
problem.  Nobody has explained why this condition is needed for doing 
COLOUR_ALIGN().


>>
>> We have been using gcc 2.9.5 and binutils 2.10.x for R3000 CPUs for 
>> quite a  while with no problems.  It seems newer gcc and binutiles are 
>> fine too.
>>
> I understand, but is there any __official__ recommended versions of these
> utils? http://oss.sgi.com/mips/mips-howto.html is out-of-date :(
> 


Who are the "officiers" to decide on __official__ versions? :-)  If you are 
really uncomfortable with non-official stuff, you might want to consider 
paying some vendor and I am sure you will be given an "official" version.

Jun
