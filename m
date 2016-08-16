Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2016 17:36:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32924 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992378AbcHPPgI3Gted (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2016 17:36:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u7GFa7Do006312;
        Tue, 16 Aug 2016 17:36:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u7GFa7OO006311;
        Tue, 16 Aug 2016 17:36:07 +0200
Date:   Tue, 16 Aug 2016 17:36:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] MIPS: Memory setup tweaks
Message-ID: <20160816153606.GF3894@linux-mips.org>
References: <cover.842913b0756706569a896ef308bb5bf98be4f0ce.1470745146.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.842913b0756706569a896ef308bb5bf98be4f0ce.1470745146.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54571
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

On Tue, Aug 09, 2016 at 01:21:47PM +0100, James Hogan wrote:

> Here are a couple of tweaks for MIPS memory setup, primarily in order to
> handle memory which extends right up to the end of physical memory on
> 32-bit systems with 32-bit phys_addr_t. More specifically we omit the
> final page of physical memory to avoid the overflow (see patch 1 for
> details).
> 
> Patch 2 improves the rounding in the MAAR setup, so as to include the
> first full page of an already aligned region, and to avoid a BUG_ON for
> regions with non 64-KByte aligned end addresses (which I happened to hit
> while working on a different version of patch 1 which wasn't correctly
> merging the kernel data section into the main RAM region).

There's a DMA issue with one of the system controllers on Malta which
afair only affects one endianess and can be worked around by not using
the last bit of memory. That isn't the only platform having such issues
I've seen and debugging has always been very painful so I'm wondering
if as a general precaution we should just leave the last page of memory
unused.

  Ralf
