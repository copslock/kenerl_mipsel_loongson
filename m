Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2010 23:18:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50969 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493639Ab0A0WSN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2010 23:18:13 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0RMIJqn007006;
        Wed, 27 Jan 2010 23:18:20 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0RMIJT9006998;
        Wed, 27 Jan 2010 23:18:19 +0100
Date:   Wed, 27 Jan 2010 23:18:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix dbdma ring destruction memory
 debugcheck.
Message-ID: <20100127221818.GB26426@linux-mips.org>
References: <1264534773-24909-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264534773-24909-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 17867

On Tue, Jan 26, 2010 at 08:39:33PM +0100, Manuel Lauss wrote:

> DBDMA descriptors need to be located at 32-byte aligned addresses;
> however kmalloc in conjunction with the SLAB allocator and 
> CONFIG_DEBUG_SLUB enabled doesn't deliver any.  The dbdma code works
> around that by allocating a larger area and realigning the start
> address within it.
> 
> When freeing a channel however this adjustment is not taken into
> account which results in an oops:
> 
> Kernel bug detected[#1]:
> [...]
> Call Trace:
> [<80186010>] cache_free_debugcheck+0x284/0x318
> [<801869d8>] kfree+0xe8/0x2a0
> [<8010b31c>] au1xxx_dbdma_chan_free+0x2c/0x7c
> [<80388dc8>] au1x_pcm_dbdma_free+0x34/0x4c
> [<80388fa8>] au1xpsc_pcm_close+0x28/0x38
> [<80383cb8>] soc_codec_close+0x14c/0x1cc
> [<8036dbb4>] snd_pcm_release_substream+0x60/0xac
> [<8036dc40>] snd_pcm_release+0x40/0xa0
> [<8018c7a8>] __fput+0x11c/0x228
> [<80188f60>] filp_close+0x7c/0x98
> [<80189018>] sys_close+0x9c/0xe4
> [<801022a0>] stack_done+0x20/0x3c
> 
> Fix this by recording the address delivered by kmalloc() and using
> it as parameter to kfree().
> 
> This fix is only necessary with the SLAB allocator and CONFIG_DEBUG_SLAB
> enabled;  non-debug SLAB, SLUB do return nicely aligned addresses,
> debug-enabled SLUB currently panics early in the boot process.

Queued for 2.6.34 - should this also go into 2.6.33?

Have you considered increasing the value ARCH_KMALLOC_MINALIGN which
defaults to 8?  Or your own slab cache of suitable alignment?  The latter
is more something for frequent allocations.

  Ralf
