Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g43Ng4wJ000509
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 3 May 2002 16:42:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g43Ng4Zm000508
	for linux-mips-outgoing; Fri, 3 May 2002 16:42:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g43NfvwJ000503;
	Fri, 3 May 2002 16:41:57 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA04226;
	Fri, 3 May 2002 16:43:37 -0700
Message-ID: <3CD32044.9040109@mvista.com>
Date: Fri, 03 May 2002 16:41:56 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Fri, May 03, 2002 at 02:46:19PM -0700, Jun Sun wrote:
> 
> 
>>When running LTP, I notice that recent kernel has a kernel access fault:
>>
>><1>Unable to handle kernel paging request at virtual address 00000000, epc
>>== 80273860, ra == 80205aa4
>>
> 
> Well, decode the oops message.  The question is what is at 0x80273860?
> 


0x80273860 is copy_bytes in arch/mips/lib/memcpy.S, which is reached through __copy_user.

The faulting instruction, not suprisingly, is writing a byte to the 
destination at 0x0.

Anybody can try to call copy_to_user(0x0, ...) inside kernel and see the 
scene.  The question here is whether we should reach do_page_fault() and 
terminate calling process or try to catch the fault and return some meaningful 
error.

It appears earlier version of kernel does not have this problem.  I have not 
fully figured out why.

Jun
