Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77E8jb19458
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:08:45 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77E8gV19449
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:08:42 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP
	id 886AE590AC; Tue,  7 Aug 2001 10:06:13 -0400 (EDT)
Message-ID: <088d01c11f4a$c2a5eee0$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Cc: <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0108070937380.16434-100000@mullein.sonytel.be>
Subject: Re: cross-mipsel-linux-ld --prefix library path
Date: Tue, 7 Aug 2001 10:10:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Cool.  So, what is the purpose of having both $prefix/bin/mipsel-linux-ld
and $prefix/mipsel-linux/bin/ld?

Also, why is glibc installing libraries into $prefix/lib when
mipsel-linux-ld is looking in $prefix/mipsel-linux/lib?

Regards,
Brad

----- Original Message -----
From: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
To: "Bradley D. LaRonde" <brad@ltc.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Tuesday, August 07, 2001 3:40 AM
Subject: Re: cross-mipsel-linux-ld --prefix library path


> On Mon, 6 Aug 2001, Bradley D. LaRonde wrote:
> > Another odd thing is that binutils installs:
> >
> >     /usr/mipsel-linux/bin/mipsel-linux-ld
> >
> > and an identical copy at:
> >
> >     /usr/mipsel-linux/mipsel-linux/bin/ld
> >
> > This seems like a Clue.  If fact, the whole
>
> That's normal, I have
>
> | tux$ ls -li /usr/local/bin/*ld /usr/local/*/bin/ld
> |   62976 -rwxr-xr-x    2 root     staff      946678 Jun 11 15:47
/usr/local/bin/m68k-amigaos-ld*
> |   63675 -rwxr-xr-x    2 root     staff     1356730 Mar 12 11:17
/usr/local/bin/m68k-linux-ld*
> |   63660 -rwxr-xr-x    2 root     staff     1545874 Mar 12 11:16
/usr/local/bin/powerpc-linux-ld*
> |   62976 -rwxr-xr-x    2 root     staff      946678 Jun 11 15:47
/usr/local/m68k-amigaos/bin/ld*
> |   63675 -rwxr-xr-x    2 root     staff     1356730 Mar 12 11:17
/usr/local/m68k-linux/bin/ld*
> |   63660 -rwxr-xr-x    2 root     staff     1545874 Mar 12 11:16
/usr/local/powerpc-linux/bin/ld*
> | tux$
>
> The `duplicates' are just hard links (compare the inode numbers), so they
don't waste real space (except for the directory entries :-).
>
> BTW, I used --prefix=/usr/local.
>
> Gr{oetje,eeting}s,
>
> Geert
