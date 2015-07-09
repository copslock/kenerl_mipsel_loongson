Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 11:07:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43729 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009673AbbGIJH1HkabL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jul 2015 11:07:27 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6997Ito031090;
        Thu, 9 Jul 2015 11:07:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6997Bfc031089;
        Thu, 9 Jul 2015 11:07:11 +0200
Date:   Thu, 9 Jul 2015 11:07:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Huacai Chen <chenhc@lemote.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Joe Perches <joe@perches.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Yusuf Khan <yusuf.khan@nokia.com>,
        Michael Kreuzer <michael.kreuzer@nokia.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH RFC] mips: bootmem: Don't use memory holes for page bitmap
Message-ID: <20150709090711.GA31002@linux-mips.org>
References: <559555B1.7000207@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559555B1.7000207@nokia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48136
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

On Thu, Jul 02, 2015 at 05:16:01PM +0200, Alexander Sverdlin wrote:

> Commit f9a7febd leads to a fact that mapstart and therefore a page bitmap for
> bootmem allocator immediately follows initrd_end. This doesn't always work
> well on Octeon, where there are holes in PFN ranges (refer to 5b3b1688 and
> 4MB-aligned PFN allocation). Depending on the inird location it could happen,
> that mapstart would be in an area not allocated by plat_mem_setup() in
> arch/mips/cavium-octeon/setup.c, but in the alignment hole between initrd and
> the next PFN area. Later on this memory will be unconditionally made available
> to buddy allocator at the end of free_all_bootmem_core() (mm/bootmem.c).
> All of this results in Linux using the memory not designated for Linux in
> Octeon's plat_mem_setup(), which in turn means corruption of the memory used
> by another OS/baremetal code on the same SoC.
> 
> It doesn't look to me as a problem of Octeon platform code, but rather as an
> inability of f9a7febd to deal correctly with the fragmented memory-mappings.
> Proposed fix moves the check for initrd address to the same calculation-loop
> in bootmem_init() (arch/mips/kernel/setup.c), which also accounts for kernel
> code location. This should result in mapstart located starting from the first
> PFN area after kernel code AND initrd.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Appears reasonable.  Applied.

Thanks,

  Ralf
