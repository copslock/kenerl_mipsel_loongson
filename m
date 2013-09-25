Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 07:27:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46713 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819313Ab3IYF1RlDFYc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Sep 2013 07:27:17 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8P5RGaX018652;
        Wed, 25 Sep 2013 07:27:16 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8P5RFd0018651;
        Wed, 25 Sep 2013 07:27:15 +0200
Date:   Wed, 25 Sep 2013 07:27:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: 74K/1074K support
Message-ID: <20130925052715.GB473@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Commit 006a851b10a395955c153a145ad8241494d43688 adds 74K support in c-r4k.c:

+static inline void alias_74k_erratum(struct cpuinfo_mips *c)
+{
+       /*
+        * Early versions of the 74K do not update the cache tags on a
+        * vtag miss/ptag hit which can occur in the case of KSEG0/KUSEG
+        * aliases. In this case it is better to treat the cache as always
+        * having aliases.
+        */
+       if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
+               c->dcache.flags |= MIPS_CACHE_VTAG;
+       if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
+               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+       if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
+           ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
+               c->dcache.flags |= MIPS_CACHE_VTAG;
+               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
+       }
+}

But MIPS D-caches are never virtually tagged, so there is nothing in
the kernel that ever tests the MIPS_CACHE_VTAG flag in a D-cache
descriptor.

Cargo cult programming at its finest?  Or was MIPS_CACHE_ALIASES what
really was meant to be set?

  Ralf
