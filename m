Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f53DlHL24314
	for linux-mips-outgoing; Sun, 3 Jun 2001 06:47:17 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f53DlFh24311
	for <linux-mips@oss.sgi.com>; Sun, 3 Jun 2001 06:47:16 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B6F987FE; Sun,  3 Jun 2001 15:47:13 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C9C5642D1; Sun,  3 Jun 2001 15:47:07 +0200 (CEST)
Date: Sun, 3 Jun 2001 15:47:07 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: wd33c93 question
Message-ID: <20010603154706.D4043@paradigm.rfc822.org>
References: <Pine.LNX.4.05.10106021901200.23007-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.05.10106021901200.23007-100000@callisto.of.borg>; from geert@linux-m68k.org on Sat, Jun 02, 2001 at 07:07:46PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 02, 2001 at 07:07:46PM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> Anyone who can explain these changes? Here the MIPS tree differs from Linus'
> (and the m68k) tree.
> 
> According to the CVS logs, this change entered in revision 1.7 due to a sync
> with Linus' tree (which introduced other formatting changes) somewhere in 1998.
> In Linus' tree it must have changed afterwards a long time ago (before 2.2.0).
> 
> --- linux-2.4.5/drivers/scsi/wd33c93.c	Tue Dec  5 21:43:48 2000
> +++ linux-mips/drivers/scsi/wd33c93.c	Mon Mar 26 02:38:20 2001
> @@ -614,7 +614,6 @@
>                       (is_dir_out(cmd))?DATA_OUT_DIR:DATA_IN_DIR))
>              write_wd33c93_count(regp,0); /* guarantee a DATA_PHASE interrupt */
>           else {
> -            write_wd33c93_count(regp, cmd->SCp.this_residual);
>              write_wd33c93(regp,WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
>              hostdata->dma = D_DMA_RUNNING;
>              }
> @@ -735,7 +734,6 @@
>        hostdata->dma_cnt++;
>  #endif
>        write_wd33c93(regp, WD_CONTROL, CTRL_IDI | CTRL_EDI | CTRL_DMA);
> -      write_wd33c93_count(regp,cmd->SCp.this_residual);
>  
>        if ((hostdata->level2 >= L2_DATA) ||
>            (hostdata->level2 == L2_BASIC && cmd->SCp.phase == 0)) {

I guess this is due to the fact that the HPC on the Indy/Indigo2 does
the scatter gather alread so we let the HPC DMA controller do the scatter
gather and just let the SCSI controller run the whole request.

The corresponding codelines should be in

drivers/scsi/sgiwd93.c
    113         if(cmd->SCp.buffers_residual) {
    114                 struct scatterlist *slp = cmd->SCp.buffer;
    115                 int i, totlen = 0;
    116
    117 #ifdef DEBUG_DMA
    118                 printk("SCLIST<");
    119 #endif
    120                 for(i = 0; i <= cmd->SCp.buffers_residual; i++) {
    121 #ifdef DEBUG_DMA
    122                         printk("[%p,%d]", slp[i].address, slp[i].length);
    123 #endif
    124                         fill_hpc_entries (&hcp, slp[i].address, slp[i].length);
    125                         totlen += slp[i].length;
    126                 }
    127 #ifdef DEBUG_DMA
    128                 printk(">tlen<%d>", totlen);
    129 #endif
    130                 hdata->dma_bounce_len = totlen; /* a trick... */
    131                 write_wd33c93_count(regp, totlen);
    132         } else {
    133                 /* Non-scattered dma. */
    134 #ifdef DEBUG_DMA
    135                 printk("ONEBUF<%p,%d>", cmd->SCp.ptr, cmd->SCp.this_residual);
    136 #endif
    137                 /*
    138                  * wd33c93 shouldn't pass us bogus dma_setups, but
    139                  * it does:-( The other wd33c93 drivers deal with
    140                  * it the same way (which isn't that obvious).
    141                  * IMHO a better fix would be, not to do these
    142                  * dma setups in the first place
    143                  */
    144                 if (cmd->SCp.ptr == NULL)
    145                         return 1;
    146                 fill_hpc_entries (&hcp, cmd->SCp.ptr,cmd->SCp.this_residual);
    147                 write_wd33c93_count(regp, cmd->SCp.this_residual);
    148         }

So we have an incompatibility with the sgiwd93.c from the mips tree
and the wd33c93.c from the linus tree where we dont want the generic part
of the wd33c93.c to (re)write the length of the current transfer block
(scatter gather part) as we want it to do the whole transfer in one
part (From the generic wd33c93.c we dont do scatter gather).

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
