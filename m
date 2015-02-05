Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 21:26:00 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41719 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012645AbbBEUZ7PTEwN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 21:25:59 +0100
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 396A1ACE;
        Thu,  5 Feb 2015 20:25:53 +0000 (UTC)
Date:   Thu, 5 Feb 2015 12:25:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>
Cc:     "Wu, Fengguang" <fengguang.wu@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.arm.linux.org.uk" 
        <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [next:master 4658/4676] undefined reference to `copy_user_page'
Message-Id: <20150205122552.1485c1439ec6c019e9443c51@linux-foundation.org>
In-Reply-To: <100D68C7BA14664A8938383216E40DE040856952@FMSMSX114.amr.corp.intel.com>
References: <201501221315.sbz4rdsB%fengguang.wu@intel.com>
        <100D68C7BA14664A8938383216E40DE040853FB4@FMSMSX114.amr.corp.intel.com>
        <20150205122115.8fe1037870b76d75afc3fb03@linux-foundation.org>
        <100D68C7BA14664A8938383216E40DE040856952@FMSMSX114.amr.corp.intel.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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
