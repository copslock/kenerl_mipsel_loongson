Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6ICbpT01365
	for linux-mips-outgoing; Wed, 18 Jul 2001 05:37:51 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6ICbnV01361
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 05:37:50 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id OAA18560;
	Wed, 18 Jul 2001 14:37:43 +0200 (MET DST)
Date: Wed, 18 Jul 2001 14:37:43 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: help on linux-mipsel frame buffer
In-Reply-To: <200107181154.NAA16473@mail.sonytel.be>
Message-ID: <Pine.GSO.4.21.0107181437220.10746-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
X-MIME-Autoconverted: from 8bit to quoted-printable by mail.sonytel.be id OAA18560
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f6ICbpV01363
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 18 Jul 2001, Fuxin Zhang wrote:
> 2001-07-18 09:18:00£º
> >On Tue, 17 Jul 2001, James Simmons wrote:
> >> >   First I try the vga16 frame buffer driver,but i can only get
> >> > some black/white strips on the screen.(after made some changes
> >> > to the source,most important one is use pci to find and set the
> >> > vbase address).
> >>
> >> It is hardwired into the vga16fb driver the memory region (0xA000). This
> >> is very wrong on non intel platforms. So that drivers pretty much doesn't
> >> work on anything else.
> >
> >Does your firmware initialize the VGA card to VGA text mode? Vga16fb requires
> >this initialization, which is normally done by the VGA BIOS. An x86
> >BIOS-emulator may be your friend.
> Cound you give me a link to such a emulator?My firmware doesn't initialize VGA card.That seems the real problem.

I don't know whether it exists for Linux/MIPS yet.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
