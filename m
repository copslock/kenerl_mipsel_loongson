Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OI3xa20034
	for linux-mips-outgoing; Fri, 24 Aug 2001 11:03:59 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OI3ud20029
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 11:03:56 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7OI8JA28120;
	Fri, 24 Aug 2001 11:08:19 -0700
Message-ID: <3B869596.CBDBC20D@mvista.com>
Date: Fri, 24 Aug 2001 10:57:42 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:
> 
> Hello,
> 
> Could somebody, please, explain me what arch/mips/pci* stuff is for? My
> understanding is drivers/pci code shall setup everything except proper
> placing in PCI MEM/IO spaces and irqs. The code in arch/mips/pci*
> contains much more.
> 
> Anyway, drivers/pci code provides enough fixup interface, doesn't it ?
> 
> BTW, if the code in arch/mips/pci* is really required how about
> fine-grained placing, like in sparc64?
> 
> Regards,
> Gleb.

Traditionally, people do the following for their PCI subsystem:

0. PCI BIOS or firmware goes through PCI bus and assign resources

1. PCI driver calls pci_scan_bus() to discover all the assigned resources,
including serveral hooks for various fixups.

2. optionally, if some PCI devices have not be assigned any device, either
because there is no PCI BIOS or firware did not do a good job, people would
then call pci_assign_unassigned_resources().

The new pci code is invoked between step 0 and step 1.  It totally ignore the
current PCI resource assignment, and does a complete walk-through with new
assignments.  Then we move on with step 1, pci_scan_bus().

Because we trust our own PCI assignment, we don't need to do step 2 anymore.

A side benefit of the new code is to allow an easy support for multiple PCI
buses.

Jun
