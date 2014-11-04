Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 17:00:43 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:25779 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012586AbaKDQAfcsjF1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Nov 2014 17:00:35 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 04 Nov 2014 08:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="411230156"
Received: from unknown (HELO [10.255.13.105]) ([10.255.13.105])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2014 07:51:59 -0800
Message-ID: <5458F819.2010503@intel.com>
Date:   Tue, 04 Nov 2014 08:00:25 -0800
From:   Dave Hansen <dave.hansen@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ren Qiaowei <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <544DB873.1010207@intel.com> <alpine.DEB.2.11.1410272138540.5308@nanos> <5457EB67.70904@intel.com> <alpine.DEB.2.11.1411032205320.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1411032205320.5308@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43868
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

On 11/03/2014 01:29 PM, Thomas Gleixner wrote:
> On Mon, 3 Nov 2014, Dave Hansen wrote:

> That's not really true. You can evaluate that information with
> mmap_sem held for read as well. Nothing can change the mappings until
> you drop it. So you could do:
> 
>    down_write(mm->bd_sem);
>    down_read(mm->mmap_sem;
>    evaluate_size_of_shm_to_unmap();
>    clear_bounds_directory_entries();
>    up_read(mm->mmap_sem);
>    do_the_real_shm_unmap();
>    up_write(mm->bd_sem);
> 
> That should still be covered by the above scheme.

Yep, that'll work.  It just means rewriting the shmdt()/mremap() code to
do a "dry run" of sorts.

Do you have any concerns about adding another mutex to these paths?
munmap() isn't as hot of a path as the allocation side, but it does
worry me a bit that we're going to perturb some workloads.  We might
need to find a way to optimize out the bd_sem activity on processes that
never used MPX.
