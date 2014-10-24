Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 16:40:33 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:42954 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010609AbaJXOkbESBzp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2014 16:40:31 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xhg2M-0003ce-TJ; Fri, 24 Oct 2014 16:40:19 +0200
Date:   Fri, 24 Oct 2014 16:40:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Qiaowei Ren <qiaowei.ren@intel.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
In-Reply-To: <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com>
Message-ID: <alpine.DEB.2.11.1410241451280.5308@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Sun, 12 Oct 2014, Qiaowei Ren wrote:
> Since we are doing the freeing from munmap() (and other paths like it),
> we hold mmap_sem for write. If we fault, the page fault handler will
> attempt to acquire mmap_sem for read and we will deadlock. For now, to
> avoid deadlock, we disable page faults while touching the bounds directory
> entry. This keeps us from being able to free the tables in this case.
> This deficiency will be addressed in later patches.

This is wrong to begin with. You need a proper design for addressing
this short coming in the first place. Retrofitting it into your
current design will just not work at all or end up with some major
mess.
 
The problem to solve is, that the kernel needs to unmap the bounds
table if the data mapping which it covers goes away.

You decided to do that at the end of unmap with mmap_sem write
held. As I explained last time, that's not an absolute requirement,
it's just a random choice. And that choice is obvioulsy not a really
good one as your own observation of the page fault issue proves.

So perhaps we should look at it the other way round. We already know
before the actual unmap happens what's the start and the end of the
area.

So we can be way smarter and do the following:

   mpx_pre_unmap(from, len);

   down_write(mmap_sem);
   do_unmap(from, len);
   up_write(mmap_sem);

   mpx_post_unmap(mpx_unmap);

int mpx_pre_unmap(...)
{
    down_write(mm->bd_sem);
    
    down_read(mm->mmap_sem);

    Here we do the following: 

    1) Invalidate the bounds table entries for the to be unmapped area in
       the bounds directory. This can fault as we only hold mmap sem for
       read.
    
    2) Mark the corresponding VMAs which should be unmapped and
       removed.  This can be done with mmap sem down read held as the
       VMA chain cannot be changed and the 'Mark for removal" field is
       protected by mm->bd_sem.
   
       For each to be removed VMA we increment mm->bd_remove_vmas
 
    Holding mm->bd_sem also prevents that a new bound table to be
    inserted, if we do the whole protection thing right.

    up_read(mm->mmap_sem);
}

void mpx_post_unmap(void)
{
	if (mm->bd_remove_vmas) {
	   down_write(mm->mmap_sem);
 	   cleanup_to_be_removed_vmas();		
	   up_write(mm->mmap_sem);
	}

	up_write(mm->bd_sem);
}

The mpx_pre_unmap/post_unmap calls can be either added explicit to the
relevant down_write/unmap/up_write code pathes or you hide it behind
some wrapper function.

Now you need to acquire mm->bd_sem for the fault handling code as well
in order to serialize the creation of new bound table entries. In that
case a down_read(mm->bd_sem) is sufficient as the cmpxchg() prevents
the insertion of multiple tables for the same directory entries.

So we'd end up with the following serialization scheme:

prctl enable/disable management:  down_write(mm->bd_sem);

bounds violation:    		  down_read(mm->bd_sem);

directory entry allocation:	  down_read(mm->bd_sem);

directory entry removal:	  down_write(mm->bd_sem);

Now we need to check whether there is a potential deadlock lurking
around the corner. We get the following nesting scenarios:

- prctl enable/disable management:  down_write(mm->bd_sem);

   No mmap_sem nesting at all

- bounds violation:    	     down_read(mm->bd_sem);

   Might nest down_read(mm->mmap_sem) if the copy code from user space
   faults.

- directory entry allocation:	     down_read(mm->bd_sem);

   Nests down_write(mm->mmap_sem) for the VMA allocation.

   Might nest down_read(mm->mmap_sem) if the cmpxchg() for the
   directory entry faults

- directory entry removal:	  down_write(mm->bd_sem);

   Might nest down_read(mm->mmap_sem) if the invalidation of the
   directory entry faults

In other words here is the possible nesting:

  #1 down_read(mm->bd_sem);  down_read(mm->mmap_sem);

  #2 down_read(mm->bd_sem);  down_write(mm->mmap_sem);

  #3 down_write(mm->bd_sem); down_read(mm->mmap_sem);

  #4 down_write(mm->bd_sem); down_write(mm->mmap_sem);

We never execute any of those nested on a single task. The bounds
fault handler is never nested as it always comes from user space. So
we should be safe.

And this prevents all the nasty race conditions I discussed in
Portland with Dave which happen when we try do to stuff outside of the
mmap_sem write held region.

Performance wise it's not an issue either. The prctl case is not a a
hotpath anyway. The fault handlers get away with down_read() and the
unmap code is heavyweight on mmap sem write held anyway.

Thoughts?

Thanks,

	tglx
