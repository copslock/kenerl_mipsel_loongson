Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 22:46:11 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:7672 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225072AbTDHVqK>;
	Tue, 8 Apr 2003 22:46:10 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h38Ljub21667;
	Tue, 8 Apr 2003 14:45:56 -0700
Date: Tue, 8 Apr 2003 14:45:56 -0700
From: Jun Sun <jsun@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Earl Mitchell <earlmips@yahoo.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: pci graphics card for malta running linux
Message-ID: <20030408144556.E6865@mvista.com>
References: <20030408175517.66121.qmail@web20708.mail.yahoo.com> <1049833899.8939.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1049833899.8939.9.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 08, 2003 at 09:31:40PM +0100
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 08, 2003 at 09:31:40PM +0100, Alan Cox wrote:
> On Maw, 2003-04-08 at 18:55, Earl Mitchell wrote:
> > Does anybody have any good reccs for PCI graphcis cards I can use with
> > Malta board running linux? Some linux device drivers assume x86. If
> > you know some PCI cards that work with linux/mips on malta let me know
> > (especially nVidia or ATI cards). Also any PCI sound cards that work
> > too. 
> 
> Nvidia and ATI cards require you run the BIOS firmware to boot them. 
> XFree86 can do that for the ATI at least. If you just need to ram 
> something into a box so you can see what is going up I'd suggest
> getting an old voodoo1/voodoo2 off ebay. They report as multimedia
> devices and the current kernel fb driver can bootstrap them from
> cold on little or big endian systems with no bios support (tested
> on parisc, x86 etc)
>

When I played with voodoo cards, I needed a different voodoo driver
for fb to work.  See http://www.medex.hu/~danthe/tdfx/.

But that patch is very outdated.  Last time when I tried with
recent 2.4 kernels, it was seriously broken.

The old faithful Matrox Millennium cards still work fine.

Steve Longerbeam has made ATI xpert98 working with non-i386 machines.
You can poke him for the patch.

Jun
