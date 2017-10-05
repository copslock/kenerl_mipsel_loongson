Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 01:27:39 +0200 (CEST)
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:3840
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993608AbdJEX12QHcgX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 01:27:28 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CBAAAev9ZZ/zXSMGcNTxkBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYRBgRWDeppHAQEBBoEACSKYNQwiC4UYAoReFAECAQEBAQEBAYY?=
 =?us-ascii?q?rAQEBAQIBASJWBQsLDQsCAiYCAigvBgEMCAEBih8FGKVVa4InIosLAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBGwWBDoIfgwuCMisLgnOIF4JhBaEyAYdehn8rh3GFb4NxDYc?=
 =?us-ascii?q?JSJZKNoEvMiEIKgiHeGQBiQQBAQE?=
X-IPAS-Result: =?us-ascii?q?A2CBAAAev9ZZ/zXSMGcNTxkBAQEBAQEBAQEBAQcBAQEBAYR?=
 =?us-ascii?q?BgRWDeppHAQEBBoEACSKYNQwiC4UYAoReFAECAQEBAQEBAYYrAQEBAQIBASJWB?=
 =?us-ascii?q?QsLDQsCAiYCAigvBgEMCAEBih8FGKVVa4InIosLAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BGwWBDoIfgwuCMisLgnOIF4JhBaEyAYdehn8rh3GFb4NxDYcJSJZKNoEvMiEIK?=
 =?us-ascii?q?giHeGQBiQQBAQE?=
X-IronPort-AV: E=Sophos;i="5.42,482,1500912000"; 
   d="scan'208";a="10046150"
Received: from unknown (HELO [172.16.0.22]) ([103.48.210.53])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 06 Oct 2017 07:27:16 +0800
Subject: Re: [PATCH 06/11] MIPS: cmpxchg: Implement __cmpxchg() as a function
To:     Paul Burton <Paul.Burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <49fe6972-163d-3459-6963-582ffcc35b19@linux-m68k.org>
 <D4E56584A8AFC94F836003742821EF82705B9658@badag02.ba.imgtec.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <7207ebdc-ccac-9192-5a99-5aee28f625ff@linux-m68k.org>
Date:   Fri, 6 Oct 2017 09:27:14 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <D4E56584A8AFC94F836003742821EF82705B9658@badag02.ba.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@linux-m68k.org
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

Hi Paul,

On 05/10/17 17:07, Paul Burton wrote:
>> On Fri, 9 Jun 2017 17:26:38 -0700, Paul Burton wrote:
>>> Replace the macro definition of __cmpxchg() with an inline function,
>>> which is easier to read & modify. The cmpxchg() & cmpxchg_local()
>>> macros are adjusted to call the new __cmpxchg() function.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@xxxxxxxxxx>
>>> Cc: Ralf Baechle <ralf@xxxxxxxxxxxxxx>
>>> Cc: linux-mips@xxxxxxxxxxxxxx
>>
>> I think this patch is breaking user space for me. I say "think"
>> because it is a bit tricky to bisect for the few patches previous to this one
>> since they won't compile cleanly for me (due to this
>> https://www.spinics.net/lists/mips/msg68727.html).
>>
>> I have a Cavium Octeon 5010 MIPS64 CPU on a custom board, have been
>> running it for years running various kernel versions. Linux-4.13 breaks for me,
>> and I bisected back to this change.
>>
>> What I see is user space bomb strait after boot with console messages like
>> this:
>>
>> mount[37] killed because of sig - 11
>>
>> STACK DUMP:
>> <snip>
>>
>> I get a lot of them from various programs running from rc scripts.
>> It never manages to fully boot to login/shell.
>>
>> If I take the linux-4.12 arch/mips/include/asm/cmpxchg.h and drop that in
>> place on a linux-4.13 (or even linux-4.14-rc3) I can compile and run everything
>> successfully.
>>
>> Any thoughts?
> 
> Are you running a uniprocessor/non-SMP kernel?

Yes, CONFIG_SMP not set.


> Could you try this fix I submitted this fix 5 weeks ago:
> 
> https://patchwork.linux-mips.org/patch/17226/

Yep, that fixes it. Thanks for the quick response.


> Ralf: Could we get that merged please?

Since this is a problem in linux-4.13 then a candidate for linux-4.13 stable too?

Regards
Greg
