Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8JIAfm01260
	for linux-mips-outgoing; Wed, 19 Sep 2001 11:10:41 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8JIAZe01253
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 11:10:35 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8JICAA31314;
	Wed, 19 Sep 2001 11:12:10 -0700
Message-ID: <3BA8DD59.C780FE46@mvista.com>
Date: Wed, 19 Sep 2001 11:00:57 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com> <3B8B7ED8.D2DD9E86@niisi.msk.ru> <3B9E63A9.F2B5703C@mvista.com> <3BA5DCAC.F4E8E236@niisi.msk.ru> <3BA67B2D.604D95E5@mvista.com> <3BA855FF.1CCD4F9@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:
> 
> Jun Sun wrote:
> > > You may control pci_scan_bridge by pcibios_assign_all_busses, just
> > > return 0 from the latter and the code in pci_scan_bridge assigns all
> > > numbers itself.
> >
> > Do you mean that we call pci_scan_brige first before scaning other devices?
> >
> 
> Yes I do. Look at drivers/pci/pci.c. The code does
> 
> for each bus (by recursion)
>         scan devices on this bus
>         for each bridge on this bus
>                 scan bridge
>                 scan bus behind bridge
> 
> The flow is pci_do_scan_bus -> pci_scan_bridge -> pci_do_scan_bus
> 
> > > You definitely can't mix device discovering and assignment of resources
> > > in one pass a on a multi-board cPCI system.
> > >
> >
> > I have not given enough thought on 3), but it is certainly desirable.
> 
> Well, your previous example works here. You perform scanning of devices
> and assignments in one pass. You find new device unassigned by
> firmware/another CPU in cPCI system, then you need find a room in a PCI
> space. You can't do that, because you don't know yet what rooms
> firmware/another CPU has allocated, so you don't know what rooms are
> free.
> 

You can if you throw away all the previous assignement done by BIOS, like
pci_auto.c approach.

> > Like I said before, this is the old style of doing things.  There are many
> > drawbacks in this approach.  Among them, one is to require lots of knowledge
> > about PCI and how the following hookup functions are called.  Not every
> > porting engineer is willing to dive into that.  There are some other problems
> > too.
> 
> Sorry, your reason doesn't convince me. I believe, a porting engineer
> must know hardware and operating system internals very well irrespective
> of what his wishes are.
> 
> Could you explain other problems, please ?

I am not actively working on PCI right now.  A couple of problems I remembered
are related to the fixup mechnisms.  If you rely on BIOS assignment, than you
cannot do fixup on a per-PCI-device basis, then you have to do fixup based on
per-device/BIOS-combo basis.

I think a couple of days ago, there was a question about the restriction of
PCI memory space being the same as CPU physical address space.  Using pci_auto
allows you to control the PCI memory region you use and deal with the
restriction more easily.

BTW, your objection seems to stem from the objection against pci_auto.  But so
far I have not seen any good reasons for not using pci_auto.  Did I miss
anything?  If pci_auto does make porting easier, is there any good reason to
go to a more difficult route?

If you compare code size, PCI auto is much much smaller than the
pci_assign_unassigned_resources().  I really don't understand what is the
complain here.

Jun
