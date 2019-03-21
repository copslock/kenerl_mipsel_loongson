Return-Path: <SRS0=ObrZ=RY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A02C4360F
	for <linux-mips@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CA721902
	for <linux-mips@archiver.kernel.org>; Thu, 21 Mar 2019 16:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfCUQmH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:42:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:44615 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfCUQmH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 21 Mar 2019 12:42:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 09:42:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="157098973"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2019 09:42:05 -0700
Date:   Thu, 21 Mar 2019 01:40:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RESEND PATCH 0/7] Add FOLL_LONGTERM to GUP fast and use it
Message-ID: <20190321084048.GA26439@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190319151930.bab575d62fb1a33094160fe3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319151930.bab575d62fb1a33094160fe3@linux-foundation.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Mar 19, 2019 at 03:19:30PM -0700, Andrew Morton wrote:
> On Sun, 17 Mar 2019 11:34:31 -0700 ira.weiny@intel.com wrote:
> 
> > Resending after rebasing to the latest mm tree.
> > 
> > HFI1, qib, and mthca, use get_user_pages_fast() due to it performance
> > advantages.  These pages can be held for a significant time.  But
> > get_user_pages_fast() does not protect against mapping FS DAX pages.
> > 
> > Introduce FOLL_LONGTERM and use this flag in get_user_pages_fast() which
> > retains the performance while also adding the FS DAX checks.  XDP has also
> > shown interest in using this functionality.[1]
> > 
> > In addition we change get_user_pages() to use the new FOLL_LONGTERM flag and
> > remove the specialized get_user_pages_longterm call.
> 
> It would be helpful to include your response to Christoph's question
> (http://lkml.kernel.org/r/20190220180255.GA12020@iweiny-DESK2.sc.intel.com)
> in the changelog.  Because if one person was wondering about this,
> others will likely do so.
> 
> We have no record of acks or reviewed-by's.  At least one was missed
> (http://lkml.kernel.org/r/CAOg9mSTTcD-9bCSDfC0WRYqfVrNB4TwOzL0c4+6QXi-N_Y43Vw@mail.gmail.com),
> but that is very very partial.

That is my bad.  Sorry to Mike.  And I have added him.

> 
> This patchset is fairly DAX-centered, but Dan wasn't cc'ed!

Agreed, I'm new to changing things which affect this many sub-systems and I
struggled with who should be CC'ed (get_maintainer.pl returned a very large
list  :-(.

I fear I may have cc'ed too many people, and the wrong people apparently, so
that may be affecting the review...

So again my apologies.  I don't know if Dan is going to get a chance to put a
reviewed-by on them this week but I thought I would send this note to let you
know I'm not ignoring your feedback.  Just waiting a bit before resending to
hopefully get some more acks/reviewed bys.

Thanks,
Ira

> 
> So ho hum.  I'll scoop them up and shall make the above changes to the
> [1/n] changelog, but we still have some work to do.
> 
