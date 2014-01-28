Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2014 17:21:37 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:64985 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823127AbaA1QVeHigGI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Jan 2014 17:21:34 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s0SGLHUo000909
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 28 Jan 2014 08:21:18 -0800 (PST)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.347.0; Tue, 28 Jan 2014
 08:21:18 -0800
Message-ID: <52E7D918.5020704@windriver.com>
Date:   Tue, 28 Jan 2014 11:21:44 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-arch@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-m68k@vger.kernel.org>, <rusty@rustcorp.com.au>,
        <linux-ia64@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <linux-alpha@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <akpm@linux-foundation.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 00/73] tree-wide: clean up some no longer required
 #include <linux/init.h>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>      <20140122180023.dd90d34cba38d9f9ac516349@canb.auug.org.au>      <20140123003838.GA10182@windriver.com> <1390878783.3872.63.camel@pasglop>
In-Reply-To: <1390878783.3872.63.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.146.65]
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

On 14-01-27 10:13 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2014-01-22 at 19:38 -0500, Paul Gortmaker wrote:
> 
>> Thanks, it was a great help as it uncovered a few issues in fringe arch
>> that I didn't have toolchains for, and I've fixed all of those up.
>>
>> I've noticed that powerpc has been un-buildable for a while now; I have
>> used this hack patch locally so I could run the ppc defconfigs to check
>> that I didn't break anything.  Maybe useful for linux-next in the
>> interim?  It is a hack patch -- Not-Signed-off-by: Paul Gortmaker.  :)
> 
> Can you and/or Aneesh submit that as a proper patch (with S-O-B
> etc...) ?

I'd updated toolchains and didn't realize it was still broken.  Patch sent.

http://patchwork.ozlabs.org/patch/314749/

Paul.
--

> 
> Thanks !
> 
> Cheers,
> Ben.
> 
>> Paul.
>> --
>>
>> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
>> index d27960c89a71..d0f070a2b395 100644
>> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
>> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
>> @@ -560,9 +560,9 @@ extern void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
>>  			    pmd_t *pmdp);
>>  
>>  #define pmd_move_must_withdraw pmd_move_must_withdraw
>> -typedef struct spinlock spinlock_t;
>> -static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
>> -					 spinlock_t *old_pmd_ptl)
>> +struct spinlock;
>> +static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>> +					 struct spinlock *old_pmd_ptl)
>>  {
>>  	/*
>>  	 * Archs like ppc64 use pgtable to store per pmd
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
