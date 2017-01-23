Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 15:52:14 +0100 (CET)
Received: from resqmta-ch2-05v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:37]:48517
        "EHLO resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbdAWOwHBwbh5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 15:52:07 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-05v.sys.comcast.net with SMTP
        id VfyEcCWoQGIG7VfyXcn9d3; Mon, 23 Jan 2017 14:52:05 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-07v.sys.comcast.net with SMTP
        id VfyVctNw2aq1HVfyVckNC9; Mon, 23 Jan 2017 14:52:05 +0000
Subject: Re: [PATCH 00/21] MIPS memblock: Remove bootmem code and switch to
 NO_BOOTMEM
To:     linux-mips@linux-mips.org
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <c0e4bffe-66e2-d9f9-15da-9f4654142e57@gentoo.org>
Date:   Mon, 23 Jan 2017 09:51:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAsGv5eOskyO26VhNJ2VldYy8EOrGHGexIgSIGKH+BT/PopqoVRX156MxUv2HAyh9aIr72eWaFGWbDjT4j8EnSCLLfkvVfN/VmgUCKSy4rrH80OmbNe+
 nffwAtNnJZo4sDEIX6eJUL2EZTNiV6RpoZtFf07tzrlUXRStE+Q7Aj7Q
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 12/18/2016 21:07, Serge Semin wrote:
> Most of the modern platforms supported by linux kernel have already
> been cleaned up of old bootmem allocator by moving to nobootmem
> interface wrapping up the memblock. This patchset is the first
> attempt to do the similar improvement for MIPS for UMA systems
> only.
> 
> Even though the porting was performed as much careful as possible
> there still might be problem with support of some platforms,
> especially Loonson3 or SGI IP27, which perform early memory manager
> initialization by their self.

I can take a look at the IP27 issues, but I'm kinda stuck right now on the odd
gcc-6.3.x bug I described in an earlier e-mail, so I don't know when I'll get
around to this.


> The patchset is split so individual patch being consistent in
> functional and buildable ways. But the MIPS early memory manager
> will work correctly only either with or without the whole set being
> applied. For the same reason a reviewer should not pay much attention
> to methods bootmem_init(), arch_mem_init(), paging_init() and
> mem_init() until they are fully refactored.
> 
> The patchset is applied on top of kernel v4.9.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Serge Semin (21):
>   MIPS memblock: Unpin dts memblock sanity check method
>   MIPS memblock: Add dts mem and reserved-mem callbacks
>   MIPS memblock: Alter traditional add_memory_region() method
>   MIPS memblock: Alter user-defined memory parameter parser
>   MIPS memblock: Alter initrd memory reservation method
>   MIPS memblock: Alter kexec-crashkernel parameters parser
>   MIPS memblock: Alter elfcorehdr parameters parser
>   MIPS memblock: Move kernel parameters parser into individual method
>   MIPS memblock: Move kernel memory reservation to individual method
>   MIPS memblock: Discard bootmem allocator initialization
>   MIPS memblock: Add memblock sanity check method
>   MIPS memblock: Add memblock print outs in debug
>   MIPS memblock: Add memblock allocator initialization
>   MIPS memblock: Alter IO resources initialization method
>   MIPS memblock: Alter weakened MAAR initialization method
>   MIPS memblock: Alter paging initialization method
>   MIPS memblock: Alter high memory freeing method
>   MIPS memblock: Slightly improve buddy allocator init method
>   MIPS memblock: Add print out method of kernel virtual memory layout
>   MIPS memblock: Add free low memory test method call
>   MIPS memblock: Deactivate old bootmem allocator
> 
>  arch/mips/Kconfig        |   2 +-
>  arch/mips/kernel/prom.c  |  32 +-
>  arch/mips/kernel/setup.c | 958 +++++++++++++++--------------
>  arch/mips/mm/init.c      | 234 ++++---
>  drivers/of/fdt.c         |  47 +-
>  include/linux/of_fdt.h   |   1 +
>  6 files changed, 739 insertions(+), 535 deletions(-)
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
