Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 19:24:03 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:20995 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbcJSRX5YxzQv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 19:23:57 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP; 19 Oct 2016 10:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,367,1473145200"; 
   d="scan'208";a="21749372"
Received: from ray.jf.intel.com (HELO [10.7.201.146]) ([10.7.201.146])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2016 10:23:55 -0700
Subject: Re: [PATCH 00/10] mm: adjust get_user_pages* functions to explicitly
 pass FOLL_* flags
To:     Michal Hocko <mhocko@kernel.org>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161018153050.GC13117@dhcp22.suse.cz> <20161019085815.GA22239@lucifer>
 <20161019090727.GE7517@dhcp22.suse.cz> <5807A427.7010200@linux.intel.com>
 <20161019170127.GN24393@dhcp22.suse.cz>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <5807AC2B.4090208@linux.intel.com>
Date:   Wed, 19 Oct 2016 10:23:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20161019170127.GN24393@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55518
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

On 10/19/2016 10:01 AM, Michal Hocko wrote:
> The question I had earlier was whether this has to be an explicit FOLL
> flag used by g-u-p users or we can just use it internally when mm !=
> current->mm

The reason I chose not to do that was that deferred work gets run under
a basically random 'current'.  If we just use 'mm != current->mm', then
the deferred work will sometimes have pkeys enforced and sometimes not,
basically randomly.

We want to be consistent with whether they are enforced or not, so we
explicitly indicate that by calling the remote variant vs. plain.
