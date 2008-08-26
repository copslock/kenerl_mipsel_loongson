Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 22:01:39 +0100 (BST)
Received: from colo.lackof.org ([198.49.126.79]:20151 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S20039017AbYHZVBh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2008 22:01:37 +0100
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 10ECF29806B;
	Tue, 26 Aug 2008 15:01:29 -0600 (MDT)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27905-03; Tue, 26 Aug 2008 15:01:18 -0600 (MDT)
Received: by colo.lackof.org (Postfix, from userid 27253)
	id AFE1529800A; Tue, 26 Aug 2008 15:01:18 -0600 (MDT)
Date:	Tue, 26 Aug 2008 15:01:18 -0600
From:	Grant Grundler <grundler@parisc-linux.org>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	Joel Soete <soete.joel@scarlet.be>,
	"James.Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-mips <linux-mips@linux-mips.org>,
	ralf <ralf@linux-mips.org>,
	linux-parisc <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
Message-ID: <20080826210118.GA26235@colo.lackof.org>
References: <K6047O$07C3A675C0E02FC7BE973C0D5DEF9AAA@scarlet.be> <s5hy72pmefh.wl%tiwai@suse.de> <48B0678E.9010208@scarlet.be> <s5hej4blrx7.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hej4blrx7.wl%tiwai@suse.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <grundler@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@parisc-linux.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 26, 2008 at 05:25:24PM +0200, Takashi Iwai wrote:
...
> Now updated my git tree:
>     http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;h=topic/dma-fix
> I'll post each patch again if preferred.

+#ifdef CONFIG_SND_COHERENT_DMA
 #define SNDRV_DMA_TYPE_DEV_SG          3       /* generic device SG-buffer */
+#else
+#define SNDRV_DMA_TYPE_DEV_SG  SNDRV_DMA_TYPE_DEV /* no SG-buf support */
+#endif

Hi Takashi,
I had to look at a previous patch to figure out CONFIG_SND_COHERENT_DMA
is an arch dependent flag:

+config SND_COHERENT_DMA
+       def_bool y
+       depends on !PPC32 || !NOT_COHERENT_CACHE
+       depends on !ARM
+       depends on !MIPS
+       depends on !PARISC

In general, I don't expect this to be a compile time option.
I'm wondering if extending the DMA API to provide an
interface for user space to also be DMA coherent.
Maybe something to talk about at Linux Plumbers Conf
or kernel summit...

> Do you guys see any pending issues?  I'd love to merge these patches
> into the upstream for 2.6.28.

SPARC/SPARC64 usually falls into the same category as parisc/mips.

> 
> To get things clear -- I don't intend to fix the problem of mmap on
> every non-coherent platform perfectly (yet).  Instead, this patch
> series is intended to fix the current behavior, at least, for the
> sound drivers not to crash unconditionally.  It provides a (minimal)
> way to mmap the pages taken via dma_alloc_coherent().

*nod* that's reasonable.

thanks,
grant

> 
> 
> Thanks,
> 
> Takashi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-parisc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
