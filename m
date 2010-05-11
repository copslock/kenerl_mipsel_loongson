Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2010 20:48:53 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:32878 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491967Ab0EKSst (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 May 2010 20:48:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4BImjmR009215;
        Tue, 11 May 2010 19:48:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4BImi6T009213;
        Tue, 11 May 2010 19:48:44 +0100
Date:   Tue, 11 May 2010 19:48:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     wuzhangjin@gmail.com, linux-mips <linux-mips@linux-mips.org>
Subject: Re: About MIPS specific dma_mmap_coherent()
Message-ID: <20100511184844.GA7978@linux-mips.org>
References: <1271134735.25797.35.camel@falcon>
 <s5hmxx7z4a7.wl%tiwai@suse.de>
 <1271218889.25872.27.camel@falcon>
 <s5hzl164kay.wl%tiwai@suse.de>
 <1271235619.25872.148.camel@falcon>
 <s5h633uxcje.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h633uxcje.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 14, 2010 at 05:46:13PM +0200, Takashi Iwai wrote:

> But, I remember vaguely that calling pgprot_noncached()
> unconditionally is dangerous.  It should be checked somehow, e.g. via
> platform_device_is_coherent().  And, this found only in
> dma-coherence.h, and adding it to pcm_native.c would become messy like
> below...
> 
> So, it'd be really better to add dma_mmap_coherent(), indeed.

We agreed that this was only meant as a stop gap meassure.  As such I do
agree with either of

  http://patchwork.linux-mips.org/patch/1117/
  http://patchwork.linux-mips.org/patch/1118/

Wu has tested the 1117 patch so that might make it preferable especially
for 2.6.34 if we should go for that.

  Ralf
