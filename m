Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 18:49:59 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:46773 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991978AbcJSQtvQY-eb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 18:49:51 +0200
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP; 19 Oct 2016 09:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,367,1473145200"; 
   d="scan'208";a="21413430"
Received: from ray.jf.intel.com (HELO [10.7.201.146]) ([10.7.201.146])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2016 09:49:43 -0700
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
To:     Michal Hocko <mhocko@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz> <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <5807A427.7010200@linux.intel.com>
Date:   Wed, 19 Oct 2016 09:49:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20161019090727.GE7517@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.hansen@linux.intel.com
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

On 10/19/2016 02:07 AM, Michal Hocko wrote:
> On Wed 19-10-16 09:58:15, Lorenzo Stoakes wrote:
>> On Tue, Oct 18, 2016 at 05:30:50PM +0200, Michal Hocko wrote:
>>> I am wondering whether we can go further. E.g. it is not really clear to
>>> me whether we need an explicit FOLL_REMOTE when we can in fact check
>>> mm != current->mm and imply that. Maybe there are some contexts which
>>> wouldn't work, I haven't checked.
>>
>> This flag is set even when /proc/self/mem is used. I've not looked deeply into
>> this flag but perhaps accessing your own memory this way can be considered
>> 'remote' since you're not accessing it directly. On the other hand, perhaps this
>> is just mistaken in this case?
> 
> My understanding of the flag is quite limited as well. All I know it is
> related to protection keys and it is needed to bypass protection check.
> See arch_vma_access_permitted. See also 1b2ee1266ea6 ("mm/core: Do not
> enforce PKEY permissions on remote mm access").

Yeah, we need the flag to tell us when PKEYs should be applied or not.
The current task's PKRU (pkey rights register) should really only be
used to impact access to the task's memory, but has no bearing on how a
given task should access remote memory.
