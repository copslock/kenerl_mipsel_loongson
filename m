Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Aug 2014 03:12:26 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:57467 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860999AbaHBBMLuR0Ln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Aug 2014 03:12:11 +0200
Received: by mail-la0-f51.google.com with SMTP id pn19so3807263lab.10
        for <linux-mips@linux-mips.org>; Fri, 01 Aug 2014 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=n1WjZTxjD2/swqiIEBSXeqjuOI9DNZeM0kQUqfxCCgM=;
        b=pSYI0XZs59MOYv2jbSOqSr0cMmYmbthhNrxzYjeXaL9cUITqgWZS4b7hU1xCytleQj
         XFv66g1O4oFeM5ak9rGCuaCvAxL1um66db6aQ7GKtUKzClodL8cyZSgVjnPJuN2OB+Rz
         TDPhtUakmp/dvMjQyzXtSN8r/nAfolStzBVZEzhrgBZEKIdeEzOGToGW5vY9mHDXvjQx
         eL11iJdLW52s3XNwAdOB3mEQZlr0Ik46yMZtD3l0EtsCljxdzWkHpXV2pC/o5ri3WGgq
         3UTzdu1xDPv1cbVdqubNOVHVaDCAd6VhRZNcxqyBOFYBwDEACYQZfx3f0648gG3m4HJQ
         0t5g==
X-Received: by 10.112.181.9 with SMTP id ds9mr9271083lbc.10.1406941925953;
        Fri, 01 Aug 2014 18:12:05 -0700 (PDT)
Received: from octofox.metropolis ([5.18.160.3])
        by mx.google.com with ESMTPSA id u6sm5611953laj.7.2014.08.01.18.12.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Aug 2014 18:12:04 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@cadence.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Steven Hill <Steven.Hill@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 0/2] mm/highmem: make kmap cache coloring aware
Date:   Sat,  2 Aug 2014 05:11:37 +0400
Message-Id: <1406941899-19932-1-git-send-email-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 1.8.1.4
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Hi,

this series adds mapping color control to the generic kmap code, allowing
architectures with aliasing VIPT cache to use high memory. There's also
use example of this new interface by xtensa.

Changes since v3:
- drop #include <asm/highmem.h> from mm/highmem.c as it's done in
  linux/highmem.h;
- add 'User-visible effect' section to changelog.

Max Filippov (2):
  mm/highmem: make kmap cache coloring aware
  xtensa: support aliasing cache in kmap

 arch/xtensa/include/asm/highmem.h | 40 +++++++++++++++++-
 arch/xtensa/mm/highmem.c          | 18 ++++++++
 mm/highmem.c                      | 86 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 131 insertions(+), 13 deletions(-)

-- 
1.8.1.4
