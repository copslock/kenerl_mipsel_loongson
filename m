Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KIMpk17458
	for linux-mips-outgoing; Fri, 20 Jul 2001 11:22:51 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KIMmV17455
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 11:22:48 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6KHLkW08175;
	Fri, 20 Jul 2001 10:21:46 -0700
Message-ID: <3B5875E1.C7D897BE@mvista.com>
Date: Fri, 20 Jul 2001 11:18:09 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Fuxin Zhang <fxzhang@ict.ac.cn>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: help on linux-mipsel frame buffer
References: <Pine.GSO.4.21.0107181437220.10746-100000@mullein.sonytel.be>
Content-Type: text/plain; charset=iso-8859-1
X-MIME-Autoconverted: from 8bit to quoted-printable by hermes.mvista.com id f6KHLkW08175
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f6KIMmV17456
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:
> 
> On Wed, 18 Jul 2001, Fuxin Zhang wrote:
> > 2001-07-18 09:18:00£º
> > >On Tue, 17 Jul 2001, James Simmons wrote:
> > >> >   First I try the vga16 frame buffer driver,but i can only get
> > >> > some black/white strips on the screen.(after made some changes
> > >> > to the source,most important one is use pci to find and set the
> > >> > vbase address).
> > >>
> > >> It is hardwired into the vga16fb driver the memory region (0xA000). This
> > >> is very wrong on non intel platforms. So that drivers pretty much doesn't
> > >> work on anything else.
> > >
> > >Does your firmware initialize the VGA card to VGA text mode? Vga16fb requires
> > >this initialization, which is normally done by the VGA BIOS. An x86
> > >BIOS-emulator may be your friend.
> > Cound you give me a link to such a emulator?My firmware doesn't initialize VGA card.That seems the real problem.
> 
> I don't know whether it exists for Linux/MIPS yet.
> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert

FYI,  without the emulator, I have successfully run Matrox Millinium PCI card
from SGI CVS tree.  

With some patches, I have got MQ200 and Voodoo3 2000/3000 working as well.  I
don't know if any other cards work on MIPS.

For voodoo3 patch, look at http://www.medex.hu/~danthe/tdfx/.

Jun
