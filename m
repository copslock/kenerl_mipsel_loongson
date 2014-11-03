Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2014 21:54:08 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:12758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010884AbaKCUyHIuBWq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Nov 2014 21:54:07 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 03 Nov 2014 12:52:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,308,1413270000"; 
   d="scan'208";a="630648475"
Received: from ray.jf.intel.com (HELO [10.7.199.174]) ([10.7.199.174])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2014 12:53:59 -0800
Message-ID: <5457EB67.70904@intel.com>
Date:   Mon, 03 Nov 2014 12:53:59 -0800
From:   Dave Hansen <dave.hansen@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ren Qiaowei <qiaowei.ren@intel.com>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <544DB873.1010207@intel.com> <alpine.DEB.2.11.1410272138540.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410272138540.5308@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.hansen@intel.com
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

On 10/27/2014 01:49 PM, Thomas Gleixner wrote:
> Errm. Before user space can use the bounds table for the new mapping
> it needs to add the entries, right? So:
> 
> CPU 0					CPU 1
> 
> down_write(mm->bd_sem);
> mpx_pre_unmap();
>    clear bounds directory entries	
> unmap();
> 					map()
> 					write_bounds_entry()
> 					trap()
> 					  down_read(mm->bd_sem);
> mpx_post_unmap(); 
> up_write(mm->bd_sem);
> 					  allocate_bounds_table();
> 
> That's the whole point of bd_sem.

This does, indeed, seem to work for the normal munmap() cases.  However,
take a look at shmdt().  We don't know the size of the segment being
unmapped until after we acquire mmap_sem for write, so we wouldn't be
able to do do a mpx_pre_unmap() for those.

mremap() is similar.  We don't know if the area got expanded (and we
don't need to modify bounds tables) or moved (and we need to free the
old location's tables) until well after we've taken mmap_sem for write.

I propose we keep mm->bd_sem.  But, I think we need to keep a list
during each of the unmapping operations of VMAs that got unmapped, and
then keep them on a list without freeing then.  At up_write() time, we
look at the list, if it is empty, we just do an up_write() and we are done.

If *not* empty, downgrade_write(mm->mmap_sem), and do the work you
spelled out in mpx_pre_unmap() above: clear the bounds directory entries
and gather the VMAs while still holding mm->bd_sem for write.

Here's the other wrinkle: This would invert the ->bd_sem vs. ->mmap_sem
ordering (bd_sem nests outside mmap_sem with the above scheme).  We
_could_ always acquire bd_sem for write whenever mmap_sem is acquired,
although that seems a bit heavyweight.  I can't think of anything better
at the moment, though.
