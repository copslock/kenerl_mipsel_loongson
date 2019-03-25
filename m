Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C668C43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 18:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE942070D
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 18:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfCYS2T (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:28:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:21251 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYS2T (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Mar 2019 14:28:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 11:28:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="125755489"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2019 11:28:17 -0700
Date:   Mon, 25 Mar 2019 03:27:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
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
        James Hogan <jhogan@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RESEND 1/7] mm/gup: Replace get_user_pages_longterm() with
 FOLL_LONGTERM
Message-ID: <20190325102705.GG16366@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-2-ira.weiny@intel.com>
 <CAA9_cmffz1VBOJ0ykBtcj+hiznn-kbbuotu1uUhPiJtXiFjJXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmffz1VBOJ0ykBtcj+hiznn-kbbuotu1uUhPiJtXiFjJXg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Mar 22, 2019 at 02:24:40PM -0700, Dan Williams wrote:
> On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:

[snip]

> > + * __gup_longterm_locked() is a wrapper for __get_uer_pages_locked which
> 
> s/uer/user/
> 
> > + * allows us to process the FOLL_LONGTERM flag if present.
> > + *
> > + * FOLL_LONGTERM Checks for either DAX VMAs or PPC CMA regions and either fails
> > + * the pin or attempts to migrate the page as appropriate.
> > + *
> > + * In the filesystem-dax case mappings are subject to the lifetime enforced by
> > + * the filesystem and we need guarantees that longterm users like RDMA and V4L2
> > + * only establish mappings that have a kernel enforced revocation mechanism.
> > + *
> > + * In the CMA case pages can't be pinned in a CMA region as this would
> > + * unnecessarily fragment that region.  So CMA attempts to migrate the page
> > + * before pinning.
> >   *
> >   * "longterm" == userspace controlled elevated page count lifetime.
> >   * Contrast this to iov_iter_get_pages() usages which are transient.
> 
> Ah, here's the longterm documentation, but if I was a developer
> considering whether to use FOLL_LONGTERM or not I would expect to find
> the documentation at the flag definition site.
> 
> I think it has become more clear since get_user_pages_longterm() was
> initially merged that we need to warn people not to use it, or at
> least seriously reconsider whether they want an interface to support
> indefinite pins.

I will move the comment to the flag definition but...

In reviewing this comment it occurs to me that the addition of special casing
CMA regions via FOLL_LONGTERM has made it less experimental/temporary and now
simply implies intent to the GUP code as to the use of the pages.

As I'm not super familiar with the CMA use case I can't say for certain but it
seems that it is not a temporary solution.

So I'm not going to refrain from a FIXME WRT removing the flag.

New suggested text below.

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6831077d126c..5db9d8e894aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2596,7 +2596,28 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_REMOTE    0x2000  /* we are working on non-current tsk/mm */
 #define FOLL_COW       0x4000  /* internal GUP flag */
 #define FOLL_ANON      0x8000  /* don't do file mappings */
-#define FOLL_LONGTERM  0x10000 /* mapping is intended for a long term pin */
+#define FOLL_LONGTERM  0x10000 /* mapping lifetime is indefinite: see below */
+
+/*
+ * NOTE on FOLL_LONGTERM:
+ *
+ * FOLL_LONGTERM indicates that the page will be held for an indefinite time
+ * period _often_ under userspace control.  This is contrasted with
+ * iov_iter_get_pages() where usages which are transient.
+ *
+ * FIXME: For pages which are part of a filesystem, mappings are subject to the
+ * lifetime enforced by the filesystem and we need guarantees that longterm
+ * users like RDMA and V4L2 only establish mappings which coordinate usage with
+ * the filesystem.  Ideas for this coordination include revoking the longterm
+ * pin, delaying writeback, bounce buffer page writeback, etc.  As FS DAX was
+ * added after the problem with filesystems was found FS DAX VMAs are
+ * specifically failed.  Filesystem pages are still subject to bugs and use of
+ * FOLL_LONGTERM should be avoided on those pages.
+ *
+ * In the CMA case: longterm pins in a CMA region would unnecessarily fragment
+ * that region.  And so CMA attempts to migrate the page before pinning when
+ * FOLL_LONGTERM is specified.
+ */
 
 static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 {

