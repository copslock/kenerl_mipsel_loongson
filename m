Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OIOSe20567
	for linux-mips-outgoing; Fri, 24 Aug 2001 11:24:28 -0700
Received: from dea.linux-mips.net (u-73-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.73])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OIOPd20563
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 11:24:25 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7OIKbm09860;
	Fri, 24 Aug 2001 20:20:37 +0200
Date: Fri, 24 Aug 2001 20:20:37 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/pci* stuff
Message-ID: <20010824202037.A9819@dea.linux-mips.net>
References: <3B862487.EF22D143@niisi.msk.ru> <3B869596.CBDBC20D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B869596.CBDBC20D@mvista.com>; from jsun@mvista.com on Fri, Aug 24, 2001 at 10:57:42AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 24, 2001 at 10:57:42AM -0700, Jun Sun wrote:

> A side benefit of the new code is to allow an easy support for multiple PCI
> buses.

Multiple PCI busses were already working fine in the old code, see for
example Origin.  We just were not doing the full address space layout
ourselfes but 32-bit mips wasn't either.

  Ralf
