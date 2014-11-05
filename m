Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 11:21:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45379 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012648AbaKEKVyUYZeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Nov 2014 11:21:54 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sA5ALqXr010496;
        Wed, 5 Nov 2014 11:21:52 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sA5ALqe7010495;
        Wed, 5 Nov 2014 11:21:52 +0100
Date:   Wed, 5 Nov 2014 11:21:52 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Message-ID: <20141105102151.GC8965@linux-mips.org>
References: <54560D3B.8060602@gentoo.org>
 <5457CF0A.7020303@gmail.com>
 <5458272A.7050309@gentoo.org>
 <54582A91.8040401@gmail.com>
 <5459E8CC.6040205@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5459E8CC.6040205@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43874
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

On Wed, Nov 05, 2014 at 04:07:24AM -0500, Joshua Kinard wrote:

> It was pointed out to me off list that this statement for the PageMask register
> in the R10K manual may explain things:
> 
> """TLB read and write operations use this register as either a source or a
> destination; when virtual addresses are presented for translation into physical
> address, the corresponding bits in the TLB identify which virtual address bits
> among bits 24:13 are used in the comparison. When the Mask field is not one of
> the values shown in Table 13-6, the operation of the TLB is undefined. The 0
> field is reserved; it must be written as zeroes, and returns zeroes when read."""
> 
> 2MB page sizes aren't explicitly listed in this table in the manual, so setting
> bits 24:13 in PageMask might be leading to this "undefined behavior", which on
> R12K might include the random bus errors/segfaults, and R14K triggers an IBE
> that needs a cold reboot.

All MIPS CPUs with a R4000-style TLB have this restriction.  It's just that the
behaviour of such bitmask values being undefined the resulting behviour is likely
to differ between CPU types.

2MB pages will be loaded into the TLB as a pair of adjacent pair of 1MB pages.

> The only other R10K system I have is the IP28, but I haven't gotten that to
> boot up in a few years.

  Ralf
