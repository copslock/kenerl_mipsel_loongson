Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 16:36:42 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:54119 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835041Ab3ESOglxUbdq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 May 2013 16:36:41 +0200
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Sun, 19 May 2013 07:36:33 -0700
Subject: Re: [PATCH 2/4] KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130519125210.GI4725@redhat.com>
Date:   Sun, 19 May 2013 10:36:32 -0400
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        ralf@linux-mips.org, mtosatti@redhat.com
Content-Transfer-Encoding: 8BIT
Message-Id: <AB98FD4C-123F-4C64-B6CF-0F86E4EBD554@kymasys.com>
References: <n> <1368885266-8619-1-git-send-email-sanjayl@kymasys.com> <1368885266-8619-3-git-send-email-sanjayl@kymasys.com> <20130519125210.GI4725@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On May 19, 2013, at 8:52 AM, Gleb Natapov wrote:

> On Sat, May 18, 2013 at 06:54:24AM -0700, Sanjay Lal wrote:
>> - As suggested by Gleb, wrap calls to gfn_to_pfn() with srcu_read_lock/unlock().
>>  Memory slots should be acccessed from a SRCU read section.
>> - kvm_mips_map_page() now returns an error code to it's callers, instead of calling panic()
>> if it cannot find a mapping for a particular gfn.
>> 
>> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
>> ---
>> arch/mips/kvm/kvm_tlb.c | 36 +++++++++++++++++++++++++++---------
>> 1 file changed, 27 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
>> index 89511a9..ab2e9b0 100644
>> --- a/arch/mips/kvm/kvm_tlb.c
>> +++ b/arch/mips/kvm/kvm_tlb.c
>> @@ -16,7 +16,10 @@
>> #include <linux/mm.h>
>> #include <linux/delay.h>
>> #include <linux/module.h>
>> +#include <linux/bootmem.h>
> You haven't answered it when I asked it on v2:
> Is this include still needed now when export of min_low_pfn is not
> longer here?
> 

Sorry about that, juggling too many patches, bootmem.h is no longer needed in kvm_tlb.c.  Actually, I thought I had removed it before posting v3.

Regards
Sanjay
