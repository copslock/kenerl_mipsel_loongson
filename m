Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8H5NWo26455
	for linux-mips-outgoing; Sun, 16 Sep 2001 22:23:32 -0700
Received: from pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8H5NQe26452
	for <linux-mips@oss.sgi.com>; Sun, 16 Sep 2001 22:23:26 -0700
Received: from pacbell.net ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GJS00A73KAZ88@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Sun, 16 Sep 2001 22:23:23 -0700 (PDT)
Date: Sun, 16 Sep 2001 22:22:53 -0700
From: Pete Popov <ppopov@pacbell.net>
Subject: Re: pcmcia (again)
To: jim@jtan.com
Cc: linux-mips@oss.sgi.com
Reply-to: ppopov@pacbell.net
Message-id: <3BA588AD.3070402@pacbell.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------080502070104090806060903
X-Accept-Language: en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010816
References: <20010917001922.A28670@neurosis.mit.edu>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------080502070104090806060903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jim Paris wrote:
> I've learned a bit since my question regarding PCMCIA, and haven't
> gotten any answers, so here's a possibly-easier-to-answer version.
> 
> My architecture has ISA memory mapped at some high address (via
> isa_slot_offset).  Turns out this isn't special; most non-x86 targets
> with ISA do it (PPC, MIPS).  So, the problem seems to boil down to the
> fact that the kernel's PCMCIA drivers simply don't support this (as
> they assume that ISA space is absolutely addressable).
> 
> Is this true, and if so, how do you guys get PCMCIA working on MIPS?
> Has anyone done it?

Yes, I did it recently for the Alchemy Au1000 eval board, the pb1000. In fact, 
just last week I added support for the ide-cs driver which allows you to use 
flash ata cards.

The Au1000 pcmcia controller is part of the SOC. There are three windows with 
fixed addresses: one that accesses pcmcia io, another for attribute memory, and 
the last for common memory. If your pcmcia controller is not one of the ones 
that linux already supports (ie, no socket driver for it), you might encounter 
problems beyond just the ones you describe above.

There is a small patch I got from a strongarm board which adds support for fixed 
memory windows controllers.  I've attached that patch in case you need it (I 
also had to make ioaddr_t a 32 bit type).  The socket driver I wrote ioremaps 
the pcmcia io space.  I have set mips_io_port_base to 0, so now when the 
inl/inb/outl/outb etc macros are used, the "offset" that is passed to them is 
actually the ioremapped address so it's a valid address.  The IO macros in the 
mips port take the "offset" passed to them and then add mips_io_port_base.  So 
the sum of the two has to be a valid address.  The socket driver passes the 
physical addresses of the attribute and common memory to the cs driver, and 
those addresses are then ioremapped at some point.

Unfortunately the client drivers make assumptions about the pcmcia windows that 
are valid for the type of pcmcia controllers used in PCs and even some PPC SOCs, 
but they are not valid for fixed window controllers. The only client driver I 
was able to use without any modifications to it is the 3COM 589 ethernet card, 
and now the ide-cs driver.  The memory-cs driver (which is not part of the 
kernel drivers anyway) does not work for me without modifying it.

One advice, stay the hell away from Xircom cards when you're testing. Apparently 
there is no documentation for them (someone correct me if I'm wrong) so they 
work mainly (and perhaps only) on x86, since that's where they were reversed 
engineered.

Pete

--------------080502070104090806060903
Content-Type: text/plain;
 name="pcmcia_fixed_io.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcmcia_fixed_io.patch"

--- stock-2.4.8/drivers/pcmcia/cs.c	Wed Jun 20 11:19:02 2001
+++ linux-mips-dev/drivers/pcmcia/cs.c	Wed Sep  5 12:51:24 2001
@@ -788,6 +788,10 @@
 	      *base, align);
 	align = 0;
     }
+    if ((s->cap.features & SS_CAP_STATIC_MAP) && s->cap.io_offset) {
+	*base = s->cap.io_offset | (*base & 0x0fff);
+	return 0;
+    }
     /* Check for an already-allocated window that must conflict with
        what was asked for.  It is a hack because it does not catch all
        potential conflicts, just the most obvious ones. */
--- stock-2.4.8/include/pcmcia/ss.h	Fri Feb 16 16:02:37 2001
+++ linux-mips-dev/include/pcmcia/ss.h	Wed Sep  5 12:25:36 2001
@@ -52,6 +52,7 @@
     u_int	features;
     u_int	irq_mask;
     u_int	map_size;
+    ioaddr_t    io_offset;
     u_char	pci_irq;
     struct pci_dev *cb_dev;
     struct bus_operations *bus;

--------------080502070104090806060903--
