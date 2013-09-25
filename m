Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 19:15:55 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:23788 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816233Ab3IYRN3VoCnO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Sep 2013 19:13:29 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 25 Sep 2013 10:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,979,1371106800"; 
   d="scan'208";a="383450532"
Received: from tcpepper-desk.jf.intel.com ([10.7.197.221])
  by orsmga001.jf.intel.com with SMTP; 25 Sep 2013 10:12:43 -0700
Received: by tcpepper-desk.jf.intel.com (sSMTP sendmail emulation); Wed, 25 Sep 2013 10:12:43 -0700
From:   "Timothy Pepper" <timothy.c.pepper@linux.intel.com>
Date:   Wed, 25 Sep 2013 10:12:43 -0700
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <james.l.morris@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Rik van Riel <riel@redhat.com>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130925073048.GB27960@gmail.com>
X-PGP-Key: http://vato.org/pubkey.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <timothy.c.pepper@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: timothy.c.pepper@linux.intel.com
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

On Wed 25 Sep at 09:30:49 +0200 mingo@kernel.org said:
> >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> >  	info.length = len;
> > -	info.low_limit = PAGE_SIZE;
> > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> >  	info.high_limit = mm->mmap_base;
> >  	info.align_mask = filp ? get_align_mask() : 0;
> >  	info.align_offset = pgoff << PAGE_SHIFT;
> 
> There appears to be a lot of repetition in these methods - instead of 
> changing 6 places it would be more future-proof to first factor out the 
> common bits and then to apply the fix to the shared implementation.

Besides that existing redundancy in the multiple somewhat similar
arch_get_unmapped_area_topdown() functions, I was expecting people might
question the added redundancy of the six instances of:

	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

There's also a seventh similar instance if you consider
mm/mmap.c:round_hint_to_min() and its call stack.  I'm inclined to
think mmap_min_addr should be validated/aligned in one place, namely on
initialization and input in security/min_addr.c:update_mmap_min_addr(),
with mmap_min_addr always stored as an aligned value.

In the past commit 40401530 Al Viro arguably moved that checking out
of the security code and toward the mmap code.  Granted at that point
though there was only the round_hint_to_min() insuring the value in
mmap_min_addr was page aligned before use in that call path.  I'm thinking
something like:

diff --git a/security/min_addr.c b/security/min_addr.c
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -14,14 +14,16 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
  */
 static void update_mmap_min_addr(void)
 {
+	unsigned long addr;
 #ifdef CONFIG_LSM_MMAP_MIN_ADDR
 	if (dac_mmap_min_addr > CONFIG_LSM_MMAP_MIN_ADDR)
-		mmap_min_addr = dac_mmap_min_addr;
+		addr = dac_mmap_min_addr;
 	else
-		mmap_min_addr = CONFIG_LSM_MMAP_MIN_ADDR;
+		addr = CONFIG_LSM_MMAP_MIN_ADDR;
 #else
-	mmap_min_addr = dac_mmap_min_addr;
+	addr = dac_mmap_min_addr;
 #endif
+	mmap_min_addr = max(PAGE_SIZE, PAGE_ALIGN(addr));
 }
 
 /*

But this possibly has implications beyond the mmap code.

Al Viro, James Morris: any thoughts on the above?

Michel, Rik: what do you think of common helpers called by
ARM, MIPS, SH, Sparc, x86_64 arch_get_unmapped_area_topdown()
and arch_get_unmapped_area() to handle initialization of struct
vm_unmapped_area_info info fields which are currently mostly common?
Given the nuances of "mostly common" I'm not sure the result would
actually be positive for overall readability / self-documenting-ness of
the per arch files.

-- 
Tim Pepper <timothy.c.pepper@linux.intel.com>
Intel Open Source Technology Center
