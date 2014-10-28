Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 06:59:43 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:12449 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010998AbaJ1F7lTVrE3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 06:59:41 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 27 Oct 2014 22:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="407084556"
Received: from rqw-ubuntu.sh.intel.com (HELO [10.239.37.69]) ([10.239.37.69])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2014 22:51:31 -0700
Message-ID: <544F300B.7050002@intel.com>
Date:   Tue, 28 Oct 2014 13:56:27 +0800
From:   Ren Qiaowei <qiaowei.ren@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <544DB873.1010207@intel.com> <alpine.DEB.2.11.1410272138540.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410272138540.5308@nanos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qiaowei.ren@intel.com
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

On 10/28/2014 04:49 AM, Thomas Gleixner wrote:
> On Mon, 27 Oct 2014, Ren Qiaowei wrote:
>> If so, I guess that there are some questions needed to be considered:
>>
>> 1) Almost all palces which call do_munmap() will need to add
>> mpx_pre_unmap/post_unmap calls, like vm_munmap(), mremap(), shmdt(), etc..
>
> What's the problem with that?
>

For example:

shmdt()
     down_write(mm->mmap_sem);
     vma = find_vma();
     while (vma)
         do_munmap();
     up_write(mm->mmap_sem);

We could not simply add mpx_pre_unmap() before do_munmap() or 
down_write(). And seems like it is a little hard for shmdt() to be 
changed to match this solution, right?

>> 2) before mpx_post_unmap() call, it is possible for those bounds tables within
>> mm->bd_remove_vmas to be re-used.
>>
>> In this case, userspace may do new mapping and access one address which will
>> cover one of those bounds tables. During this period, HW will check if one
>> bounds table exist, if yes one fault won't be produced.
>
> Errm. Before user space can use the bounds table for the new mapping
> it needs to add the entries, right? So:
>
> CPU 0					CPU 1
>
> down_write(mm->bd_sem);
> mpx_pre_unmap();
>     clear bounds directory entries	
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
>

Yes. Got it.

>> 3) According to Dave, those bounds tables related to adjacent VMAs within the
>> start and the end possibly don't have to be fully unmmaped, and we only need
>> free the part of backing physical memory.
>
> Care to explain why that's a problem?
>

I guess you mean one new field mm->bd_remove_vmas should be added into 
staruct mm, right?

For those VMAs which we only need to free part of backing physical 
memory, we could not clear bounds directory entries and should also mark 
the range of backing physical memory within this vma. If so, maybe there 
are too many new fields which will be added into mm struct, right?

Thanks,
Qiaowei
