Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OHUcZ19218
	for linux-mips-outgoing; Fri, 24 Aug 2001 10:30:38 -0700
Received: from dea.linux-mips.net (u-73-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.73])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OHUYd19208
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 10:30:35 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7ODXZN00969;
	Fri, 24 Aug 2001 15:33:35 +0200
Date: Fri, 24 Aug 2001 15:33:35 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
Message-ID: <20010824153335.A948@dea.linux-mips.net>
References: <3B862487.EF22D143@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B862487.EF22D143@niisi.msk.ru>; from raiko@niisi.msk.ru on Fri, Aug 24, 2001 at 01:55:19PM +0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 24, 2001 at 01:55:19PM +0400, Gleb O. Raiko wrote:

> Could somebody, please, explain me what arch/mips/pci* stuff is for? My
> understanding is drivers/pci code shall setup everything except proper
> placing in PCI MEM/IO spaces and irqs. The code in arch/mips/pci*
> contains much more.
> 
> Anyway, drivers/pci code provides enough fixup interface, doesn't it ?
> 
> BTW, if the code in arch/mips/pci* is really required how about
> fine-grained placing, like in sparc64?

Drivers/pci/ does no full initialization of PCI busses which is necessary
on some systems where the firmware doesn't.  The code in the kernel tree
isn't yet complete; I still have two patches left to merge.

  Ralf
