Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 11:39:41 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34019 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025647AbbAFKjkG799K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 11:39:40 +0100
Received: by mail-pa0-f54.google.com with SMTP id fb1so30788774pad.13;
        Tue, 06 Jan 2015 02:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=bCGqhixga7JEilR2+DPaywj2/cyQ4HaTGfUNejd7oz0=;
        b=cP2EISkpIWxhOmrS1gIDuGdDlhhihXfRgDrgLoleNlCVM+HxWoqROtKg3q3F7Y88sD
         wVBC55gMTwZYi8zku7NPaFSmZJflxZZM/ZFSzFK4vxK2gPDKux+vTnj/fqz14pvAiMy0
         zCkmNpRegthXZc7BFvbFhUdMkT5pDaTTALkgf+Ix+I91Geg/+5eE7zyVogS6tu6KYsdr
         Bhx9YDrp9Iy6wDDTEBxbVwPheQDhEpidyv9SumqQyadYr6xNK8YxIIQkCej3S9Y6mhal
         8qmaoOS6Xj5iNIqjvoaFyuplzJ1m4dpB4lPfKnynnQlVIm7RlNQxFHwOSqyJO9QjCbbY
         qeTg==
X-Received: by 10.68.233.170 with SMTP id tx10mr69055471pbc.89.1420540773742;
        Tue, 06 Jan 2015 02:39:33 -0800 (PST)
Received: from yggdrasil (111-243-150-104.dynamic.hinet.net. [111.243.150.104])
        by mx.google.com with ESMTPSA id cf4sm56633243pbb.3.2015.01.06.02.39.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jan 2015 02:39:32 -0800 (PST)
Date:   Tue, 6 Jan 2015 18:39:28 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, macro@linux-mips.org
Cc:     linux-mips@linux-mips.org, Steven.Hill@imgtec.com,
        Leonid.Yegoshin@imgtec.com
Subject: [PATCH] MIPS: 74K/1074K: Fix typo in erratum workaround.
Message-ID: <20150106183732-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

In commit 9213ad (MIPS: 74K/1074K: Correct erratum workaround.),
MIPS_CACHE_VTAG should go to icache.flags.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index dd261df..deebd0b 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -902,13 +902,13 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
 	switch (imp) {
 	case PRID_IMP_74K:
 		if (rev <= PRID_REV_ENCODE_332(2, 4, 0))
-			c->dcache.flags |= MIPS_CACHE_VTAG;
+			c->icache.flags |= MIPS_CACHE_VTAG;
 		if (rev == PRID_REV_ENCODE_332(2, 4, 0))
 			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
 		break;
 	case PRID_IMP_1074K:
 		if (rev <= PRID_REV_ENCODE_332(1, 1, 0)) {
-			c->dcache.flags |= MIPS_CACHE_VTAG;
+			c->icache.flags |= MIPS_CACHE_VTAG;
 			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
 		}
 		break;
