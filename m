Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 07:01:34 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:47879 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010998AbaJ1GBd2zY0h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 07:01:33 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 27 Oct 2014 23:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="407085163"
Received: from rqw-ubuntu.sh.intel.com (HELO [10.239.37.69]) ([10.239.37.69])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2014 22:53:25 -0700
Message-ID: <544F307D.7090701@intel.com>
Date:   Tue, 28 Oct 2014 13:58:21 +0800
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
Subject: Re: [PATCH v9 09/12] x86, mpx: decode MPX instruction to get bound
 violation information
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-10-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241408360.5308@nanos> <9E0BE1322F2F2246BD820DA9FC397ADE0180ED16@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.11.1410272135420.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410272135420.5308@nanos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43613
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

On 10/28/2014 04:36 AM, Thomas Gleixner wrote:
> On Mon, 27 Oct 2014, Ren, Qiaowei wrote:
>> On 2014-10-24, Thomas Gleixner wrote:
>>> On Sun, 12 Oct 2014, Qiaowei Ren wrote:
>>>
>>>> This patch sets bound violation fields of siginfo struct in #BR
>>>> exception handler by decoding the user instruction and constructing
>>>> the faulting pointer.
>>>>
>>>> This patch does't use the generic decoder, and implements a limited
>>>> special-purpose decoder to decode MPX instructions, simply because
>>>> the generic decoder is very heavyweight not just in terms of
>>>> performance but in terms of interface -- because it has to.
>>>
>>> My question still stands why using the existing decoder is an issue.
>>> Performance is a complete non issue in case of a bounds violation and
>>> the interface argument is just silly, really.
>>>
>>
>> As hpa said, we only need to decode several mpx instructions
>> including BNDCL/BNDCU, and general decoder looks like a little
>> heavy. Peter, what do you think about it?
>
> You're repeating yourself. Care to read the discussion about this from
> the last round of review again?
>

Ok. I will go through it again. Thanks.

- Qiaowei
