Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f549aV127224
	for linux-mips-outgoing; Mon, 4 Jun 2001 02:36:31 -0700
Received: from hood.tvd.be (hood.tvd.be [195.162.196.21])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f549aUh27216
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 02:36:30 -0700
Received: from callisto.of.borg (cable-195-162-217-46.upc.chello.be [195.162.217.46])
	by hood.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id LAA09404;
	Mon, 4 Jun 2001 11:36:28 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id LAA28417;
	Mon, 4 Jun 2001 11:34:14 +0200
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date: Mon, 4 Jun 2001 11:34:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Florian Lohoff <flo@rfc822.org>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: wd33c93 question
In-Reply-To: <20010603154706.D4043@paradigm.rfc822.org>
Message-ID: <Pine.LNX.4.05.10106041132520.28388-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 3 Jun 2001, Florian Lohoff wrote:
> On Sat, Jun 02, 2001 at 07:07:46PM +0200, Geert Uytterhoeven wrote:
> > Anyone who can explain these changes? Here the MIPS tree differs from Linus'
> > (and the m68k) tree.
> > 
> > According to the CVS logs, this change entered in revision 1.7 due to a sync
> > with Linus' tree (which introduced other formatting changes) somewhere in 1998.
> > In Linus' tree it must have changed afterwards a long time ago (before 2.2.0).
> > 
> > --- linux-2.4.5/drivers/scsi/wd33c93.c	Tue Dec  5 21:43:48 2000
> > +++ linux-mips/drivers/scsi/wd33c93.c	Mon Mar 26 02:38:20 2001
> > @@ -614,7 +614,6 @@
> >                       (is_dir_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
> >              write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
> >           else {
> > -            write_wd33c93_count(regp, cmd->SCp.this_residual);
> >              write_wd33c93(regp,WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
> >              hostdata->dma = D_DMA_RUNNING;
> >              }
> > @@ -735,7 +734,6 @@
> >        hostdata->dma_cnt++;
> >  #endif
> >        write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
> > -      write_wd33c93_count(regp,cmd->SCp.this_residual);
> >  
> >        if ((hostdata->level2 >= L2_DATA) ||
> >            (hostdata->level2 == L2_BASIC && cmd->SCp.phase == 0)) {
> 
> I guess this is due to the fact that the HPC on the Indy/Indigo2 does
> the scatter gather alread so we let the HPC DMA controller do the scatter
> gather and just let the SCSI controller run the whole request.
> 
> The corresponding codelines should be in
> 
> drivers/scsi/sgiwd93.c

    [...]

> So we have an incompatibility with the sgiwd93.c from the mips tree
> and the wd33c93.c from the linus tree where we dont want the generic part
> of the wd33c93.c to (re)write the length of the current transfer block
> (scatter gather part) as we want it to do the whole transfer in one
> part (From the generic wd33c93.c we dont do scatter gather).

So it's OK to protect the above lines using #ifndef CONFIG_SGIWD93_SCSI?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
