Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 13:44:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60113 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1493301Ab0AZMoa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 13:44:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0QCi5bP016989;
        Tue, 26 Jan 2010 13:44:06 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0QCi4Fl016987;
        Tue, 26 Jan 2010 13:44:04 +0100
Date:   Tue, 26 Jan 2010 13:44:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Alexander Clouter <alex@digriz.org.uk>, linux-mips@linux-mips.org
Subject: Re: [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
Message-ID: <20100126124404.GF30098@linux-mips.org>
References: <vs6k27-7b2.ln1@chipmunk.wormnet.eu>
 <20100122145256.GA5570@linux-mips.org>
 <1264247776.14811.8.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264247776.14811.8.camel@falcon>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16650

On Sat, Jan 23, 2010 at 07:56:16PM +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> Date:   Sat, 23 Jan 2010 19:56:16 +0800
> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: Alexander Clouter <alex@digriz.org.uk>, linux-mips@linux-mips.org
> Subject: Re: [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
> Content-Type: text/plain; charset="UTF-8"
> 
> On Fri, 2010-01-22 at 15:52 +0100, Ralf Baechle wrote:
> > On Wed, Jan 20, 2010 at 08:50:07PM +0000, Alexander Clouter wrote:
> > 
> > > Counter to the documentation for the dash shell, it seems that on my
> > > x86_64 filth under Debian only does 32bit math.  As I have configured my
> > 
> > POSIX apparently specifies at least "long" type arithmetic for shells, so
> > if your dash indeed is a 64-bit binary it's in violation of POSIX.  What
> > does
> > 
> >   file $(which $SHELL)
> > 
> > say?
> > 
> > The dash binary on my Fedora 12 i386 seems to perform 64-bit arithmetic.
> > 
> 
> Hi, Ralf
> 
> on my yeeloong laptop, with dash(0.5.5.1-3) in o32 ABI, it also can only
> execute 32-bit numbers, but on my thinkpad SL400(i686, dash version is
> 0.5.5.1-2), it works well with 64-bit arithmetic.
> 
> So, it means dash not always works normally, perhaps there is a bug
> there, or the bug only exists on MIPS machines?

Well, I was wondering if the dash being used by Alexander is simply
defect.  However in the end that doesn't matter; we try to restrict
the build environment to just a standard POSIX environment - or at least
as close as possible and that means we can only expect $((<expression))
to perform 32-bit arithmetic.

I've applied the patch for now but this is ugly.  I was even considering
if a small host C program that does the math is the lesser evil.

That said, applied.  Thanks folks!

  Ralf
