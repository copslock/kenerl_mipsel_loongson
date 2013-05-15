Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 20:36:35 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:57291 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6824758Ab3EOSgMtFI0G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 20:36:12 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 15 May 2013 11:36:04 -0700
Subject: Re: [PATCH 2/2] KVM/MIPS32: Wrap calls to gfn_to_pfn() with srcu_read_lock/unlock()
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130515173039.GC24814@redhat.com>
Date:   Wed, 15 May 2013 11:36:02 -0700
Cc:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Marcelo Tosatti <mtosatti@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tony Luck <tony.luck@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Transfer-Encoding: 8BIT
Message-Id: <057877F0-D213-4D46-963D-9600735844A4@kymasys.com>
References: <n> <1368476500-20031-1-git-send-email-sanjayl@kymasys.com> <1368476500-20031-3-git-send-email-sanjayl@kymasys.com> <20130514092705.GD20995@redhat.com> <63B7D172-E75E-4AB4-8515-9A18360B66A2@kymasys.com> <5193BDC0.6090103@gmail.com> <20130515173039.GC24814@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36410
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


On May 15, 2013, at 10:30 AM, Gleb Natapov wrote:

> On Wed, May 15, 2013 at 09:54:24AM -0700, David Daney wrote:
>> On 05/15/2013 08:54 AM, Sanjay Lal wrote:
>>> 
>>> On May 14, 2013, at 2:27 AM, Gleb Natapov wrote:
>>> 
>>>>> 
>>>>> 
>>>>> +EXPORT_SYMBOL(min_low_pfn);     /* defined by bootmem.c, but not exported by generic code */
>>>>> +
>>>> What you need this for? It is not used anywhere in this patch and by
>>>> mips/kvm code in general.
>>> 
>>> I did some digging around myself, since the linker keeps complaining that it can't find min_low_pfn when compiling the KVM module.  It seems that it is indirectly pulled in by the cache management functions.
>>> 
>> 
>> If it is really needed, then the export should probably be done at
>> the site of the min_low_pfn definition, not in some random
>> architecture file.
>> 
> Definitely. We cannot snick it here like that. Please drop it from this
> patch.
> 

I did export min_low_pfn where it was defined (in .../mm/bootmem.c) as part of the original patch set. It conflicted with the ia64/metag ports.  min_low_pfn is exported in arch/ia64/kernel/ia64_ksyms.c and in arch/metag/kernel/metag_ksyms.c.

There was some chatter about this when the KVM/MIPS code ended up in linux-next.  From what I can gather, the maintainers for the other architectures agreed that exporting this symbol in bootmem.c was fine and should flow from the MIPS tree.  I'll do that as part of v2 of the patch set.

Regards
Sanjay
