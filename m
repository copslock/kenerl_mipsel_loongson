Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8I77Js23700
	for linux-mips-outgoing; Tue, 18 Sep 2001 00:07:19 -0700
Received: from pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8I77Fe23689
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 00:07:15 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GJU00M4XJS2PX@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 18 Sep 2001 00:07:15 -0700 (PDT)
Date: Tue, 18 Sep 2001 00:06:44 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: pcmcia (again)
To: jim@jtan.com
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3BA6F284.50506@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010816
References: <20010917001922.A28670@neurosis.mit.edu>
 <3BA588AD.3070402@pacbell.net> <20010917123106.A396@neurosis.mit.edu>
 <3BA6C6FA.7070309@pacbell.net> <20010918024814.A6517@neurosis.mit.edu>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
>>>Am I misunderstanding something here?  Is there some simple way to get
>>>the PCMCIA driver to use isa_slot_offset when checking and
>>>requesting memory regions?  I tried adding that offset to the
>>>check_mem_resource, request_mem_region, and release_mem_region calls,
>>>and changing all of the readx/writex() calls to isa_readx/isa_writex(),
>>>but things still don't work right.
>>>
> 
> .. 
> 
> Success!!
> 
> The main problem was that I had subtly broken the ioremap function
> while trying to update the linux-vr tree to 2.4.5ish.  Doh!
> 
> A second problem is that the pcmcia drivers needed to add
> isa_slot_offset when calling {check,request,release}_mem_region
> -- but the readx/writex calls do _not_ need this offset added.
> (So this must be handled by the ioremap.  I still don't fully
> understand when or where this remapping is done, but I know it's
> happening.)
> 
> And it works!
> 
> This means that I now have a working 2.4.5 kernel on my Mobilon Tripad
> (aka Vadem Clio) with a functional compact flash and wireless ethernet
> card.  I'm quite happy.  Now I just need to build some binaries.
> 
> Pete, thanks for your help; it pointed me in the right direction.
> 
Good to hear that you found the problems.  If your patch to use isa_slot_offset 
doesn't get accepted, you might want to try to figure out if there's any way to 
limit your changes to your board's specific files. That way you won't have to 
carry patches around from one kernel version to another. I think this is now the 
second mips board with pcmcia support.

BTW, I have a LE ramdisk which runs linuxrc, loads pcmcia drivers, starts 
cardmgr, and exits. The kernel then mounts the real root fs which is /dev/hda1 
in my case (pcmcia ata card).  Let me know if you need it.

Pete
