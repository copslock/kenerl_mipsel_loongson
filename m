Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 09:51:35 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:24582
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225792AbUDUIvb>; Wed, 21 Apr 2004 09:51:31 +0100
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.11.7/8.11.7) with ESMTP id i3L7q1R05544;
	Wed, 21 Apr 2004 11:52:01 +0400
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id i3L8msFi030726;
	Wed, 21 Apr 2004 12:48:54 +0400
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id i3L8msQY030724;
	Wed, 21 Apr 2004 12:48:54 +0400
Received: from niisi.msk.ru (aa01 [172.16.0.1])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id i3L8oTfX023432;
	Wed, 21 Apr 2004 12:50:30 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id i3L8oRtH028167;
	Wed, 21 Apr 2004 12:50:28 +0400 (MSK)
Message-ID: <408636EA.3004C913@niisi.msk.ru>
Date: Wed, 21 Apr 2004 12:55:06 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20040420163230Z8225288-1530+99@linux-mips.org> <20040420105116.C22846@mvista.com> <20040420201128.GC24025@linux-mips.org> <20040420153108.F22846@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-Scanned-By: milter-spamc/0.13.216 (aa19 [172.16.0.19]); Wed, 21 Apr 2004 12:50:30 +0400
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:
> 
> Has anybody succssfully used pci_assign_unassigned_resources() in latest 2.4?
> It was badly broken in early 2.4 kernels while pci_auto was the only
> option.

In fact, I have used pci_assign_unassigned_resources() from early 2.4
days. The only code I had to supply was
fixup of PCI-PCI bridge spaces which was done in pcibios_fixup_bus,
something like
        if(!bus->self) /* Primary busses */
                bus->resource[0] = &ioport_resource;
                bus->resource[1] = &iomem_resource;
	else /* busses behind PCI-PCI bridges */
	    for IO, MEM, and PREFETCH spaces:
                bus->resource[i] =
&bus->self->resource[PCI_BRIDGE_RESOURCES+i];
                bus->resource[i]->start =
bus->parent->resource[i]->start;
                bus->resource[i]->end   = bus->parent->resource[i]->end;
                bus->resource[i]->flags =
bus->parent->resource[i]->flags;
                bus->resource[i]->name  = bus->name;


Ah, I had to disable ISA mapping in 2.4.25.

After that, pci_assign_unassigned_resources() assigns all resources
properly. If for some reason, you have to preserve PBAR's values
assigned by a BIOS, setup pci_dev.resource[].parent before invoking
pci_assign_unassigned_resources.
> 
> So at most you can only say "pci_assign_unassigned_resources() can
> finally does what pci_auto does". :)

Exactly.

Regards,
Gleb.
