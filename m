Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 11:37:17 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46607 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010225AbbJSJhPqxh89 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Oct 2015 11:37:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t9J9b8ee032397;
        Mon, 19 Oct 2015 11:37:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t9J9b0YY032396;
        Mon, 19 Oct 2015 11:37:00 +0200
Date:   Mon, 19 Oct 2015 11:37:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>, Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Message-ID: <20151019093700.GC2092@linux-mips.org>
References: <5082760.FgB9zHNfte@wuerfel>
 <20151007104502.GH21513@n2100.arm.linux.org.uk>
 <6260324.3MlUEc3veg@wuerfel>
 <5152101.mD2bWzUJ2V@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5152101.mD2bWzUJ2V@wuerfel>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49595
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

On Wed, Oct 07, 2015 at 01:23:07PM +0200, Arnd Bergmann wrote:

> > I haven't checked all architectures, but I assume what happens is that
> > 64-bit ones just #define atomic64_t atomic_long_t, so they don't have
> > to provide three sets of functions.
> 
> scratch that, I just looked at all the architectures and found that it's
> just completely arbitrary, even within one architecture you get a mix
> of 'long' and 'long long', plus this gem from MIPS:
> 
> static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> 
> which truncates the result to 32 bit.

Eh...  The result is 0/1 so nothing is truncated.  Alpha, MIPS,
PARISC and PowerPC are using the same prototype and x86 only differs
in the use of inline instead __inline__.  And anyway, that function on
MIPS is only built for CONFIG_64BIT.

What's wrong on MIPS is the comment describing the function's return value
which was changed by f24219b4e90cf70ec4a211b17fbabc725a0ddf3c (atomic: move
atomic_add_unless to generic code) and I've queued up a patch to fix that
since a few days.  I guess that was a cut and paste error from
__atomic_add_unless which indeed does return the old value.

  Ralf
