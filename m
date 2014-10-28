Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 18:43:59 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:53466 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011669AbaJ1Rn6IYgZT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 18:43:58 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 28 Oct 2014 10:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,804,1406617200"; 
   d="scan'208";a="597816713"
Received: from ray.jf.intel.com (HELO [10.7.199.163]) ([10.7.199.163])
  by orsmga001.jf.intel.com with ESMTP; 28 Oct 2014 10:43:48 -0700
Message-ID: <544FD5D4.4090404@intel.com>
Date:   Tue, 28 Oct 2014 10:43:48 -0700
From:   Dave Hansen <dave.hansen@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>,
        Qiaowei Ren <qiaowei.ren@intel.com>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 05/12] x86, mpx: on-demand kernel allocation of bounds
 tables
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-6-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241257300.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410241257300.5308@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43646
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

On 10/24/2014 05:08 AM, Thomas Gleixner wrote:
> On Sun, 12 Oct 2014, Qiaowei Ren wrote:
>> +	/*
>> +	 * Go poke the address of the new bounds table in to the
>> +	 * bounds directory entry out in userspace memory.  Note:
>> +	 * we may race with another CPU instantiating the same table.
>> +	 * In that case the cmpxchg will see an unexpected
>> +	 * 'actual_old_val'.
>> +	 */
>> +	ret = user_atomic_cmpxchg_inatomic(&actual_old_val, bd_entry,
>> +					   expected_old_val, bt_addr);
> 
> This is fully preemptible non-atomic context, right?
> 
> So this wants a proper comment, why using
> user_atomic_cmpxchg_inatomic() is the right thing to do here.

Hey Thomas,

How's this for a new comment?  Does this cover the points you think need
clarified?

====

The kernel has allocated a bounds table and needs to point the
(userspace-allocated) directory to it.  The directory entry is the
*only* place we track that this table was allocated, so we essentially
use it instead of an kernel data structure for synchronization.  A
copy_to_user()-style function would not give us the atomicity that we need.

If two threads race to instantiate a table, the cmpxchg ensures we know
which one lost the race and that the loser frees the table that they
just allocated.
