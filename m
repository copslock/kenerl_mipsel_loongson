Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2012 10:44:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58403 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6820610Ab2KBJo0odKBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Nov 2012 10:44:26 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qA29iO9o023423;
        Fri, 2 Nov 2012 10:44:24 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qA29iNsr023422;
        Fri, 2 Nov 2012 10:44:23 +0100
Date:   Fri, 2 Nov 2012 10:44:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jean-Christophe PINCE <jcpince@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS ASID type conflicts
Message-ID: <20121102094423.GB17860@linux-mips.org>
References: <CAEiBgeAukAdZv1WNcJQ6DByP7Yy63gvRS0cY6q6yU27p+XRi4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEiBgeAukAdZv1WNcJQ6DByP7Yy63gvRS0cY6q6yU27p+XRi4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34851
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 23, 2012 at 01:49:26PM +0200, Jean-Christophe PINCE wrote:

> I am analyzing Linux MIPS tasks memory spaces and found out what I
> think is a bug in the ASID management.
> 
> The structure "struct cpuinfo_mips" defined in
> arch/mips/include/asm/cpu-info.h uses a "unsigned int" field for
> asid_cache while the context field defined in
> arch/mips/include/asm/mmu.h is a "unsigned long".
> 
> This is ok with 32bits kernel but leads to 4bytes vs 8bytes fields
> with a 64bits kernel. And when the scheduler checks if the ASID is of
> an older ASID_VERSION, the test will always return that the version
> differs when the context bits above bit31 will be set.
> 
> I imagine this should be a quite rare issue but could likely happen on
> devices running for very long and starting processes very often (or
> running more than 256 processes per cpu). When this condition (bit 32
> or above of asid_cache is set), the effect should be that the TLB will
> be flushed on each context_switch required by the scheduler but there
> shouldn't be any crash.

A full flush of the TLB can be implemented by picking a fresh ASID as
long as there are still fresh ASIDs available.  This happens fairly
frequently; a typical system has burned through the first 256 ASIDs
somewhen during bootup.

There is not much advantage to be gained from having the ASID and generation
counter in a 64-bit variable so I think I'm just going to change
mmu_context_t to:

typedef struct {
        unsigned int asid[NR_CPUS];
        void *vdso;
} mm_context_t;

  Ralf
