Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8I41Yx21050
	for linux-mips-outgoing; Mon, 17 Sep 2001 21:01:34 -0700
Received: from pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8I41Te21047
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 21:01:29 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GJU00EAHB6G0P@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Mon, 17 Sep 2001 21:01:29 -0700 (PDT)
Date: Mon, 17 Sep 2001 21:00:58 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: pcmcia (again)
To: jim@jtan.com
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3BA6C6FA.7070309@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010816
References: <20010917001922.A28670@neurosis.mit.edu>
 <3BA588AD.3070402@pacbell.net> <20010917123106.A396@neurosis.mit.edu>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jim Paris wrote:
> Thanks for your reply.
> 
> 
>>If your pcmcia
>>controller is not one of the ones that linux already supports (ie,
>>no socket driver for it), you might encounter problems beyond just
>>the ones you describe above.
>>
> 
> My PCMCIA controller is an i82365-compatible VG-469.  The driver for
> that works; there are some linux-vr specific modifications to it that
> allow it to work with remapped interrupts.
> 
> The I/O port mapping also seems to work fine, as the controller is
> detected and it has no trouble seeing when cards are inserted.
> 
> The problem comes in with cs.c; it doesn't seem to know about the
> ISA memory remapping:
> 
> cs: IO port probe 0x0100-0x04ff: excluding 0x100-0x107
> initializing socket 0
> cs: memory probe 0x0d0000-0x0dffff: excluding 0xd0000-0xdffff
> cs: memory probe 0x0c0000-0x0cffff: excluding 0xc0000-0xcffff
> cs: unable to map card memory!
> cs: unable to map card memory!
> initializing socket 1
> cs: unable to map card memory!
> cs: unable to map card memory!
> 
> And, from my inspection of the code, this seems to be caused by the
> fact that it assumes that if it's ISA, the memory is mapped to
> absolute address 0; rsrc_mgr.c excludes those memory regions and fails
> to find available ISA memory space because the kernel already has
> 0x000000-0xffffff allocated to system RAM.
> 
> Am I misunderstanding something here?  Is there some simple way to get
> the PCMCIA driver to use isa_slot_offset when checking and
> requesting memory regions?  I tried adding that offset to the
> check_mem_resource, request_mem_region, and release_mem_region calls,
> and changing all of the readx/writex() calls to isa_readx/isa_writex(),
> but things still don't work right.

Are ioport_resource.{start,end} and iomem_resource.{start,end} set correctly?
Perhaps you haven't set those up and the requests are failing.


Pete
