Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PJ4DRw023015
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 12:04:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PJ4DAv023014
	for linux-mips-outgoing; Thu, 25 Jul 2002 12:04:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PJ45Rw023004
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 12:04:05 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA10287;
	Thu, 25 Jul 2002 12:05:03 -0700
Message-ID: <3D4049D7.8090100@mvista.com>
Date: Thu, 25 Jul 2002 11:56:23 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
References: <00ce01c229a4$a7d4ed40$10eca8c0@grendel> <20020719123828.GA5521@convergence.de> <20020725162539.GA8804@convergence.de> <3D40302F.40806@mvista.com> <20020725184519.GB9302@convergence.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Johannes Stezenbach wrote:
> On Thu, Jul 25, 2002 at 10:06:55AM -0700, Jun Sun wrote:
> 
>>Johannes Stezenbach wrote:
>>
>>>sysmips:
>>>       real    1m19.358s
>>>       user    0m28.150s
>>>       sys     0m47.250s
>>>
>>>LL/SC emulation:
>>>       real    0m41.246s
>>>       user    0m25.390s
>>>       sys     0m12.240s
>>>
>>>branch-likely hack (hm, still without kernel patch...):
>>>       real    0m25.126s
>>>       user    0m17.240s
>>>       sys     0m2.310s
>>
>>Johannes,
>>
>>This is great stuff!  Can you explain what are "real", "user", and "sys"? 
>>Also, what is your initial conclusion?
> 
> 
> This are results from simple 'time ./testapp' testing, so its real time
> and user/system time reported by wait(4).
> 
> Also, I have an interactive gtk+directfb applicaton running. The
> difference in response time is quite noticable.
> 
> On reason for the big differences is that the Glib-2.0/GObject library
> does a lot of locking in its internal type system for every object
> created. Other software might not suffer as badly from a slow mutex
> implementation.
> 
> My conclusion is that it is good for glibc to always use ll/sc,
> emulated or not, and for my specific needs I will use the branch-likely
> hack. So next I will study kernel source to decide what MAGIC_COOKIE
> is best for the branch-likely hack, and where to add 'move k1,$0'
> before eret.
> 
> OTOH I doubt it's worth it to add the branch-likely hack to
> stock glibc. How many people are using Linux/MIPS on embedded
> CPU's without LL/SC?
> 

There are probably more than you think.  The popuplar (and notorious) NEC 
VR41xx family fall into this category.  I think at least one or two other 
families of CPUs are like this too.

Jun
