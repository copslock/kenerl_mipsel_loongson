Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3P7his22406
	for linux-mips-outgoing; Wed, 25 Apr 2001 00:43:44 -0700
Received: from mailgw1.netvision.net.il (mailgw1.netvision.net.il [194.90.1.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3P7hdM22395;
	Wed, 25 Apr 2001 00:43:40 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw1.netvision.net.il (8.9.3/8.9.3) with ESMTP id KAA17998;
	Wed, 25 Apr 2001 10:43:13 +0300 (IDT)
Message-ID: <3AE67FE8.20200@jungo.com>
Date: Wed, 25 Apr 2001 10:42:32 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: ld.so-1.9.x for mips
References: <3AE44D0A.9080003@jungo.com> <20010423170302.E4623@bacchus.dhis.org> <3AE52A87.9050403@jungo.com> <20010424012409.A17800@cyberhqz.com> <3AE53D4E.2010803@jungo.com> <20010424124946.E6256@paradigm.rfc822.org> <3AE55CA3.4050004@jungo.com> <20010424120224.D5379@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Tue, Apr 24, 2001 at 01:59:47PM +0300, Michael Shmulevich wrote:
> 
> 
>>  From this I conclude: no-one ever tried to check if ld.so works for 
>> mips ELF. Is it so?
> 
> 
> I definately won't work.

Well, I maybe overoptimistic about it, but ld.so consist of 80% C-code 
with some intrusions of #define and __asm__. I see no reason why such a 
definitive "no" should be here :-)

If someone can tell me in which register (or where) the GOT should be 
upon loading the executable and stuff like relocation types (I guess I 
can find most of them in binutils' code) then it's all fixed. I don't 
think kernels are *that* different for sparc and mips.

> 
>   Ralf


-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
