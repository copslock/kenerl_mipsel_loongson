Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 22:22:50 +0100 (BST)
Received: from 205-200-7-228.static.mts.net ([IPv6:::ffff:205.200.7.228]:21256
	"EHLO librestream.com") by linux-mips.org with ESMTP
	id <S8225780AbVD1VWf> convert rfc822-to-8bit; Thu, 28 Apr 2005 22:22:35 +0100
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: iptables/vmalloc issues on alchemy
Date:	Thu, 28 Apr 2005 16:22:34 -0500
Message-ID: <8230E1CC35AF9F43839F3049E930169A137228@yang.LibreStream.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: iptables/vmalloc issues on alchemy
thread-index: AcVMNMa94lBtGCPBQHWsdaLSO1+uUQAAnZyA
From:	"Christian Gan" <christian.gan@librestream.com>
To:	"Dan Malek" <dan@embeddededge.com>
Cc:	<linux-mips@linux-mips.org>,
	"Herbert Valerio Riedel" <hvr@hvrlab.org>,
	"Josh Green" <jgreen@users.sourceforge.net>,
	"Pete Popov" <ppopov@embeddedalley.com>
Return-Path: <christian.gan@librestream.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christian.gan@librestream.com
Precedence: bulk
X-list: linux-mips

Yes "long time ago" is a very loose and relative term :).  My version at
the time was 2.6.10 (December-ish).  I was seeing very similar symptoms
to Herbert:

- loading a firmware module (for a prism 802.11b mini PCI card) through
the hotplug support would fail when using vmalloc, but not kmalloc.
- I put together a dirty tester that kept increasing page requests to
vmalloc until corruption was detected.  Again it would be okay if I used
kmalloc or if I disabled CONFIG_64BIT_PHYS_ADDR.

By the way I didn't mention but my original post was attached to that
last post of mine if people wanted to glance over it.  Unfortunately I'm
in the same boat as Dan where I don't have my setup anymore at this
time.

Christian Gan
Software Developer
LibreStream Technologies
200-55 Rothwell Road
Winnipeg, MB, Canada R3P-2M5
christian.gan@librestream.com
Ph: (204) 487-0612 x209
Fx: (204) 487-0914

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com] 
Sent: Thursday, April 28, 2005 3:57 PM
To: Christian Gan
Cc: linux-mips@linux-mips.org; Herbert Valerio Riedel; Josh Green; Pete
Popov
Subject: Re: iptables/vmalloc issues on alchemy


On Apr 28, 2005, at 4:11 PM, Christian Gan wrote:

> Could this also related to this problem I posted a long time ago?  I
> haven't had a chance to revisit things for a while...

I've just been talking about 2.6, so "long time ago" can't be
that long :-)  I have the updates to the exception handler so
the PTEs get loaded correctly, that's on the way.  I think 2.4
should be OK if anyone is using that.

The one that bothers me is this patch I've been sitting on for
quite some time.  It's not specific to Alchemy, it's a generic
MIPS page table issue.  The problem started when someone
loaded very large modules which caused a new kernel page
table to be allocated.  For some reason I don't remember,
the vmalloc_fault fixup didn't handle this, and the applications
would crash the system because their pgd page  didn't
get updated to reflect this.  The address must have been in
the vmalloc space, but I no longer have the system for testing
(but the code is running in a several thousand real products).
The only way I could make this work is to test the fault address,
the most significant bit anyway, in the TLB miss handler to
see if it was a user or kernel address.  If it was a kernel address,
I loaded the init_mm pgd instead of the thread pgd.  Just one
test and a couple of instructions, but it was necessary.  I'm
still puzzling, but will remember :-)

Thanks.


	-- Dan
