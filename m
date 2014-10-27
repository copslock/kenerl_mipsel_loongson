Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 03:20:36 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:40692 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010898AbaJ0CUfNS1hh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 03:20:35 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 26 Oct 2014 19:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,792,1406617200"; 
   d="scan'208";a="611820582"
Received: from pgsmsx101.gar.corp.intel.com ([10.221.44.78])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2014 19:20:24 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Mon, 27 Oct 2014 10:17:59 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.156]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.13]) with mapi id 14.03.0195.001;
 Mon, 27 Oct 2014 10:17:58 +0800
From:   "Ren, Qiaowei" <qiaowei.ren@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v9 10/12] x86, mpx: add prctl commands
 PR_MPX_ENABLE_MANAGEMENT, PR_MPX_DISABLE_MANAGEMENT
Thread-Topic: [PATCH v9 10/12] x86, mpx: add prctl commands
 PR_MPX_ENABLE_MANAGEMENT, PR_MPX_DISABLE_MANAGEMENT
Thread-Index: AQHP5dg89KIANMH5bE2fxw5ikPyI75w+wDaAgASLc3A=
Date:   Mon, 27 Oct 2014 02:17:58 +0000
Message-ID: <9E0BE1322F2F2246BD820DA9FC397ADE0180ED65@shsmsx102.ccr.corp.intel.com>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com>
 <1413088915-13428-11-git-send-email-qiaowei.ren@intel.com>
 <alpine.DEB.2.11.1410241436560.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410241436560.5308@nanos>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43571
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



On 2014-10-24, Thomas Gleixner wrote:
> On Sun, 12 Oct 2014, Qiaowei Ren wrote:
>> +int mpx_enable_management(struct task_struct *tsk) {
>> +	struct mm_struct *mm = tsk->mm;
>> +	void __user *bd_base = MPX_INVALID_BOUNDS_DIR;
> 
> What's the point of initializing bd_base here. I had to look twice to
> figure out that it gets overwritten by task_get_bounds_dir()
> 

I just want to put task_get_bounds_dir() outside mm->mmap_sem holding.

>> @@ -285,6 +285,7 @@ dotraplinkage void do_bounds(struct pt_regs
>> *regs,
> long error_code)
>>  	struct xsave_struct *xsave_buf;
>>  	struct task_struct *tsk = current;
>>  	siginfo_t info;
>> +	int ret = 0;
>> 
>>  	prev_state = exception_enter();
>>  	if (notify_die(DIE_TRAP, "bounds", regs, error_code, @@ -312,8
>> +313,35 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long
> error_code)
>>  	 */
>>  	switch (status & MPX_BNDSTA_ERROR_CODE) {
>>  	case 2: /* Bound directory has invalid entry. */
>> -		if (do_mpx_bt_fault(xsave_buf))
>> +		down_write(&current->mm->mmap_sem);
> 
> The handling of mm->mmap_sem here is horrible. The only reason why you
> want to hold mmap_sem write locked in the first place is that you want
> to cover the allocation and the mm->bd_addr check.
> 
> I think it's wrong to tie this to mmap_sem in the first place. If MPX
> is enabled then you should have mm->bd_addr and an explicit mutex to protect it.
> 
> So the logic would look like this:
> 
>    mutex_lock(&mm->bd_mutex);
>    if (!kernel_managed(mm))
>       do_trap(); else if (do_mpx_bt_fault()) force_sig();
>    mutex_unlock(&mm->bd_mutex);
> No tricks with mmap_sem, no special return value handling. Straight
> forward code instead of a convoluted and error prone mess.
> 
> Hmm?
> 
I guess this is a good solution. If so, new field 'bd_sem' have to be added into struct mm_struct.

Thanks,
Qiaowei
