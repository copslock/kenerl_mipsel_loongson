Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 20:54:36 +0200 (CEST)
Received: from mail2.gnudd.com ([213.203.150.91]:54091 "EHLO mail.gnudd.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903703Ab2EXSy3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 May 2012 20:54:29 +0200
Received: from mail.gnudd.com (localhost [127.0.0.1])
        by mail.gnudd.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id q4OIrSe5016304;
        Thu, 24 May 2012 20:53:28 +0200
Received: (from rubini@localhost)
        by mail.gnudd.com (8.14.3/8.14.3/Submit) id q4OIrPib016299;
        Thu, 24 May 2012 20:53:25 +0200
Date:   Thu, 24 May 2012 20:53:25 +0200
From:   Alessandro Rubini <rubini@gnudd.com>
To:     konrad.wilk@oracle.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        giancarlo.asnaghi@st.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, gxt@mprc.pku.edu.cn,
        tglx@linutronix.de, kyungmin.park@samsung.com,
        fujita.tomonori@lab.ntt.co.jp
Subject: Re: [PATCH] swiotlb: add "dma_attrs" argument to alloc and free,
 to match dma_map_ops
Message-ID: <20120524185325.GA16292@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GnuDD, Device Drivers, Embedded Systems, Courses
In-Reply-To: <20120524174741.GG24934@phenom.dumpdata.com>
References: <20120524174741.GG24934@phenom.dumpdata.com>
  <20120524114422.GA25950@mail.gnudd.com>
X-archive-position: 33448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rubini@gnudd.com
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

>> The alloc and free pointers within "struct dma_map_ops" receive a
>> pointer to dma_attrs that was not present in the generic swiotlb
>> functions.  For this reason, a few files had a local wrapper for the
>> free function that just removes the attrs argument before calling the
>> generic function.
>> 
>> This patch adds the extra argument to generic functions and removes
>> such wrappers when they are no more needed.  This also fixes a
>> compiler warning for sta2x11-fixup.c, that would have required yet
>> another wrapper.

> So .. what is this based on?

Current linux-next. But it has been like this for a while. I had
the warning in sta2x11-fixup.c pending for a while, and yesterday
I raised the issue.

> I see in mainline  alloc_coherent and free_coherent
> which are obviously changed here.

Do you refer to the swiotlb methods (I confirm they are changed, like
all their users) or something else? I'm only changing the two methods
in swiotlb, nothing else is affected.

Actually, I wanted to call them alloc and free, like the field they
are assigned to, but swiotlb_free is already there, to do something
else.
 
> Don't you also need to change these two files:
> 
>  arch/x86/xen/pci-swiotlb-xen.c
>  drivers/xen/swiotlb-xen.c

No, because xen implements the dma_map_ops with the proper prototypes.
I grepped for all users, and found these are not related.

Thank your for checking
/alessandro
