Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6PMBRB05745
	for linux-mips-outgoing; Wed, 25 Jul 2001 15:11:27 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6PMBPO05741
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 15:11:25 -0700
Received: from ayrnetworks.com (IDENT:phil@bagpipe.ayrnetworks.com [10.1.1.149])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6PMA7r16209;
	Wed, 25 Jul 2001 15:10:07 -0700
Message-ID: <3B5F43EC.2B03E744@ayrnetworks.com>
Date: Wed, 25 Jul 2001 15:10:52 -0700
From: Phil Hopely <phil@ayrnetworks.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "John D. Davis" <johnd@stanford.edu>
CC: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Replacing the Console driver
References: <Pine.GSO.4.31.0107251427180.21227-100000@myth1.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I do not know if you have examined any of the current open source emulation
projects that exist, but I believe
you might be interested to examine www.mame.net or mess.emuverse.com?

They have a cpu core for mips emulation, I believe it may only be r3000
though?..

Also, there exist numerous open-source playstation emulators, which I believe
are r3000 based too...

The mame & mess projects are matured open-source projects that have been ported
across the universe, they're really pretty cool, this work would be a likely fit
with the mess project.

If you implement by way of pure emulation, you'd not need to change the kernel
at all?

Phil

"John D. Davis" wrote:

> I am modifying the linux kernel to be able to be run by a simulator.  I
> need to modify the console driver and interrupt handler.  I have been
> going through the various files, console.*, tty.* and the serial files to
> see how to interface to the console.  I have also read some kernel korner
> articles, but they seem a little out of date.  Is there any other
> recommended documentation on the console driver and how it works on an
> indy? I am trying to sort out the low-level interfaces from the
> higher-level ones.  I just need to change the low-level interface from
> using the hardware to using the simulator interface.
>
> thanks,
> john
>
> --
> To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
