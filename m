Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8BJgt623251
	for linux-mips-outgoing; Tue, 11 Sep 2001 12:42:55 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8BJgid23248
	for <linux-mips@oss.sgi.com>; Tue, 11 Sep 2001 12:42:44 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09603
	for <linux-mips@oss.sgi.com>; Tue, 11 Sep 2001 12:42:40 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8BJU7A19906;
	Tue, 11 Sep 2001 12:30:07 -0700
Message-ID: <3B9E63A9.F2B5703C@mvista.com>
Date: Tue, 11 Sep 2001 12:19:05 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com> <3B8B7ED8.D2DD9E86@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Gleb,

Sorry to get back to this late.  I have been on a trip.

If I understand you correctly, your major argument is that "we do scan first,
so that we can do resource assignment more easily because we have got all the
dev structures and lists".

This unfortunately may not work, mainly because the PCI bridge may not be
setup properly so the scan results may be incomplete or invalid.

However, I do see your point.  Actually the most desirable result might be
that we do the resource assignement while we do the scan.

I think more and more people are realizing that bus number assignment and
fixup must be done separately and done at the beginning.  It is a more
complicated problem.  For example, in a multi-CPU cPCI system, you don't want
to re-assign bus numbers unless you are the first CPU to boot up.

pci_auto.c is not the ultimate solution.  But the nice thing is that it solves
the broken firmware problem and yet still works with pci_scan_bus() scheme.

My personal view is that we ultimately should do something like this:

1. do one pass scan for PCI bridges and do bus number assigment or fixup.

2. based on the above results, we should have a uniformed access to all
devices on all buses (such as read_pci_config(busno, ...)).

3. do another pass of pci scan to discover pci devs and assign proper
resources.

Note currently we have constraints that physical address space is the same as
PCI memory space and multiple PCI addr spaces are usually collapsed into a
single flat space.  We really should remove those constraints so that we can
utilize the full PCI space which is rather abundant for today's systems.

BTW, I think your pcibios_assign_resources(bus) function may have already been
implemented in the current pci code.  See pbus_assign_resources().  Those
functions are relatively new.  I have not got time to fully digest them yet.


Jun

"Gleb O. Raiko" wrote:
> 
> Jun Sun wrote:
> > Traditionally, people do the following for their PCI subsystem:
> >
> > 0. PCI BIOS or firmware goes through PCI bus and assign resources
> >
> > 1. PCI driver calls pci_scan_bus() to discover all the assigned resources,
> > including serveral hooks for various fixups.
> >
> > 2. optionally, if some PCI devices have not be assigned any device, either
> > because there is no PCI BIOS or firware did not do a good job, people would
> > then call pci_assign_unassigned_resources().
> >
> > The new pci code is invoked between step 0 and step 1.  It totally ignore the
> > current PCI resource assignment, and does a complete walk-through with new
> > assignments.  Then we move on with step 1, pci_scan_bus().
> >
> > Because we trust our own PCI assignment, we don't need to do step 2 anymore.
> >
> > A side benefit of the new code is to allow an easy support for multiple PCI
> > buses.
> >
> 
> OK. I understand what is done, bu still can't understand why it's done
> in that way.
> Let me explain my view on how to perform the task.
> 
> 0. Firmware on most MIPS boxes don't do 0. or don't do it well. My case
> is here.
> I guess, pci_auto.c means others are here too. Thus, we must assign
> resources properly, high level code (drivers/pci/*.c) doesn't do that.
> 
> 1. After pci_scan_bus is completed, all devices are discovered, both
> PBARs and _sizes_ of their windows in PCI spaces are known. Devices are
> _virtually_ mapped rather at wrong places, i.e. start and end of the
> resource for a PBAR contain garbage. However, at this point, no
> resources are registered. (So, mapping is _virtual_ or properly
> speaking, there is no mapping yet. Good. It's wrong anyway.) Resources
> just sit in pci_dev structures. Thus, we can fix them by choosing right
> placements.
> 
> I prefer to do it here, not earlier, because from my point of view
> devices behind bridges shall be placed first. The rationales are
> (A) the placement algorithm is simpler
> (B) by doing this, we allocate bigger windows first, which is good.
> 
> Well, it's possible to setup proper placements either in pcibios_fixups
> or in pcibios_fixup_bus, skipping bridges on primary bus and fixing them
> when pcibios_fixup_bus is called for the bus behind the bridge but it's
> much uglier in my taste.
> 
> The placement algorithm may be fast (just get next window) or best (try
> to find most suitable room). I prefer, the best one, because, there are
> less chances to exhaust PCI spaces.
> 
> Note, we don't need even touch PCI config space, we've got all we need
> from high level (driver/pci/pci.c). Really, all devices are available,
> their PBARs and sizes are known. (Well, in fact, we have to write proper
> address in PBARs, so have to touch.)
> 
> After proper placements are chosen and PBARs is initialized we may
> 
> 2. Just call pci_assign_unassigned_resources(). It automagically setups
> bridges and registers our resources. That's all.
> 
> Calling pci_assign_unassigned_resources is natural. Our firmware did bad
> job, so we must  call that function.
> 
> Anyway, if you don't call it, you have to provide its functionality
> yourself duplicating the code. Most important here is that you have to
> setup bridges, so the code for bridge initialization will be duplicated.
> 
> Note, we don't need to scan bus ourselves nor provide fake pci_dev
> structures. What we need is just travel over the list of busses and
> setup proper placements.
> 
> I think, described strategy handles multiple primary PCI buses too. At
> least, I don't see a reason why it shouldn't.
> 
> In summary, pcibios_init shall
> {
>         for each primary bus do
>                 pci_scan_bus(bus)
>                 pcibios_assign_resources(bus)
>         enddo
> }
> 
> pcibios_assign_resources(theBus)
> {
>         for each bus behind theBus do
>                 pcibios_assign_resources(bus)
>         enddo
>         for each device on theBus do
>                 pcibios_assign_resources(device)
>         enddo
>         pci_claim_resource(theBus)
> }
> 
> pcibios_assign_resources(device):
> {
>         for each resource in device
>                 get placement for resource
>                 change resource
>                 write resource->start to PBAR
>                 pci_claim_resource(resource)
>         enddo
> }
> 
> The board specific code shall provide
> . ranges of PCI spaces in terms of "system bus"
> . functions how to map a PCI address to corresponding kernel address and
> vise versa.
>   So, something like, pci_to_virt and virt_to_pci are needed.
> 
> Add some board specific callbacks to your taste. :-)
> 
> Roughly speaking, the code is here already, just call
> pciauto_assign_resources _after_ pci_scan_bus, call
> pci_assign_unassigned_resources, and change fast placement algorithm to
> the best one.
> 
> Any thoughts ?
> 
> Regards,
> Gleb.
