Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6CITrRw010978
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 12 Jul 2002 11:29:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6CITr5x010977
	for linux-mips-outgoing; Fri, 12 Jul 2002 11:29:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6CITdRw010966;
	Fri, 12 Jul 2002 11:29:39 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA10764;
	Fri, 12 Jul 2002 11:33:41 -0700
Message-ID: <3D2F1F41.8030204@mvista.com>
Date: Fri, 12 Jul 2002 11:26:09 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@oss.sgi.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [2.4 PATCH] pcnet32.c - tx underflow error
References: <Pine.LNX.4.44.0207112350440.21590-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marcelo Tosatti wrote:

> 
> On Thu, 11 Jul 2002, Alan Cox wrote:
> 
> 
>>>This patch fixes a tx underflow error for 79c973 chip.  It essentially delay
>>>the transmission until the whole packet is received into the on-chip sdram.
>>>
>>>The patch is already accepted by Marcelo for the 2.4 tree, I think.
>>>
>>Which slows the stuff down for people with real computers. Please apply
>>some kind of heuristic to this - eg switch to delaying if you exceed
>>50 failures in a 60 second period.
>>
> 
> I haven't applied it yet.
> 
> I'll let it come to me throught Jeff Garzik after the issues are resolved.
> 


Like I said earlier, I don't believe the benefit of run-time approach is worth 
the effort.  BTW, the heuristic method is not simple, mainly because there are 
mixed bags of chips in this family which requires different handling in this 
regard.

Since Alan seems to oppose this patch, I will fix this problem for now in the 
board code/firmware, which is not a totally unreasonable solution anyway. 
After all the firmware knows this board bus cannot handle 100Mb/s net.  If 
more people report the same problem later, that might be a better time to how 
to solve this problem.


Jun
