Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OIajRw004737
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 11:36:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OIajCQ004736
	for linux-mips-outgoing; Wed, 24 Jul 2002 11:36:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OIafRw004727
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 11:36:41 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA07787
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 11:37:43 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA02060;
	Wed, 24 Jul 2002 11:32:30 -0700
Message-ID: <3D3EF0BD.6080508@mvista.com>
Date: Wed, 24 Jul 2002 11:23:57 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Zajerko-McKee <nmckee@telogy.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Question about generic\time.c 2.4.17
References: <1027461913.4699.26.camel@gtlinuxserver1.telogy.design.ti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=1.3 required=5.0 tests=MAY_BE_FORGED version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Nick Zajerko-McKee wrote:
> Hi,
> 
> I'm working on a new 4Kc platform and was looking at the
> arch\mips\mips-boards\generic\time.c sources.  Can someone explain to me
> the function of do_fast_gettimeoffset(), especially the do_div64_32()
> assembler routine?  One of the requirements I have will be not modify
> the timer resolution for my platform to something in the msec range w/o
> disturbing the underlying jiffie setup found in linux.
> 

do_div64_32() emulate 64bit division with 32bit registers/values. 
do_fast_gettimeoffset() gives the intra-jiffy time offset, which yields higher 
timer resolution.

Take a look of /Documentation/mips/time.README.

Jun
