Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 21:45:50 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:31939 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012652AbbBEUpszPHjM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 21:45:48 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 05 Feb 2015 12:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,525,1418112000"; 
   d="scan'208";a="681574485"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2015 12:45:28 -0800
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 5 Feb 2015 12:45:27 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.89]) by
 FMSMSX119.amr.corp.intel.com ([169.254.14.146]) with mapi id 14.03.0195.001;
 Thu, 5 Feb 2015 12:45:26 -0800
From:   "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "Wu, Fengguang" <fengguang.wu@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.arm.linux.org.uk" 
        <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: RE: [next:master 4658/4676] undefined reference to `copy_user_page'
Thread-Topic: [next:master 4658/4676] undefined reference to `copy_user_page'
Thread-Index: AQHQQYFPWxPjAj38PUadBZCgaalnBJzif8vQgACHLQD//30oMA==
Date:   Thu, 5 Feb 2015 20:45:26 +0000
Message-ID: <100D68C7BA14664A8938383216E40DE0408569A1@FMSMSX114.amr.corp.intel.com>
References: <201501221315.sbz4rdsB%fengguang.wu@intel.com>
        <100D68C7BA14664A8938383216E40DE040853FB4@FMSMSX114.amr.corp.intel.com>
        <20150205122115.8fe1037870b76d75afc3fb03@linux-foundation.org>
        <100D68C7BA14664A8938383216E40DE040856952@FMSMSX114.amr.corp.intel.com>
 <20150205122552.1485c1439ec6c019e9443c51@linux-foundation.org>
In-Reply-To: <20150205122552.1485c1439ec6c019e9443c51@linux-foundation.org>
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
X-archive-position: 45735
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

MIPS: https://lkml.org/lkml/2015/1/31/1
ARM: https://marc.info/?l=linaro-kernel&m=142253251904005&w=3

-----Original Message-----
From: Andrew Morton [mailto:akpm@linux-foundation.org] 
Sent: Thursday, February 05, 2015 12:26 PM
To: Wilcox, Matthew R
Cc: Wu, Fengguang; kbuild-all@01.org; Linux Memory Management List; linux-mips@linux-mips.org; linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [next:master 4658/4676] undefined reference to `copy_user_page'

On Thu, 5 Feb 2015 20:22:34 +0000 "Wilcox, Matthew R" <matthew.r.wilcox@intel.com> wrote:

> 
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> Sent: Thursday, February 05, 2015 12:21 PM
> To: Wilcox, Matthew R
> Cc: Wu, Fengguang; kbuild-all@01.org; Linux Memory Management List; linux-mips@linux-mips.org; linux-arm-kernel@lists.arm.linux.org.uk
> Subject: Re: [next:master 4658/4676] undefined reference to `copy_user_page'
> 
> On Thu, 22 Jan 2015 15:12:15 +0000 "Wilcox, Matthew R" <matthew.r.wilcox@intel.com> wrote:
> 
> > Looks like mips *declares* copy_user_page(), but never *defines* an implementation.
> > 
> > It's documented in Documentation/cachetlb.txt, but it's not (currently) called if the architecture defines its own copy_user_highpage(), so some bitrot has occurred.  ARM is currently fixing this, and MIPS will need to do the same.
> > 
> > (We can't use copy_user_highpage() in DAX because we don't necessarily have a struct page for 'from'.)
> 
> > Has there been any progress on this?  It would be unpleasant to merge
> > DAX into 3.19 and break MIPS and ARM.
>
> Yes, both MIPS and ARM have sent patches out for this.

I'm not seeing either in linux-next.
