Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 15:19:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48126 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992029AbcIUNTUfdGJA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2016 15:19:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8LDJJEG015465;
        Wed, 21 Sep 2016 15:19:19 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8LDJJMu015464;
        Wed, 21 Sep 2016 15:19:19 +0200
Date:   Wed, 21 Sep 2016 15:19:19 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/9] MIPS: traps: Ensure full EBase is written
Message-ID: <20160921131919.GB10899@linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <c4de81b497c4a02a2bec5abc5234b7d84b75c5ec.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4de81b497c4a02a2bec5abc5234b7d84b75c5ec.1472747205.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55220
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

On Thu, Sep 01, 2016 at 05:30:09PM +0100, James Hogan wrote:

> On CPUs which support the EBase WG (write gate) flag, the most
> significant bits of the exception base can be changed. Firmware running
> on a VP(E) using MIPS rproc may change EBase to point into the user
> segment where the firmware is located such that it can service
> interrupts. When control is transferred back to the kernel the EBase
> must be switched back into the kernel segment, such that the kernel's
> exception vectors are used.
> 
> Similarly when vectored interrupts (vint) or vectored external interrupt
> controllers (veic) are enabled an exception vector is allocated from
> bootmem, and written to the EBase register. Due to the WG flag being
> clear, only bits 29:12 will be written. Asside from the rproc case above
> this is normally fine (as it will usually be a low allocation within the
> KSeg0 range, however when Enhanced Virtual Addressing (EVA) is enabled
> the allocation may be outside of the traditional KSeg0/KSeg1 address
> range, resulting in the wrong EBase being written.
> 
> Correct both cases (configure_exception_vector() for the boot CPU, and
> per_cpu_trap_init() for secondary CPUs) to write EBase with the WG flag
> first if supported.
> 
> On the Malta EVA configuration, KSeg0 is mapped to physical address 0,
> and memory is allocated from the KUSeg segment which is mapped to
> physical address 0x80000000, which physically aliases the RAM at 0. This
> only worked due to the exception base address aliasing the same
> underlying RAM that was written to & cache flushed, and due to
> flush_icache_range() going beyond the call of duty and flushing from the
> L2 cache too (due to the differing physical addresses).

See comments on 1/9.

I think I can apply the remaining patches already before we finished
sorting out 1/9 and 3/9, so I will do so.

  Ralf
