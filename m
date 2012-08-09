Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2012 17:24:29 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:57096 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1902233Ab2HIPYZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2012 17:24:25 +0200
Received: from tazenda.hos.anvin.org (c-67-188-81-177.hsd1.ca.comcast.net [67.188.81.177])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id q79FO03I011107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=OK);
        Thu, 9 Aug 2012 08:24:01 -0700
Message-ID: <5023D60F.7010009@zytor.com>
Date:   Thu, 09 Aug 2012 08:23:59 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alex Shi <alex.shu@intel.com>,
        Jan Beulich <jbeulich@novell.com>,
        Robert Richter <robert.richter@amd.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com> <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 34083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/09/2012 08:03 AM, Kirill A. Shutemov wrote:
> From: Andi Kleen <ak@linux.intel.com>
>
> Add a cache avoiding version of clear_page. Straight forward integer variant
> of the existing 64bit clear_page, for both 32bit and 64bit.
>
> Also add the necessary glue for highmem including a layer that non cache
> coherent architectures that use the virtual address for flushing can
> hook in. This is not needed on x86 of course.
>
> If an architecture wants to provide cache avoiding version of clear_page
> it should to define ARCH_HAS_USER_NOCACHE to 1 and implement
> clear_page_nocache() and clear_user_highpage_nocache().
>

Compile failure:

/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c: In function 
‘clear_user_highpage_nocache’:
/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:1215:30: error: 
‘KM_USER0’ undeclared (first use in this function)
/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:1215:30: note: each 
undeclared identifier is reported only once for each function it appears in
/home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:1215:2: error: too many 
arguments to function ‘kmap_atomic’
In file included from 
/home/hpa/kernel/tip.x86-mm/include/linux/pagemap.h:10:0,
                  from 
/home/hpa/kernel/tip.x86-mm/include/linux/mempolicy.h:70,
                  from 
/home/hpa/kernel/tip.x86-mm/include/linux/hugetlb.h:15,
                  from /home/hpa/kernel/tip.x86-mm/arch/x86/mm/fault.c:14:
/home/hpa/kernel/tip.x86-mm/include/linux/highmem.h:66:21: note: 
declared here
make[4]: *** [arch/x86/mm/fault.o] Error 1
make[3]: *** [arch/x86/mm] Error 2
make[2]: *** [arch/x86] Error 2
make[1]: *** [sub-make] Error 2
make[1]: Leaving directory `/home/hpa/kernel/tip.x86-mm'

This happens on *all* my test configurations, including both x86-64 and 
i386 allyesconfig.  I suspect your patchset base is stale.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
