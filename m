Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AHM5Y06849
	for linux-mips-outgoing; Thu, 10 May 2001 10:22:05 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AHM4F06846
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 10:22:04 -0700
Received: from rose.sonytel.be (rose.sonytel.be [10.17.0.5])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id TAA03417;
	Thu, 10 May 2001 19:21:38 +0200 (MET DST)
Date: Thu, 10 May 2001 19:20:54 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Pete Popov <ppopov@mvista.com>
cc: Wayne Gowcher <wgowcher@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: Configuration of PCI Video card on a BIOS-less board
In-Reply-To: <3AFACBC8.DE85A67E@mvista.com>
Message-ID: <Pine.GSO.4.10.10105101919230.14224-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 10 May 2001, Pete Popov wrote:
> Are you really trying to assign 0xC000 0000 to the card or was that just
> an example address?  Unless your pci to memory window is such that
> there's a translation that occurs, that address is incorrect.  If the
> window is 1:1, the physical address 0xC000 0000 does not exist.  You
> need to assign the card a real physical address; if your system has 32MB
> of memory, than that address would have to be between 0 and 0x2000000. 
> (well, you can't give it address "0" because of interrupt vectors, but
> you get the point). I can point you to some examples if you have
> problems. 

If you have 32 MB of RAM and you put a PCI card at an address between 0 and
0x2000000 you'll have a problem! PCI cards must not overlap with real memory.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
