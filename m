Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2INh6813351
	for linux-mips-outgoing; Mon, 18 Mar 2002 15:43:06 -0800
Received: from smtp017.mail.yahoo.com (smtp017.mail.yahoo.com [216.136.174.114])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2INh2913348
	for <linux-mips@oss.sgi.com>; Mon, 18 Mar 2002 15:43:02 -0800
Received: from girishvg (AUTH login) at e144184.ppp.asahi-net.or.jp (HELO nazneen) (girishvg@211.13.144.184)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 18 Mar 2002 23:44:30 -0000
Message-ID: <005101c1ced7$262a9560$b8900dd3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0203181617040.5561-100000@vervain.sonytel.be>
Subject: Re: PCI VGA Card Initilization (SIS6326 / PT80)
Date: Tue, 19 Mar 2002 08:46:36 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > i have a PCI/VGA card PT80 with SIS6326 chipset. i am using MILO BIOS
source
> > code. but i am not able to access the internal buffer which is typically
at
> > 0xA0000. even the BIOS ROM (0xC0000) read fails to show default value
> > 0xA5A5. the expansion ROM is enabled in PCI by setting D0 bit to 1.
however
> > IO seems okay because the monitor actually switches from power down mode
to
> > normal mode. i have tried using both vgaraw1.c and vgaraw2.c files, but
no
> > success. could anybody help me to solve this problem.
> > many thanks.
>
> Are you using isa_readb() and friends to access ISA memory space?
> Did you set up isa_slot_offset correctly with the start address of ISA
memory
> space on your MIPS box?
no i am not using isa_readb() etc. infact i am accessing this area 0xA_0000
as Memory/IO in memory mode. i have seen the pci bus transactions, its
generating memory read and memory write commands. but due to some reason
that is still *unknown* to me generates master abort. i always get master
received master abort. could you tell me what could be the reason?


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
