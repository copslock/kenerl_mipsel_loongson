Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 11:42:58 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:55352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011577AbaJ1Km5MKsyn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 11:42:57 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1Xj4Eg-0002Kl-Nx; Tue, 28 Oct 2014 11:42:46 +0100
Date:   Tue, 28 Oct 2014 11:42:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ren Qiaowei <qiaowei.ren@intel.com>
cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
In-Reply-To: <544F300B.7050002@intel.com>
Message-ID: <alpine.DEB.2.11.1410281044420.5308@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <544DB873.1010207@intel.com> <alpine.DEB.2.11.1410272138540.5308@nanos>
 <544F300B.7050002@intel.com>
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
X-archive-position: 43618
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

On Tue, 28 Oct 2014, Ren Qiaowei wrote:
> On 10/28/2014 04:49 AM, Thomas Gleixner wrote:
> > On Mon, 27 Oct 2014, Ren Qiaowei wrote:
> > > If so, I guess that there are some questions needed to be considered:
> > > 
> > > 1) Almost all palces which call do_munmap() will need to add
> > > mpx_pre_unmap/post_unmap calls, like vm_munmap(), mremap(), shmdt(), etc..
> > 
> > What's the problem with that?
> > 
> 
> For example:
> 
> shmdt()
>     down_write(mm->mmap_sem);
>     vma = find_vma();
>     while (vma)
>         do_munmap();
>     up_write(mm->mmap_sem);
> 
> We could not simply add mpx_pre_unmap() before do_munmap() or down_write().
> And seems like it is a little hard for shmdt() to be changed to match this
> solution, right?

Everything which does not fall in place right away seems to be a
little hard, heavy weight or whatever excuses you have for it.

It's not that hard, really. We can simply split out the search code
into a seperate function and use it for both problems.

Yes, it is quite some work to do, but its straight forward.

> > > 3) According to Dave, those bounds tables related to adjacent VMAs within
> > > the
> > > start and the end possibly don't have to be fully unmmaped, and we only
> > > need
> > > free the part of backing physical memory.
> > 
> > Care to explain why that's a problem?
> > 
> 
> I guess you mean one new field mm->bd_remove_vmas should be added into staruct
> mm, right?

That was just to demonstrate the approach. I'm giving you a hint how
to do it, I'm not telling you what the exact solution will be. If I
need to do that, then I can implement it myself right away.

> For those VMAs which we only need to free part of backing physical memory, we
> could not clear bounds directory entries and should also mark the range of
> backing physical memory within this vma. If so, maybe there are too many new
> fields which will be added into mm struct, right?

If we need more data to carry over from pre to post, we can allocate a
proper data structure and just add a pointer to that to mm. And it's
not written in stone, that you need to carry that information from pre
to post. You could do the unmap/zap work in the pre phase already and
reduce mpx_post_unmap() to up_write(mm->bt_sem).

I gave you an idea and the center point of that idea is to have a
separate rwsem to protect against the various races, fault handling
etc. You still have to think about the implementation details.

Thanks,

	tglx
