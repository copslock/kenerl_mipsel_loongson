Received:  by oss.sgi.com id <S553855AbRBFGeU>;
	Mon, 5 Feb 2001 22:34:20 -0800
Received: from mail.sonytel.be ([193.74.243.200]:41390 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553792AbRBFGd5>;
	Mon, 5 Feb 2001 22:33:57 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA06451;
	Tue, 6 Feb 2001 07:32:53 +0100 (MET)
Date:   Tue, 6 Feb 2001 07:32:53 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Kenneth C Barr <kbarr@MIT.EDU>
cc:     linux-mips@oss.sgi.com
Subject: Re: netbooting indy - update, elf2ecoff?
In-Reply-To: <Pine.SGI.4.30L.0102051604550.234337-100000@w20-575-66.mit.edu>
Message-ID: <Pine.GSO.4.10.10102060732080.15534-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 5 Feb 2001, Kenneth C Barr wrote:
> Question: As the vmlinux-indy-2.2.1-990226.ecoff kernel begins the boot
> sequence, it hangs at "unable to open initial console."  I had unpacked
> the filesystem on linux as the FAQ suggests, and my device files look
> right.  So, on the NFS server, I symlinked /dev/console to /dev/ttyS0.
> Now the message is replaced with a cryptic: "S<<<<<"

However, /dev/console must _not_ be a symlink, but a character special device
with major 5 minor 1 (cfr. Documentation/devices.txt).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
