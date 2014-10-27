Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 04:23:46 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:7766 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010918AbaJ0DXpXvl9Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Oct 2014 04:23:45 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 26 Oct 2014 20:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="406471914"
Received: from rqw-ubuntu.sh.intel.com (HELO [10.239.37.69]) ([10.239.37.69])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2014 20:15:40 -0700
Message-ID: <544DBA03.1010709@intel.com>
Date:   Mon, 27 Oct 2014 11:20:35 +0800
From:   Ren Qiaowei <qiaowei.ren@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 05/12] x86, mpx: on-demand kernel allocation of bounds
 tables
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-6-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241257300.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410241257300.5308@nanos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43573
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

On 10/24/2014 08:08 PM, Thomas Gleixner wrote:
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
>

Well, we will address it.

Thanks,
Qiaowei
