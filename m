Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g46NA1wJ030558
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 6 May 2002 16:10:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g46NA1Ou030557
	for linux-mips-outgoing; Mon, 6 May 2002 16:10:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from guest ([66.89.142.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g46N9vwJ030520
	for <linux-mips@oss.sgi.com>; Mon, 6 May 2002 16:09:58 -0700
Received: (from ralf@localhost)
	by guest (8.11.6/8.11.6) id g468BB810652;
	Mon, 6 May 2002 16:11:11 +0800
Date: Mon, 6 May 2002 16:11:10 +0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: RM200 big endian prom ?
Message-ID: <20020506161110.A10422@guest.intrengr>
References: <20020506102732.GC27584@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020506102732.GC27584@paradigm.rfc822.org>; from flo@rfc822.org on Mon, May 06, 2002 at 12:27:32PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 06, 2002 at 12:27:32PM +0200, Florian Lohoff wrote:

> i yesterday had a try booting my RM200 (Big Endian Sinix firmware)
> with a big endian compiled kernel - It immediatly crashes in ArcWrite
> as the Bios is not an Arc (Probably a bit similar).
> 
> Does anyone have interesting informations about that prom ?
> 
> BTW: There are really some funny lines in arc/init.c :)
> 
> arch/mips/arc/init.c
>      36         if (pb->magic != 0x53435241) {
>      37                 prom_printf("Aieee, bad prom vector magic %08lx\n", pb->magic);
>      38                 while(1)
>      39                         ;
>      40         }
>      41 
> 
> Calling ArcWrite in case of no Arc ;) At least one knows what happens
> if the Firmware is giving out EPC Faulting address (Which in this case
> is 0x6c)

So far the assumption is that SNI's firmware is lookling like ARCS which is
basically a big endian abortion of ARC.  Alternativly it might as well
look similar to the firmware of the old MIPS workstations such as the
RC3230 or similar.

I wonder if the the magic just needs to be endianess swapped?

  Ralf
