Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OJSRRw006236
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 12:28:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OJSRSm006235
	for linux-mips-outgoing; Wed, 24 Jul 2002 12:28:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OJSLRw006226;
	Wed, 24 Jul 2002 12:28:21 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA04743; Wed, 24 Jul 2002 12:29:22 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA03805;
	Wed, 24 Jul 2002 12:24:17 -0700
Message-ID: <3D3EFCDE.5050503@mvista.com>
Date: Wed, 24 Jul 2002 12:15:42 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Krishna Kondaka <krishna@Sanera.net>, linux-mips@oss.sgi.com
Subject: Re: kernel BUG at slab.c:1073!
References: <200207241908.g6OJ8Yi29618@icarus.sanera.net> <20020724211414.A22828@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=1.8 required=5.0 tests=MAY_BE_FORGED,PLING version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Wed, Jul 24, 2002 at 12:08:34PM -0700, Krishna Kondaka wrote:
> 
> 
>>I don't think I am running preemptible kernel. Is there /proc file that shows
>>if I am running preemptible kernel or not?
> 
> 
> If the kernel you're running is from Broadcom it doesn't contain the
> preemption patches.  Just check your kernel .config file for
> CONFIG_PREEMPT.
> 

Or at the run-time, do "grep preempt /proc/ksyms" to see if you find any symbols.

Jun
