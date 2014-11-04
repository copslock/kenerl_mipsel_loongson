Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 18:03:05 +0100 (CET)
Received: from www.linutronix.de ([62.245.132.108]:42819 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011381AbaKDRDD1tBvK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 18:03:03 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1XlhVK-0000GY-TK; Tue, 04 Nov 2014 18:02:51 +0100
Date:   Tue, 4 Nov 2014 18:02:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Ren Qiaowei <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
In-Reply-To: <5458F819.2010503@intel.com>
Message-ID: <alpine.DEB.2.11.1411041726140.4245@nanos>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <544DB873.1010207@intel.com> <alpine.DEB.2.11.1410272138540.5308@nanos>
 <5457EB67.70904@intel.com> <alpine.DEB.2.11.1411032205320.5308@nanos> <5458F819.2010503@intel.com>
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
X-archive-position: 43869
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

On Tue, 4 Nov 2014, Dave Hansen wrote:
> On 11/03/2014 01:29 PM, Thomas Gleixner wrote:
> > On Mon, 3 Nov 2014, Dave Hansen wrote:
> 
> > That's not really true. You can evaluate that information with
> > mmap_sem held for read as well. Nothing can change the mappings until
> > you drop it. So you could do:
> > 
> >    down_write(mm->bd_sem);
> >    down_read(mm->mmap_sem;
> >    evaluate_size_of_shm_to_unmap();
> >    clear_bounds_directory_entries();
> >    up_read(mm->mmap_sem);
> >    do_the_real_shm_unmap();
> >    up_write(mm->bd_sem);
> > 
> > That should still be covered by the above scheme.
> 
> Yep, that'll work.  It just means rewriting the shmdt()/mremap() code to
> do a "dry run" of sorts.

Right. So either that or we hold bd_sem write locked accross all write
locked mmap_sem sections. Dunno, which solution is prettier :)

> Do you have any concerns about adding another mutex to these paths?

You mean bd_sem? I don't think its an issue. You need to get mmap_sem
for write as well. So 

> munmap() isn't as hot of a path as the allocation side, but it does
> worry me a bit that we're going to perturb some workloads.  We might
> need to find a way to optimize out the bd_sem activity on processes that
> never used MPX.

I think using mm->bd_addr as a conditional for the bd_sem/mpx activity
is good enough. You just need to make sure that you store the result
of the starting conditional and use it for the closing one as well.

   mpx = mpx_pre_unmap(mm);
       {
	  if (!kernel_managing_bounds_tables(mm)
       	     return 0;
	  down_write(mm->bd_sem);
	  ...
	  return 1;
       }

   unmap();

   mxp_post_unmap(mm, mpx);
       {
          if (mpx) {
	     ....
	     up_write(mm->bd_sem);
       }

So this serializes nicely with the bd_sem protected write to
mm->bd_addr. There is a race there, but I don't think it matters. The
worst thing what can happen is a stale bound table.

Thanks,

	tglx
