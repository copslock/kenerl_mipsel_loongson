Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7SBRSY19272
	for linux-mips-outgoing; Tue, 28 Aug 2001 04:27:28 -0700
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7SBR8d19266
	for <linux-mips@oss.sgi.com>; Tue, 28 Aug 2001 04:27:14 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA03790;
	Tue, 28 Aug 2001 15:27:48 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA18464; Tue, 28 Aug 2001 15:03:54 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA07911; Tue, 28 Aug 2001 15:21:59 +0400 (MSD)
Message-ID: <3B8B7ED8.D2DD9E86@niisi.msk.ru>
Date: Tue, 28 Aug 2001 15:22:00 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> Traditionally, people do the following for their PCI subsystem:
> 
> 0. PCI BIOS or firmware goes through PCI bus and assign resources
> 
> 1. PCI driver calls pci_scan_bus() to discover all the assigned resources,
> including serveral hooks for various fixups.
> 
> 2. optionally, if some PCI devices have not be assigned any device, either
> because there is no PCI BIOS or firware did not do a good job, people would
> then call pci_assign_unassigned_resources().
> 
> The new pci code is invoked between step 0 and step 1.  It totally ignore the
> current PCI resource assignment, and does a complete walk-through with new
> assignments.  Then we move on with step 1, pci_scan_bus().
> 
> Because we trust our own PCI assignment, we don't need to do step 2 anymore.
> 
> A side benefit of the new code is to allow an easy support for multiple PCI
> buses.
> 

OK. I understand what is done, bu still can't understand why it's done
in that way.
Let me explain my view on how to perform the task.

0. Firmware on most MIPS boxes don't do 0. or don't do it well. My case
is here.
I guess, pci_auto.c means others are here too. Thus, we must assign
resources properly, high level code (drivers/pci/*.c) doesn't do that.

1. After pci_scan_bus is completed, all devices are discovered, both
PBARs and _sizes_ of their windows in PCI spaces are known. Devices are
_virtually_ mapped rather at wrong places, i.e. start and end of the
resource for a PBAR contain garbage. However, at this point, no
resources are registered. (So, mapping is _virtual_ or properly
speaking, there is no mapping yet. Good. It's wrong anyway.) Resources
just sit in pci_dev structures. Thus, we can fix them by choosing right
placements.

I prefer to do it here, not earlier, because from my point of view
devices behind bridges shall be placed first. The rationales are
(A) the placement algorithm is simpler
(B) by doing this, we allocate bigger windows first, which is good.

Well, it's possible to setup proper placements either in pcibios_fixups
or in pcibios_fixup_bus, skipping bridges on primary bus and fixing them
when pcibios_fixup_bus is called for the bus behind the bridge but it's
much uglier in my taste.

The placement algorithm may be fast (just get next window) or best (try
to find most suitable room). I prefer, the best one, because, there are
less chances to exhaust PCI spaces.

Note, we don't need even touch PCI config space, we've got all we need
from high level (driver/pci/pci.c). Really, all devices are available,
their PBARs and sizes are known. (Well, in fact, we have to write proper
address in PBARs, so have to touch.)

After proper placements are chosen and PBARs is initialized we may

2. Just call pci_assign_unassigned_resources(). It automagically setups
bridges and registers our resources. That's all. 

Calling pci_assign_unassigned_resources is natural. Our firmware did bad
job, so we must  call that function. 

Anyway, if you don't call it, you have to provide its functionality
yourself duplicating the code. Most important here is that you have to
setup bridges, so the code for bridge initialization will be duplicated.

Note, we don't need to scan bus ourselves nor provide fake pci_dev
structures. What we need is just travel over the list of busses and
setup proper placements.

I think, described strategy handles multiple primary PCI buses too. At
least, I don't see a reason why it shouldn't.

In summary, pcibios_init shall
{
	for each primary bus do
		pci_scan_bus(bus)
		pcibios_assign_resources(bus)
	enddo
}

pcibios_assign_resources(theBus)
{
	for each bus behind theBus do
		pcibios_assign_resources(bus)
	enddo
	for each device on theBus do
		pcibios_assign_resources(device)
	enddo
	pci_claim_resource(theBus)
}

pcibios_assign_resources(device):
{
	for each resource in device
		get placement for resource
		change resource
		write resource->start to PBAR
		pci_claim_resource(resource)
	enddo
}

The board specific code shall provide
. ranges of PCI spaces in terms of "system bus"
. functions how to map a PCI address to corresponding kernel address and
vise versa. 
  So, something like, pci_to_virt and virt_to_pci are needed.

Add some board specific callbacks to your taste. :-)

Roughly speaking, the code is here already, just call
pciauto_assign_resources _after_ pci_scan_bus, call
pci_assign_unassigned_resources, and change fast placement algorithm to
the best one.

Any thoughts ?

Regards,
Gleb.
