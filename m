Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48EWwwJ029761
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 07:32:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48EWwHF029760
	for linux-mips-outgoing; Wed, 8 May 2002 07:32:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48EWrwJ029755
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 07:32:54 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA05784;
	Wed, 8 May 2002 16:32:37 +0200 (MET DST)
Date: Wed, 8 May 2002 16:32:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Szabo Attila <trial@ugyvitelszolgaltato.hu>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: indy scsi
In-Reply-To: <E175RdX-0001aT-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0205081631510.20512-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 8 May 2002, Alan Cox wrote:
> > Yes, I know all of that, and I've expected only max 3-5 MB/sec but not
> > 1.7.
> > The scsi bandwith on indy is 10MB/s, the disk is above 10 MB/s.
> > Maybe I expect too much
> 
> An old 2Gb 5400 RPM drive ought to deliver about 2Mbytes/second data rates.
> The 1.7 sounds suprisingly low unless the driver code doesn't support 
> disconnect and scsi2 tagged stuff. For an old NCR538x/9x device without
> those it sounds all too believable.

Doesn't the Indy have a wd33c93, like the Amiga 3000? If yes, 1.7 MiB/s is
indeed quite low.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
