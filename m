Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 12:22:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55830 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492034Ab0A1LWy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 12:22:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0SBMvus011574;
        Thu, 28 Jan 2010 12:22:59 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0SBMsRK011563;
        Thu, 28 Jan 2010 12:22:54 +0100
Date:   Thu, 28 Jan 2010 12:22:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v2] MIPS: Alchemy: fix dbdma ring destruction memory
 debugcheck.
Message-ID: <20100128112250.GA8043@linux-mips.org>
References: <1264534773-24909-1-git-send-email-manuel.lauss@gmail.com>
 <20100127221818.GB26426@linux-mips.org>
 <f861ec6f1001280023n7753c77wfd626d731ddc690a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f1001280023n7753c77wfd626d731ddc690a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18134

On Thu, Jan 28, 2010 at 09:23:56AM +0100, Manuel Lauss wrote:

> >> This fix is only necessary with the SLAB allocator and CONFIG_DEBUG_SLAB
> >> enabled;  non-debug SLAB, SLUB do return nicely aligned addresses,
> >> debug-enabled SLUB currently panics early in the boot process.
> >
> > Queued for 2.6.34 - should this also go into 2.6.33?
> 
> 2.6.33 and .32 at least.  That code has been in there since the dawn of 2.6;
> the fact that nobody has tripped over this so far means that noone build kernels
> with slab debugging (I tripped over this while looking for something else) or
> the slab allocator behaviour changed recently.

The behaviour of the slab has been like this as long as I can remember.
Cherrypicking into the -stable branches as I'm writing this.

> > Have you considered increasing the value ARCH_KMALLOC_MINALIGN which
> > defaults to 8?  Or your own slab cache of suitable alignment?  The latter
> > is more something for frequent allocations.
> 
> I have to admit I know nothing about Linux' memory management.  Are slab
> caches not affected by the what I presume are "guard bytes" inserted into
> the memory areas when slab debug is on?

When creating a slab cache an alignment for objects allocated from this
cache can be specified.

  Ralf
