Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54Co6J25390
	for linux-mips-outgoing; Mon, 4 Jun 2001 05:50:06 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54Co4h25384
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 05:50:04 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0373D7FC; Mon,  4 Jun 2001 14:50:02 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3475242D1; Mon,  4 Jun 2001 14:34:09 +0200 (CEST)
Date: Mon, 4 Jun 2001 14:34:09 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: wd33c93 question
Message-ID: <20010604143409.A11675@paradigm.rfc822.org>
References: <20010603154706.D4043@paradigm.rfc822.org> <Pine.LNX.4.05.10106041132520.28388-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.05.10106041132520.28388-100000@callisto.of.borg>; from geert@linux-m68k.org on Mon, Jun 04, 2001 at 11:34:14AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 04, 2001 at 11:34:14AM +0200, Geert Uytterhoeven wrote:
> > drivers/scsi/sgiwd93.c
> 
>     [...]
> 
> > So we have an incompatibility with the sgiwd93.c from the mips tree
> > and the wd33c93.c from the linus tree where we dont want the generic part
> > of the wd33c93.c to (re)write the length of the current transfer block
> > (scatter gather part) as we want it to do the whole transfer in one
> > part (From the generic wd33c93.c we dont do scatter gather).
> 
> So it's OK to protect the above lines using #ifndef CONFIG_SGIWD93_SCSI?

I guess so - I will have a look if thats probably the cause of
the fs corruption we see on SGIs with that scsi driver. From just guessing
the order of setting the values is different on SGI.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
