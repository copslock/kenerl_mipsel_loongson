Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 14:46:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52373 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6821091AbaDJMqNhwvjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Apr 2014 14:46:13 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s3ACkCqf030126;
        Thu, 10 Apr 2014 14:46:12 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s3ACkCW7030125;
        Thu, 10 Apr 2014 14:46:12 +0200
Date:   Thu, 10 Apr 2014 14:46:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Miod Vallat <miod@online.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140410124612.GX17197@linux-mips.org>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
 <20140409051929.GA29246@localhost>
 <20140409082445.GC1438@pax.zz.de>
 <20140409133229.GA22315@alpha.franken.de>
 <20140409231345.GC8370@localhost>
 <5345DB6A.7060004@gentoo.org>
 <20140410003806.GV17197@linux-mips.org>
 <534609B2.5070808@gentoo.org>
 <loom.20140410T140715-346@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20140410T140715-346@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Apr 10, 2014 at 12:10:41PM +0000, Miod Vallat wrote:

> > Odd, I thought R10K systems were locked to booting 64-bit kernels only.  At
> > least the Octane was when it was bootable.  Not sure about IP27.
> 
> The Octane needs a 64-bit ARCS and kernel only because none of its
> physical memory is addressable with KSEG0/KSEG1.
> 
> > >> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it
> working, though.
> 
> For some very limited value of working (it boots single-user but does not
> last long due to page table corruption).

The R8000 is infamous for its buggyness.  In a silent night in Mountain View
you can still hear SGI IRIX developers' curses echoing from distant
mountains ...

  Ralf
