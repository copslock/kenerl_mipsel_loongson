Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HMjsT15256
	for linux-mips-outgoing; Mon, 17 Sep 2001 15:45:54 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HMjne15253
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 15:45:49 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8HMmhA02959;
	Mon, 17 Sep 2001 15:48:43 -0700
Message-ID: <3BA67B2D.604D95E5@mvista.com>
Date: Mon, 17 Sep 2001 15:37:33 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com> <3B8B7ED8.D2DD9E86@niisi.msk.ru> <3B9E63A9.F2B5703C@mvista.com> <3BA5DCAC.F4E8E236@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:
> 
> Jun,
> 
> Jun Sun wrote:
> >
> > Gleb,
> >
> > Sorry to get back to this late.  I have been on a trip.
> >
> > If I understand you correctly, your major argument is that "we do scan first,
> > so that we can do resource assignment more easily because we have got all the
> > dev structures and lists".
> 
> Yes. Also, "no code duplication".

Well, "code duplication" sometimes is not too bad when you avoid "code
bloating". :-)

> You may control pci_scan_bridge by pcibios_assign_all_busses, just
> return 0 from the latter and the code in pci_scan_bridge assigns all
> numbers itself.

Do you mean that we call pci_scan_brige first before scaning other devices?

> 
>> > pci_auto.c is not the ultimate solution.  But the nice thing is that it solves
> > the broken firmware problem and yet still works with pci_scan_bus() scheme.
> >
> > My personal view is that we ultimately should do something like this:
> >
> > 1. do one pass scan for PCI bridges and do bus number assigment or fixup.
> >
> > 2. based on the above results, we should have a uniformed access to all
> > devices on all buses (such as read_pci_config(busno, ...)).
> >
> > 3. do another pass of pci scan to discover pci devs and assign proper
> > resources.
> 
> You definitely can't mix device discovering and assignment of resources
> in one pass a on a multi-board cPCI system.
> 

I have not given enough thought on 3), but it is certainly desirable.

> While you may implement the algorithm above, I think it isn't necessary.
> Between my previous mail and your reply, I just implemented pcibios_
> calls for a mips board that has 2 PCI busses with a PCI bridge between.
> Yes, BIOS doesn't initialize PCI properly.
> 
> What I had to do is just call pci_scan_bus,
> pci_assign_unassigned_resources, and provide callbacks for
>

Like I said before, this is the old style of doing things.  There are many
drawbacks in this approach.  Among them, one is to require lots of knowledge
about PCI and how the following hookup functions are called.  Not every
porting engineer is willing to dive into that.  There are some other problems
too.
 
> - pcibios_fixup_bus (sets bus->resource[] to board private resources
> describing PCI spaces for root bus and to corresponding bridge resources
> for child bus. For the latter case, I had to inherit values from parent
> bus also.)
> 
> - pcibios_update_resource (just write supplied value to the
> configuration register)
> 
> - pcibios_fixup_pbus_ranges (convert addresses on the system bus to
> addresses on PCI bus)
> 
> I also implemented registration of resources in the global resource
> tree, but it's not necessary.
> 
> The only problem I observed is that PCI code treats 0 as invalid
> address. It's bad but non-fatal.
> 

Jun
