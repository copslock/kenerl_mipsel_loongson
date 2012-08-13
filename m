Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 18:28:11 +0200 (CEST)
Received: from mga03.intel.com ([143.182.124.21]:64830 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903392Ab2HMQ2C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Aug 2012 18:28:02 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 13 Aug 2012 09:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,761,1336374000"; 
   d="scan'208";a="180458204"
Received: from tassilo.jf.intel.com ([10.7.201.151])
  by azsmga001.ch.intel.com with ESMTP; 13 Aug 2012 09:27:53 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
        id 9CCDE2418D0; Mon, 13 Aug 2012 09:27:53 -0700 (PDT)
Date:   Mon, 13 Aug 2012 09:27:53 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Jan Beulich <JBeulich@suse.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Robert Richter <robert.richter@amd.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Alex Shi <alex.shu@intel.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        x86@kernel.org, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/6] x86: Add clear_page_nocache
Message-ID: <20120813162753.GM2644@tassilo.jf.intel.com>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-5-git-send-email-kirill.shutemov@linux.intel.com>
 <5023F1BC0200007800093EF0@nat28.tlf.novell.com>
 <20120813114334.GA21855@otc-wbsnb-06>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120813114334.GA21855@otc-wbsnb-06>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@linux.intel.com
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

> Moving 64 bytes per cycle is faster on Sandy Bridge, but slower on
> Westmere. Any preference? ;)

You have to be careful with these benchmarks.

- You need to make sure the data is cache cold, cache hot is misleading.
- The numbers can change if you have multiple CPUs doing this in parallel.

-Andi
