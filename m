Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HBiTk02206
	for linux-mips-outgoing; Mon, 17 Sep 2001 04:44:29 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HBiLe02202
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 04:44:22 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA20056;
	Mon, 17 Sep 2001 15:42:50 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA22944; Mon, 17 Sep 2001 15:42:56 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA03691; Mon, 17 Sep 2001 15:20:16 +0400 (MSD)
Message-ID: <3BA5DCAC.F4E8E236@niisi.msk.ru>
Date: Mon, 17 Sep 2001 15:21:16 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com> <3B8B7ED8.D2DD9E86@niisi.msk.ru> <3B9E63A9.F2B5703C@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun,

Jun Sun wrote:
> 
> Gleb,
> 
> Sorry to get back to this late.  I have been on a trip.
> 
> If I understand you correctly, your major argument is that "we do scan first,
> so that we can do resource assignment more easily because we have got all the
> dev structures and lists".

Yes. Also, "no code duplication".

> 
> This unfortunately may not work, mainly because the PCI bridge may not be
> setup properly so the scan results may be incomplete or invalid.

You may control pci_scan_bridge by pcibios_assign_all_busses, just
return 0 from the latter and the code in pci_scan_bridge assigns all
numbers itself.

> 
> However, I do see your point.  Actually the most desirable result might be
> that we do the resource assignement while we do the scan.
> 
> I think more and more people are realizing that bus number assignment and
> fixup must be done separately and done at the beginning.  It is a more
> complicated problem.  For example, in a multi-CPU cPCI system, you don't want
> to re-assign bus numbers unless you are the first CPU to boot up.

Thus, pcibios_assign_all_busses should just check CPU number.

> 
> pci_auto.c is not the ultimate solution.  But the nice thing is that it solves
> the broken firmware problem and yet still works with pci_scan_bus() scheme.
> 
> My personal view is that we ultimately should do something like this:
> 
> 1. do one pass scan for PCI bridges and do bus number assigment or fixup.
> 
> 2. based on the above results, we should have a uniformed access to all
> devices on all buses (such as read_pci_config(busno, ...)).
> 
> 3. do another pass of pci scan to discover pci devs and assign proper
> resources.

You definitely can't mix device discovering and assignment of resources
in one pass a on a multi-board cPCI system.

While you may implement the algorithm above, I think it isn't necessary.
Between my previous mail and your reply, I just implemented pcibios_
calls for a mips board that has 2 PCI busses with a PCI bridge between.
Yes, BIOS doesn't initialize PCI properly. 

What I had to do is just call pci_scan_bus,
pci_assign_unassigned_resources, and provide callbacks for 

- pcibios_fixup_bus (sets bus->resource[] to board private resources
describing PCI spaces for root bus and to corresponding bridge resources
for child bus. For the latter case, I had to inherit values from parent
bus also.)

- pcibios_update_resource (just write supplied value to the
configuration register)

- pcibios_fixup_pbus_ranges (convert addresses on the system bus to
addresses on PCI bus)

I also implemented registration of resources in the global resource
tree, but it's not necessary.

The only problem I observed is that PCI code treats 0 as invalid
address. It's bad but non-fatal.

> 
> BTW, I think your pcibios_assign_resources(bus) function may have already been
> implemented in the current pci code.  See pbus_assign_resources().  Those
> functions are relatively new.  I have not got time to fully digest them yet.

I had. Basically, pci_assign_unassigned_resources will do the job if
pcibios_fixup_bus will provide places for bus->resources.

Regards,
Gleb.
