Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f777emj13376
	for linux-mips-outgoing; Tue, 7 Aug 2001 00:40:48 -0700
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f777ekV13365
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 00:40:46 -0700
Received: from mullein.sonytel.be (mullein.sonytel.be [10.34.64.30])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA05638;
	Tue, 7 Aug 2001 09:40:19 +0200 (MET DST)
Date: Tue, 7 Aug 2001 09:40:18 +0200 (MEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
cc: linux-mips@oss.sgi.com
Subject: Re: cross-mipsel-linux-ld --prefix library path
In-Reply-To: <074001c11ef4$fdbd7530$3501010a@ltc.com>
Message-ID: <Pine.GSO.4.21.0108070937380.16434-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 6 Aug 2001, Bradley D. LaRonde wrote:
> Another odd thing is that binutils installs:
> 
>     /usr/mipsel-linux/bin/mipsel-linux-ld
> 
> and an identical copy at:
> 
>     /usr/mipsel-linux/mipsel-linux/bin/ld
> 
> This seems like a Clue.  If fact, the whole

That's normal, I have

| tux$ ls -li /usr/local/bin/*ld /usr/local/*/bin/ld
|   62976 -rwxr-xr-x    2 root     staff      946678 Jun 11 15:47 /usr/local/bin/m68k-amigaos-ld*
|   63675 -rwxr-xr-x    2 root     staff     1356730 Mar 12 11:17 /usr/local/bin/m68k-linux-ld*
|   63660 -rwxr-xr-x    2 root     staff     1545874 Mar 12 11:16 /usr/local/bin/powerpc-linux-ld*
|   62976 -rwxr-xr-x    2 root     staff      946678 Jun 11 15:47 /usr/local/m68k-amigaos/bin/ld*
|   63675 -rwxr-xr-x    2 root     staff     1356730 Mar 12 11:17 /usr/local/m68k-linux/bin/ld*
|   63660 -rwxr-xr-x    2 root     staff     1545874 Mar 12 11:16 /usr/local/powerpc-linux/bin/ld*
| tux$ 

The `duplicates' are just hard links (compare the inode numbers), so they don't waste real space (except for the directory entries :-).

BTW, I used --prefix=/usr/local.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
