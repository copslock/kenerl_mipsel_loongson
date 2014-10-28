Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 07:00:32 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:62109 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010998AbaJ1GA26FgOV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 07:00:28 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 27 Oct 2014 23:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="407084852"
Received: from rqw-ubuntu.sh.intel.com (HELO [10.239.37.69]) ([10.239.37.69])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2014 22:52:20 -0700
Message-ID: <544F303C.10903@intel.com>
Date:   Tue, 28 Oct 2014 13:57:16 +0800
From:   Ren Qiaowei <qiaowei.ren@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v9 10/12] x86, mpx: add prctl commands PR_MPX_ENABLE_MANAGEMENT,
 PR_MPX_DISABLE_MANAGEMENT
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-11-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241436560.5308@nanos> <9E0BE1322F2F2246BD820DA9FC397ADE0180ED65@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.11.1410272137140.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410272137140.5308@nanos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43612
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

On 10/28/2014 04:38 AM, Thomas Gleixner wrote:
> On Mon, 27 Oct 2014, Ren, Qiaowei wrote:
>> On 2014-10-24, Thomas Gleixner wrote:
>>> On Sun, 12 Oct 2014, Qiaowei Ren wrote:
>>>> +int mpx_enable_management(struct task_struct *tsk) {
>>>> +	struct mm_struct *mm = tsk->mm;
>>>> +	void __user *bd_base = MPX_INVALID_BOUNDS_DIR;
>>>
>>> What's the point of initializing bd_base here. I had to look twice to
>>> figure out that it gets overwritten by task_get_bounds_dir()
>>>
>>
>> I just want to put task_get_bounds_dir() outside mm->mmap_sem holding.
>
> What you want is not interesting at all. What's interesting is what
> you do and what you send for review.
>

I see. Thanks.

- Qiaowei
