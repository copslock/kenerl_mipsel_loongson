Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8J8T2N21113
	for linux-mips-outgoing; Wed, 19 Sep 2001 01:29:02 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8J8Sse21109
	for <linux-mips@oss.sgi.com>; Wed, 19 Sep 2001 01:28:54 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id MAA08714;
	Wed, 19 Sep 2001 12:27:17 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id MAA03724; Wed, 19 Sep 2001 12:24:09 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id MAA21408; Wed, 19 Sep 2001 12:21:59 +0400 (MSD)
Message-ID: <3BA855FF.1CCD4F9@niisi.msk.ru>
Date: Wed, 19 Sep 2001 12:23:27 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com> <3B8B7ED8.D2DD9E86@niisi.msk.ru> <3B9E63A9.F2B5703C@mvista.com> <3BA5DCAC.F4E8E236@niisi.msk.ru> <3BA67B2D.604D95E5@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> > You may control pci_scan_bridge by pcibios_assign_all_busses, just
> > return 0 from the latter and the code in pci_scan_bridge assigns all
> > numbers itself.
> 
> Do you mean that we call pci_scan_brige first before scaning other devices?
> 

Yes I do. Look at drivers/pci/pci.c. The code does

for each bus (by recursion)
	scan devices on this bus
	for each bridge on this bus
		scan bridge
		scan bus behind bridge

The flow is pci_do_scan_bus -> pci_scan_bridge -> pci_do_scan_bus

> > You definitely can't mix device discovering and assignment of resources
> > in one pass a on a multi-board cPCI system.
> >
> 
> I have not given enough thought on 3), but it is certainly desirable.

Well, your previous example works here. You perform scanning of devices
and assignments in one pass. You find new device unassigned by
firmware/another CPU in cPCI system, then you need find a room in a PCI
space. You can't do that, because you don't know yet what rooms
firmware/another CPU has allocated, so you don't know what rooms are
free.

Thus, you have to scan pci in two passes. On first pass, just scan
devices and collect allocated rooms in PCI spaces. On second pass,
assign unassigned devices.

Look how Dave Miller did this for ultras in 2.2 when common pci driver
didn't do that. You have to implement more or less the same modulo
ultras hw and OBP bugs. BTW, it's exactly what current drivers/pci code
does.

> Like I said before, this is the old style of doing things.  There are many
> drawbacks in this approach.  Among them, one is to require lots of knowledge
> about PCI and how the following hookup functions are called.  Not every
> porting engineer is willing to dive into that.  There are some other problems
> too.

Sorry, your reason doesn't convince me. I believe, a porting engineer
must know hardware and operating system internals very well irrespective
of what his wishes are.

Could you explain other problems, please ? 

Regards,
Gleb.
