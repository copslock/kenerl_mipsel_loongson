Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2007 10:39:32 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:714 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021666AbXDTJjb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Apr 2007 10:39:31 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 20 Apr 2007 18:39:29 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0F24641BCF;
	Fri, 20 Apr 2007 18:39:27 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 020F220502;
	Fri, 20 Apr 2007 18:39:27 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l3K9dKW0096444;
	Fri, 20 Apr 2007 18:39:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 20 Apr 2007 18:39:20 +0900 (JST)
Message-Id: <20070420.183920.128619859.nemoto@toshiba-tops.co.jp>
To:	fxzhang@ict.ac.cn
Cc:	ralf@linux-mips.org, tiansm@lemote.com, perex@suse.cz,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: Re: [PATCH 16/16] alsa sound support for mips
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4626276E.3000303@ict.ac.cn>
References: <11766507674145-git-send-email-tiansm@lemote.com>
	<20070418135412.GG3938@linux-mips.org>
	<4626276E.3000303@ict.ac.cn>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 18 Apr 2007 22:13:02 +0800, Fuxin Zhang <fxzhang@ict.ac.cn> wrote:
> >> +#if defined(__mips__) && defined(CONFIG_DMA_NONCOHERENT)
> >> +	/* all mmap using uncached mode */
> >> +	area->vm_page_prot = pgprot_noncached(area->vm_page_prot);
> >> +	area->vm_flags |= ( VM_RESERVED | VM_IO);
> >>     
> >
> > VM_RESERVED will prevent the buffer from being freed.  I assume that is
> > another workaround for some kernel subsystem blowing up when being fed a
> > pointer to an uncached RAM address?  This smells like a memory leak.
> >
> >   
> Oh, VM_RESERVED should be a memory leak problem, we can remove it.
> I don't remember any case of other subsystem's problem, just did not 
> think much
> to add those flags.

I think pgprot_noncached() is needed because user mapping for a DMA
buffer (runtime->dma_area) should be uncache.  If so, doing this in
snd_pcm_mmap() looks a bit suspicious.  It seems snd_pcm_mmap_data()
is a place to do such an adjustment.  But for now, both
snd_pcm_mmap_status() and snd_pcm_mmap_control() returns -ENXIO for
MIPS so this is not a real problem.

And I wonder if VM_IO is really needed.  The area is a DMA buffer,
_not_ a memory mapped IO area, isn't it?

> > I would suggest to get rid of this ifdef with a new arch-specific function
> > like vmap_io_buffer which will do whatever a platform seems fit for this
> > case?
> >   
> I think arch-specific function is the correct way, but don't know what 
> the alsa gods think.

JFYI, there were some discussions on this topic a while ago:

http://lkml.org/lkml/2006/1/25/117

and I'v seen MIPS version of dma_mmap_coherent(), etc. somewhere...

---
Atsushi Nemoto
