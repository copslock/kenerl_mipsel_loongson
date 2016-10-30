Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Oct 2016 17:06:08 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:35852 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992279AbcJ3QGBcZxF1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Oct 2016 17:06:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From;
        bh=EU3j0TETzzFd+EglisYIbsU6vuTu33XA6fT6G+jwZX0=; b=PlWTlJuUyMdv4pYAyk5vSfihdZ
        2eRGWlnTNh+NWCZJzjBXZ9F0+OGRjIyupAhF2YDmm+ENXgp41VgkQC+6qiI4sEpuuMPCRXnClQ9GH
        nEW2A8IZUoaG2cVnZ80K8AmIXBDcKOQIIPqRhwHjv5JEnVLVZ/xfq/SxuIX2WghttuclCTTV1pZVl
        NJ/hZ0XWUzUJp8O0R5AxZOqStpYP0GjCRSvT32T/sCOZk0q+DMWVQgCkIf6dk150bqOXfKbtS1/W1
        oytGfuidnsTMRQC0JWMhcjO8hN+pChRCbsk1f2Mrn5w2FcyOxODn7zO2iHSEhybcznKuU7QxzHqWg
        V0seJU2Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59962 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1c0scI-002ROL-B7; Sun, 30 Oct 2016 16:05:50 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alex Smith <alex.smith@imgtec.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: VDSO: Always select -msoft-float
Date:   Sun, 30 Oct 2016 09:05:51 -0700
Message-Id: <1477843551-21813-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.5.0
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Some toolchains fail to build mips images with the following build error.

arch/mips/vdso/gettimeofday.c:1:0: error: '-march=r3000' requires '-mfp32'

This is seen, for example, with the 'mipsel-linux-gnu-gcc (Debian 6.1.1-9)
6.1.1 20160705' toolchain as used by the 0Day build robot when building
decstation_defconfig.

Comparison of compile flags suggests that the major difference is a missing
'-soft-float', which is otherwise defined unconditionally.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: James Hogan <james.hogan@imgtec.com>
Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index c3dc12a8b7d9..9bdd6641400f 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -6,7 +6,8 @@ ccflags-vdso := \
 	$(filter -I%,$(KBUILD_CFLAGS)) \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
 	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
-	$(filter -march=%,$(KBUILD_CFLAGS))
+	$(filter -march=%,$(KBUILD_CFLAGS)) \
+	-msoft-float
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-- 
2.5.0
