Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 03:56:39 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:54519 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993115AbcKKC4dE4Ytr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2016 03:56:33 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 10 Nov 2016 18:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,620,1473145200"; 
   d="scan'208";a="785130503"
Received: from sandyjin-mobl2.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.212.70])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2016 18:56:22 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.87)
        (envelope-from <fengguang.wu@intel.com>)
        id 1c520r-0002xF-RM; Fri, 11 Nov 2016 10:56:21 +0800
Date:   Fri, 11 Nov 2016 10:56:21 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Paul Burton <Paul.Burton@imgtec.com>
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
Message-ID: <20161111025621.vwa3irwbj56uezhl@wfg-t540p.sh.intel.com>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
 <6066667d-e62d-bfec-ca3e-f16f8bef912d@suse.cz>
 <20161109220043.GA7075@jhogan-linux.le.imgtec.org>
 <20161110060843.GA28639@kroah.com>
 <20161110173721.GD7075@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20161110173721.GD7075@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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

Hi James,

On Thu, Nov 10, 2016 at 05:37:22PM +0000, James Hogan wrote:
>Hi Fengguang,
>
>On Thu, Nov 10, 2016 at 07:08:43AM +0100, Greg KH wrote:
>> On Wed, Nov 09, 2016 at 10:00:43PM +0000, James Hogan wrote:
>> > On Wed, Nov 09, 2016 at 10:22:01PM +0100, Jiri Slaby wrote:
>> > > On 11/09/2016, 03:46 PM, James Hogan wrote:
>> > > > Unfortunately the original commit went in to v3.12.65 as commit
>> > > > 168e5ebbd63e, without fixing up the references to tlb_lo[0/1] to
>> > > > tlb_lo0/1 which broke the MIPS KVM build, and I didn't twig that I
>> > > > already had a correct backport outstanding (sorry!). That commit should
>> > > > be reverted before applying this backport to 3.12.
>> > >
>> > > Thanks, reverted and applied. I wonder the builders didn't break given 4
>> > > mips configurations are tested. I indeed could reproduce locally.
>> >
>> > I'm guessing malta_kvm_defconfig isn't one of those defconfigs (and the
>> > imgtec buildbots don't yet test stable branches). Which builders do you
>> > use?
>>
>> I use 0-day for these types of things, and it is not showing up any
>> errors for the 4.4-stable kernel.  Can you get these configurations
>> added to it so that we can ensure it doesn't regress?
>
>Can we please get a few MIPS defconfigs added to the 0-day testing?

The 0-day build bot should already cover the below configs (not
necessarily in the early hours, but very likely in the first day after
your git push) since they are included in arch/*/configs/. I wonder
where you test your patches?  Let me check how they missed the test
coverage.

>- malta_kvm_defconfig
>  this probably doesn't need to be a high priority build, but other
>  configs don't yet cover MIPS KVM so its worth having (that bit us
>  recently with 3.12 and 4.4 stable branches).
>
>- 64r6el_defconfig and 32r2_defconfig (4.9 and later)
>  these are just a couple of the new generic/multiplatform kernel
>  configurations added in 4.9 (Paul Burton Cc'd). There are others too,
>  but these will probably give decent coverage. These are likely to be
>  increasingly relevant as more/new platforms are converted to use it.
>  (note, the r6 one may require a newish toolchain).

Thanks,
Fengguang
