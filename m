Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3HHC5p17051
	for linux-mips-outgoing; Tue, 17 Apr 2001 10:12:05 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3HHBvM17045
	for <linux-mips@oss.sgi.com>; Tue, 17 Apr 2001 10:11:59 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3HHBMj07667;
	Tue, 17 Apr 2001 14:11:22 -0300
Date: Tue, 17 Apr 2001 14:11:22 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Tom Appermont <tea@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: address translation with TLB
Message-ID: <20010417141122.D7177@bacchus.dhis.org>
References: <20010414102901.A13595@ginger.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010414102901.A13595@ginger.sonytel.be>; from tea@sonycom.com on Sat, Apr 14, 2001 at 10:29:01AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Apr 14, 2001 at 10:29:01AM +0200, Tom Appermont wrote:

> What are the things to do to use the TLB for access to otherwize
> unreachable PCI memory or IO areas? I have used the function
> add_wired_entry to add an entry to the TLB, modified the 
> functions virt_to_phys, phys_to_virt, virt_to_bus, bus_to_virt,
> and ioremap to do the translations I want, but I wonder if there
> are other things to do to get this working.

add_wired_entry is almost certainly the wrong thing to do.  It's only
recommended if you must address peripherals at physical addresses of
>= 0x100000000, that is on 64-bit machines.  32-bit addresses can
be represented in our pagetables.

> Even more so, because none of the mips boards currently in the tree seem
> to need TLB remapping.

Sane designs make sure that peripherals are at physical addresses of 512mb
or less so can be addressed through KSEG1 without using TLB entries.  So
far the only violation of this rule are the Jazz systems.

  Ralf
