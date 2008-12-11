Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2008 18:51:41 +0000 (GMT)
Received: from exch1.onstor.com ([66.201.51.80]:27588 "EHLO exch1.onstor.com")
	by ftp.linux-mips.org with ESMTP id S24207725AbYLKSvj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Dec 2008 18:51:39 +0000
Received: from ripper.onstor.net (10.0.0.42) by exch1.onstor.net (10.0.0.225)
 with Microsoft SMTP Server (TLS) id 8.1.311.2; Thu, 11 Dec 2008 10:51:28
 -0800
Date:	Thu, 11 Dec 2008 10:51:28 -0800
From:	Andrew Sharp <andy.sharp@onstor.com>
CC:	"linux-mips@" <linux-mips.org linux-mips@linux-mips.org>
Subject: Re: question regarding system memory whatever
Message-ID: <20081211105128.77be77d1@ripper.onstor.net>
In-Reply-To: <493D52D3.3000503@cisco.com>
References: <20081205181737.2fc890bc@ripper.onstor.net>
 <1C18506EA6ACF94097F87E8D358338F501F557@sausatlexch4.corp.sa.net>
 <493D52D3.3000503@cisco.com>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 2K3Xl1OQTInXD6xxuA8z3Q==
X-EMS-STAMP: AUdrPw4mfXrgmB5JBMH77Q==
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

Resending because list address was garbled on the first try.

On Mon, 8 Dec 2008 09:01:07 -0800 Michael Sundius <msundius@cisco.com>
wrote:

> well, attached is a patch for arch/mips/kernel/setup.c
> 
> we've done lots of other stuff to this file this but I think  this is 
> the essential
> part you need to make sure that the bootmem allocator knows
> about the memory before your kernel.
> 
> note that I  moved the call to memory_present() not for this issue but
> to make sparsemem work (though I've changed that again
> to call memory_present() from add_memory_region() since it
> seems to make more sense to call it there.
> 
> you may also want to think about using sparse memory model
> as it will likely give your ap developers even more room.

Well thanks for this, it seems pretty straight forward.  I thought
maybe there was something more nefarious preventing this from working
so I'll work it in and see how it goes.

Cheers,

a

> good luck.
> Mike
> 
> VomLehn, David wrote:
> > Er, it's kind of a good news/bad news joke...
> >
> > The bad news is that MIPS Linux isn't smart enough, at least as of
> > 2.6.24, to use memory that precedes the kernel.
> >
> > The good news is that we've got changes that will handle this.
> >
> > The bad news is that I'm so backed up even getting a basic patchset
> > to add our platform to the kernel mainline that I don't know how
> > long it will take until I'm be able to get these additional patches
> > out.
> >
> > I'll cc the guy who did the changes to see if he can extract a
> > patch for this.
> >
> >   
> >> -----Original Message-----
> >> From: linux-mips-bounce@linux-mips.org 
> >> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Andrew Sharp
> >> Sent: Friday, December 05, 2008 6:18 PM
> >> To: linux-mips@
> >> Subject: question regarding system memory whatever
> >>
> >> I recently changed plat_mem_setup() or equivalent in my platform
> >> code to not mark the first 32M of memory as BOOT_MEM_ROM_DATA and
> >> instead have the first BOOT_MEM_RAM memory region start at 0.
> >> Here is the two lines of output from mem_init() for the two
> >> different versions:
> >>
> >> Memory: 433408k/475136k available (2202k kernel code, 41556k 
> >> reserved, 690k data, 112k init, 0k highmem)
> >>
> >> Memory: 433408k/507904k available (2202k kernel code, 74324k 
> >> reserved, 689k data, 112k init, 0k highmem)
> >>
> >> As you can see, the 32M got added to "reserved" memory (?) and only
> >> added to the right hand number of the "available".  OK, so what
> >> does that mean?  I promised our monkey userspace programmers that
> >> they would have another 32M of memory to slosh around in, but
> >> before I release this change on them I'd like to know what these
> >> numbers are telling me.
> >>
> >> This is on 2.6.22 from l.m.o on a Sibyte 1125 in 64bit LE.
> >> CONFIG_FLATMEM=y which was the fashion at the time.
