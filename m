Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 09:46:35 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34165 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492237AbZK0Iqc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2009 09:46:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAR8kc9o019043;
        Fri, 27 Nov 2009 08:46:38 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAR8kZpS019041;
        Fri, 27 Nov 2009 08:46:35 GMT
Date:   Fri, 27 Nov 2009 08:46:35 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 3/5] ALSA: pcm - fix page conversion on non-coherent MIPS
 arch
Message-ID: <20091127084635.GA18741@linux-mips.org>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de>
 <1259248388-20095-2-git-send-email-tiwai@suse.de>
 <1259248388-20095-3-git-send-email-tiwai@suse.de>
 <1259248388-20095-4-git-send-email-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259248388-20095-4-git-send-email-tiwai@suse.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 26, 2009 at 04:13:06PM +0100, Takashi Iwai wrote:

> The non-coherent MIPS arch doesn't give the correct address by a simple
> virt_to_page() for pages allocated via dma_alloc_coherent().
> 
> Original patch by Wu Zhangjin <wuzj@lemote.com>.  A proper check of the
> buffer allocation type was added to avoid the wrong conversion.

The origins of this patch go back far further.  The oldest patch I could
find which is a superset of this was written by Atsushi Nemoto and
various incarnations of it have been sumitted to and reject by me
a number of times through the years.

> Note that this doesn't fix perfectly: the pages should be marked with
> proper pgprot value.  This will be done in a future implementation like
> the conversion to dma_mmap_coherent().
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

So while this is ugly I don't think this patch will actually make the
the situation worse for any MIPS platform.  So with both eyes closed:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
