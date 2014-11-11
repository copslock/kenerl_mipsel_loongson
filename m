Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 21:44:14 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:10832 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013227AbaKKUoMebGfR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 21:44:12 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 11 Nov 2014 12:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,362,1413270000"; 
   d="scan'208";a="635280383"
Received: from justinda-mobl1.ger.corp.intel.com (HELO [10.255.13.126]) ([10.255.13.126])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2014 12:44:02 -0800
Message-ID: <54627512.7060806@intel.com>
Date:   Tue, 11 Nov 2014 12:44:02 -0800
From:   Dave Hansen <dave.hansen@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Qiaowei Ren <qiaowei.ren@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v9 11/12] x86, mpx: cleanup unused bound tables
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com> <1413088915-13428-12-git-send-email-qiaowei.ren@intel.com> <alpine.DEB.2.11.1410241451280.5308@nanos> <545BED0B.8000001@intel.com> <alpine.DEB.2.11.1411111213450.3935@nanos>
In-Reply-To: <alpine.DEB.2.11.1411111213450.3935@nanos>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dave.hansen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave.hansen@intel.com
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

On 11/11/2014 10:27 AM, Thomas Gleixner wrote:
> On Thu, 6 Nov 2014, Dave Hansen wrote:
>> Instead of all of these games with dropping and reacquiring mmap_sem and
>> adding other locks, or deferring the work, why don't we just do a
>> get_user_pages()?  Something along the lines of:
>>
>> while (1) {
>> 	ret = cmpxchg(addr)
>> 	if (!ret)
>> 		break;
>> 	if (ret == -EFAULT)
>> 		get_user_pages(addr);
>> }
>>
>> Does anybody see a problem with that?
> 
> You want to do that under mmap_sem write held, right? Not a problem per
> se, except that you block normal faults for a possibly long time when
> the page(s) need to be swapped in.

Yeah, it might hold mmap_sem for write while doing this in the unmap
path.  But, that's only if the bounds directory entry has been swapped
out.  There's only 1 pointer of bounds directory entries there for every
1MB of data, so it _should_ be relatively rare.  It would mean that
nobody's been accessing a 512MB swath of data controlled by the same
page of the bounds directory.

If it gets to be an issue, we can always add some code to fault it in
before mmap_sem is acquired.

FWIW, I believe we have a fairly long road ahead of us to optimize MPX
in practice.  I have a list of things I want to go investigate, but I
have not looked in to it in detail at all.

> But yes, this might solve most of the issues at hand. Did not think
> about GUP at all :(

Whew.  Fixing it was getting nasty and complicated. :)
