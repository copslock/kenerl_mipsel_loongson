Received:  by oss.sgi.com id <S554083AbRBTIyO>;
	Tue, 20 Feb 2001 00:54:14 -0800
Received: from mail.sonytel.be ([193.74.243.200]:22004 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553902AbRBTIxz>;
	Tue, 20 Feb 2001 00:53:55 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA23505;
	Tue, 20 Feb 2001 09:52:57 +0100 (MET)
Date:   Tue, 20 Feb 2001 09:52:53 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     ldavies@oz.agile.tv
cc:     linux-mips <linux-mips@oss.sgi.com>
Subject: Re: pci io remapping and ide_ioreg_t
In-Reply-To: <3A91F56F.9020603@agile.tv>
Message-ID: <Pine.GSO.4.10.10102200952300.4626-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 20 Feb 2001, Liam Davies wrote:
> I have an old (2.0.x) ide driver that used to hard code the 
> hwif->io_ports up to the 0x100001f0-0x100001f7 range. This is now broken 
> in the 2.4 kernel since ide_ioreg_t has changed from unsigned long to 
> unsigned short.
> 
> What is the mechanism for reaching these ports now?

Change ide_ioreg_t back to unsigned long? ide_ioreg_t is arch specific.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
