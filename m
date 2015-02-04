Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 17:25:19 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:41397 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012514AbbBDQZRfz9g9 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 17:25:17 +0100
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP; 04 Feb 2015 08:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,518,1418112000"; 
   d="scan'208";a="522505122"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga003.jf.intel.com with ESMTP; 04 Feb 2015 08:17:30 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Wed, 4 Feb 2015 08:25:09 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.89]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.103]) with mapi id 14.03.0195.001;
 Wed, 4 Feb 2015 08:25:08 -0800
From:   "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: RE: mips: Re-introduce copy_user_page
Thread-Topic: mips: Re-introduce copy_user_page
Thread-Index: AQHQP+Dc9wfYcGSMQU6+AGJBA2rhxpzfTD2w
Date:   Wed, 4 Feb 2015 16:25:08 +0000
Message-ID: <100D68C7BA14664A8938383216E40DE04085641F@FMSMSX114.amr.corp.intel.com>
References: <1422681807-28395-1-git-send-email-linux@roeck-us.net>
 <54D11608.2070408@imgtec.com>
In-Reply-To: <54D11608.2070408@imgtec.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <matthew.r.wilcox@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthew.r.wilcox@intel.com
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

There is no 'struct page' for the source of this data.  We have a kernel address for it; that's all.

-----Original Message-----
From: Leonid Yegoshin [mailto:Leonid.Yegoshin@imgtec.com] 
Sent: Tuesday, February 03, 2015 10:40 AM
To: Guenter Roeck; Ralf Baechle
Cc: linux-mips@linux-mips.org; linux-kernel@vger.kernel.org; Atsushi Nemoto; Wilcox, Matthew R
Subject: Re: mips: Re-introduce copy_user_page

On 01/30/2015 09:23 PM, Guenter Roeck wrote:
> Commit bcd022801ee5 ("MIPS: Fix COW D-cache aliasing on fork") replaced
> the inline function copy_user_page for mips with an external reference,
> but neglected to introduce the actual non-inline function. Restore it.
>
> Fixes: bcd022801ee5 ("MIPS: Fix COW D-cache aliasing on fork")
> Fixes: 4927b7d77c00 ("dax,ext2: replace the XIP page fault handler with the DAX page fault handler")
> Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: Matthew Wilcox <matthew.r.wilcox@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>

Why do you use copy_user_page?
It doesn't work properly in HIGHMEM environment and it is excluded from 
MIPS because of that, I believe.

You should use copy_user_highpage() for user pages.

- Leonid.
